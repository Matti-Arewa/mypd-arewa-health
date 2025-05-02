// lib/services/config.dart
import 'package:flutter/foundation.dart';

/// Konfigurationsklasse als Alternative zur .env-Datei
/// Diese Datei sollte NICHT in Git gespeichert werden!
class AppConfig {
  AppConfig._(); // Private Konstruktor

  static final AppConfig _instance = AppConfig._();
  static AppConfig get instance => _instance;

  // MailGun Konfiguration
  final String mailgunApiKey = 'df4df84d0e828b76dd032f8bb63ec400-67bd41c2-2f8af77e';
  final String mailgunDomain = 'sandbox7de465875dce4c77bf4e2ac0a6bea52c.mailgun.org';
  final String mailgunRegion = 'us'; // 'eu' oder 'us'

  // Email-Konfiguration
  final String feedbackToEmail = 'matti@arewa-health.com';
  String get feedbackFromEmail => 'app@$mailgunDomain';

  // Debug-Informationen ausgeben
  void logConfig() {
    if (kDebugMode) {
      print('AppConfig: Mailgun Domain: $mailgunDomain');
      print('AppConfig: Mailgun Region: $mailgunRegion');
      print('AppConfig: Feedback To: $feedbackToEmail');
      print('AppConfig: Feedback From: $feedbackFromEmail');
      // API Key wird aus Sicherheitsgründen nicht geloggt
    }
  }
}