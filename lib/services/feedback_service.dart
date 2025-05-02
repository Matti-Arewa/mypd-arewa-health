import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../services/config.dart';

class FeedbackService {
  // Private constructor prevents direct instantiation
  FeedbackService._();
  static final FeedbackService _instance = FeedbackService._();

  // Singleton instance
  static FeedbackService get instance => _instance;

  // Constants for Hive storage
  static const String _feedbackBoxName = 'appSettings';
  static const String _hasSentFeedbackKey = 'hasSentFeedback';
  static const String _lastFeedbackDateKey = 'lastFeedbackDate';
  static const String _feedbackContentKey = 'lastFeedbackContent';

  // Flag to track initialization status
  bool _isInitialized = false;

  // Initialize the service
  Future<void> initialize() async {
    try {
      // Keine .env-Datei mehr laden, stattdessen direkt die Config verwenden

      // Validiere Konfiguration
      final config = AppConfig.instance;
      if (config.mailgunApiKey.isEmpty ||
          config.mailgunDomain.isEmpty ||
          config.feedbackToEmail.isEmpty) {
        print('FeedbackService: Konfiguration unvollständig!');
        throw Exception('Unvollständige Konfiguration in AppConfig');
      }

      print('FeedbackService: Initialisierung erfolgreich');

      _isInitialized = true;
    } catch (e, stackTrace) {
      print('FeedbackService: Fehler bei der Initialisierung - $e');
      print('FeedbackService: Stack Trace - $stackTrace');
      rethrow;
    }
  }

  // Send feedback via Mailgun
  Future<bool> sendFeedback({
    required String message,
    String? language,
    String? appVersion,
  }) async {
    if (!_isInitialized) {
      print('FeedbackService: Nicht initialisiert. Rufe initialize() zuerst auf.');
      return false;
    }

    try {
      print('FeedbackService: Sende Feedback...');

      final config = AppConfig.instance;

      // Determine Mailgun base URL based on region
      final baseUrl = config.mailgunRegion == 'eu'
          ? 'https://api.eu.mailgun.net/v3'
          : 'https://api.mailgun.net/v3';

      final url = Uri.parse('$baseUrl/${config.mailgunDomain}/messages');
      print('FeedbackService: Sende an URL: $url');

      // Prepare email content
      final subject = 'App Feedback${language != null ? ' [$language]' : ''}';
      final emailBody = '''
App Feedback:
---------------------
$message

---------------------
Language: ${language ?? 'Not specified'}
App Version: ${appVersion ?? 'Not specified'}
Date: ${DateTime.now().toIso8601String()}
''';

      print('FeedbackService: Email-Inhalt vorbereitet');

      // Prepare request
      final authHeader = 'Basic ${base64Encode(utf8.encode('api:${config.mailgunApiKey}'))}';
      print('FeedbackService: Auth-Header erstellt (gekürzt): ${authHeader.substring(0, 15)}...');

      print('FeedbackService: Sende HTTP-Anfrage...');
      final response = await http.post(
        url,
        headers: {
          'Authorization': authHeader,
        },
        body: {
          'from': config.feedbackFromEmail,
          'to': config.feedbackToEmail,
          'subject': subject,
          'text': emailBody,
        },
      );

      print('FeedbackService: HTTP-Antwort erhalten - Status: ${response.statusCode}');
      if (response.statusCode != 200) {
        print('FeedbackService: Antwort-Body: ${response.body}');
      }

      final success = response.statusCode == 200;

      if (success) {
        print('FeedbackService: Feedback erfolgreich gesendet');

        // Store feedback status
        await _saveFeedbackStatus(message);

        return true;
      } else {
        print('FeedbackService: Feedback konnte nicht gesendet werden. Status-Code: ${response.statusCode}');
        print('FeedbackService: Antwort-Body: ${response.body}');
        return false;
      }
    } catch (e, stackTrace) {
      print('FeedbackService: Fehler beim Senden des Feedbacks - $e');
      print('FeedbackService: Stack Trace - $stackTrace');
      return false;
    }
  }

  // Save feedback status to Hive
  Future<void> _saveFeedbackStatus(String message) async {
    try {
      print('FeedbackService: Speichere Feedback-Status in Hive...');
      final box = Hive.box(_feedbackBoxName);

      // Store feedback status
      await box.put(_hasSentFeedbackKey, true);
      await box.put(_lastFeedbackDateKey, DateTime.now().toIso8601String());
      await box.put(_feedbackContentKey, message);

      print('FeedbackService: Feedback-Status erfolgreich in Hive gespeichert');
    } catch (e, stackTrace) {
      print('FeedbackService: Fehler beim Speichern des Feedback-Status - $e');
      print('FeedbackService: Stack Trace - $stackTrace');
    }
  }

  // Check if user has already sent feedback
  Future<bool> hasUserSentFeedback() async {
    try {
      print('FeedbackService: Prüfe Feedback-Status...');
      final box = Hive.box(_feedbackBoxName);
      final hasSentFeedback = box.get(_hasSentFeedbackKey, defaultValue: false) as bool;

      if (hasSentFeedback) {
        final lastDate = box.get(_lastFeedbackDateKey, defaultValue: 'unbekannt');
        print('FeedbackService: Benutzer hat bereits Feedback am $lastDate gesendet');
      } else {
        print('FeedbackService: Benutzer hat noch kein Feedback gesendet');
      }

      return hasSentFeedback;
    } catch (e, stackTrace) {
      print('FeedbackService: Fehler beim Prüfen des Feedback-Status - $e');
      print('FeedbackService: Stack Trace - $stackTrace');
      return false;
    }
  }

  // Get last feedback content (could be useful for pre-filling)
  Future<String?> getLastFeedbackContent() async {
    try {
      print('FeedbackService: Hole letzten Feedback-Inhalt...');
      final box = Hive.box(_feedbackBoxName);
      return box.get(_feedbackContentKey) as String?;
    } catch (e, stackTrace) {
      print('FeedbackService: Fehler beim Holen des letzten Feedback-Inhalts - $e');
      print('FeedbackService: Stack Trace - $stackTrace');
      return null;
    }
  }

  // Reset feedback status (for testing or if user wants to give feedback again)
  Future<void> resetFeedbackStatus() async {
    try {
      print('FeedbackService: Setze Feedback-Status zurück...');
      final box = Hive.box(_feedbackBoxName);
      await box.delete(_hasSentFeedbackKey);
      await box.delete(_lastFeedbackDateKey);
      await box.delete(_feedbackContentKey);

      print('FeedbackService: Feedback-Status erfolgreich zurückgesetzt');
    } catch (e, stackTrace) {
      print('FeedbackService: Fehler beim Zurücksetzen des Feedback-Status - $e');
      print('FeedbackService: Stack Trace - $stackTrace');
    }
  }
}