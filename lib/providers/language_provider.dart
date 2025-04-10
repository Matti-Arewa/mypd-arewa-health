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

  void _loadLanguage() {
    final settingsBox = Hive.box('appSettings');
    _currentLanguage = settingsBox.get('preferredLanguage', defaultValue: 'en');

    // Update content provider with the current language
    _contentProvider.updateLanguage(_currentLanguage);
  }

  Future<void> changeLanguage(String languageCode) async {
    if (_currentLanguage != languageCode) {
      if (kDebugMode) {
        print("Changing language from $_currentLanguage to $languageCode");
      }

      _currentLanguage = languageCode;

      // Save to persistent storage
      final settingsBox = Hive.box('appSettings');
      await settingsBox.put('preferredLanguage', languageCode);

      // Update content with new language
      await _contentProvider.updateLanguage(languageCode);

      // Notify all listeners to rebuild
      notifyListeners();
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