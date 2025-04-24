import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../providers/content_provider.dart';
import 'package:flutter/foundation.dart';

class LanguageProvider with ChangeNotifier {
  final ContentProvider _contentProvider;
  late String _currentLanguage;

  LanguageProvider(this._contentProvider) {
    _loadLanguage();
  }

  String get currentLanguage => _currentLanguage;

// In language_provider.dart

  void _loadLanguage() {
    final settingsBox = Hive.box('appSettings');
    _currentLanguage = settingsBox.get('preferredLanguage', defaultValue: 'en');

    // Nach dem Build-Prozess ausführen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _contentProvider.updateLanguage(_currentLanguage);
    });
  }

// In language_provider.dart
  Future<void> changeLanguage(String languageCode) async {
    if (_currentLanguage != languageCode) {
      _currentLanguage = languageCode;

      // Speichern in persistenten Speicher
      final settingsBox = Hive.box('appSettings');
      await settingsBox.put('preferredLanguage', languageCode);

      // Warte auf den nächsten Frame, bevor der ContentProvider aktualisiert wird
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await _contentProvider.updateLanguage(languageCode);
        notifyListeners();
      });
    }
  }

  // Get language name for display
  String getLanguageName(String langCode) {
    switch (langCode) {
      case 'en':
        return 'English';
      case 'de':
        return 'Deutsch';
      default:
        return 'English';
    }
  }
}