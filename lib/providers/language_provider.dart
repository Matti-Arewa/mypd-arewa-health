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

    // Ensure content is loaded with the correct language immediately
    // This is crucial for first-time app initialization
    if (kDebugMode) {
      print("LanguageProvider: Initial language load: $_currentLanguage");
    }

    // Use addPostFrameCallback to ensure this happens after the current build
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // We now await the content update to ensure it's completed before app continues
      await _contentProvider.updateLanguage(_currentLanguage);
    });
  }

  Future<void> changeLanguage(String languageCode) async {
    if (_currentLanguage != languageCode) {
      _currentLanguage = languageCode;

      // Save to persistent storage
      final settingsBox = Hive.box('appSettings');
      await settingsBox.put('preferredLanguage', languageCode);

      // Wait for the ContentProvider to update before notifying listeners
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (kDebugMode) {
          print("LanguageProvider: Changing language to: $languageCode");
        }

        // Await the content update to ensure it's completed
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