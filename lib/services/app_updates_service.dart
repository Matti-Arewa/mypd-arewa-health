import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

/// Modellklasse für App-Updates und Produktneuigkeiten
class AppUpdate {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String imageUrl;
  final String type; // z.B. 'feature', 'bugfix', 'announcement', 'milestone'
  final String? version; // Optional: App-Version, mit der das Update verbunden ist
  final String? detailLink; // Optional: Link zu weiteren Informationen
  final Map<String, dynamic>? additionalInfo; // Optionale zusätzliche Informationen

  AppUpdate({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.imageUrl,
    required this.type,
    this.version,
    this.detailLink,
    this.additionalInfo,
  });

  // Fabrikmethode zum Erstellen aus JSON
  factory AppUpdate.fromJson(Map<String, dynamic> json) {
    return AppUpdate(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      imageUrl: json['imageUrl'] as String,
      type: json['type'] as String,
      version: json['version'] as String?,
      detailLink: json['detailLink'] as String?,
      additionalInfo: json['additionalInfo'] as Map<String, dynamic>?,
    );
  }
}

/// Service zum Laden und Verwalten von App-Updates
class AppUpdatesService {
  static final AppUpdatesService instance = AppUpdatesService._internal();

  // Private Konstruktor
  AppUpdatesService._internal();

  List<AppUpdate> _cachedUpdates = [];
  String _currentLanguage = 'en';  // Standardsprache
  bool _isLoading = false;

  // Getter für aktuelle Updates
  List<AppUpdate> get updates => List.unmodifiable(_cachedUpdates);
  bool get isLoading => _isLoading;

  // Updates für die angegebene Sprache laden
  Future<List<AppUpdate>> loadUpdates(String languageCode) async {
    if (languageCode == _currentLanguage && _cachedUpdates.isNotEmpty) {
      return _cachedUpdates;
    }

    _isLoading = true;
    _currentLanguage = languageCode;

    try {
      if (kDebugMode) {
        print('AppUpdatesService: Lade Updates für Sprache: $languageCode');
      }

      // JSON-Datei aus den Assets laden
      final String jsonString = await rootBundle.loadString('assets/updates/$languageCode.json');
      final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;

      // JSON in Update-Objekte umwandeln
      _cachedUpdates = jsonList
          .map((json) => AppUpdate.fromJson(json as Map<String, dynamic>))
          .toList();

      // Nach Datum sortieren (neueste zuerst)
      _cachedUpdates.sort((a, b) => b.date.compareTo(a.date));

      if (kDebugMode) {
        print('AppUpdatesService: ${_cachedUpdates.length} Updates geladen');
      }

      return _cachedUpdates;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('AppUpdatesService: Fehler beim Laden der Updates - $e');
        print('AppUpdatesService: Stack Trace - $stackTrace');
      }
      _cachedUpdates = [];
      return [];
    } finally {
      _isLoading = false;
    }
  }

  // Update anhand seiner ID suchen
  AppUpdate? findUpdateById(String id) {
    try {
      return _cachedUpdates.firstWhere((update) => update.id == id);
    } catch (e) {
      if (kDebugMode) {
        print('AppUpdatesService: Update mit ID $id nicht gefunden');
      }
      return null;
    }
  }

  // Neueste Updates zurückgeben (begrenzte Anzahl)
  List<AppUpdate> getLatestUpdates(int count) {
    if (_cachedUpdates.isEmpty) {
      return [];
    }

    return _cachedUpdates.take(count).toList();
  }

  // Updates nach Typ filtern
  List<AppUpdate> getUpdatesByType(String type) {
    return _cachedUpdates.where((update) => update.type == type).toList();
  }
}