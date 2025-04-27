import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../providers/content_provider.dart';
import 'package:flutter/foundation.dart';

class LanguageProvider with ChangeNotifier {
  final ContentProvider _contentProvider;
  late String _currentLanguage;
  bool _isInitialized = false;

  LanguageProvider(this._contentProvider) {
    _loadLanguage();
  }

  String get currentLanguage => _currentLanguage;

  bool get isInitialized => _isInitialized;

  Future<void> _loadLanguage() async {
    if (kDebugMode) {
      print("LanguageProvider: Loading language preference");
    }

    try {
      final settingsBox = Hive.box('appSettings');
      _currentLanguage =
          settingsBox.get('preferredLanguage', defaultValue: 'en');

      if (kDebugMode) {
        print("LanguageProvider: Language loaded from Hive: $_currentLanguage");
      }

      // Initialize content provider with correct language immediately
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        try {
          if (kDebugMode) {
            print(
                "LanguageProvider: Initializing ContentProvider with $_currentLanguage");
          }
          // Use the new initialization method
          await _contentProvider.initializeContent(_currentLanguage);
          _isInitialized = true;
          notifyListeners();
        } catch (e) {
          if (kDebugMode) {
            print("LanguageProvider: Error initializing content: $e");
          }
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print("LanguageProvider: Error loading language: $e");
      }
      // Fall back to English
      _currentLanguage = 'en';
      _contentProvider.updateLanguage('en');
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    if (_currentLanguage != languageCode) {
      if (kDebugMode) {
        print(
            "LanguageProvider: Changing language from $_currentLanguage to $languageCode");
      }

      _currentLanguage = languageCode;

      // Save to persistent storage
      try {
        final settingsBox = Hive.box('appSettings');
        await settingsBox.put('preferredLanguage', languageCode);
      } catch (e) {
        if (kDebugMode) {
          print("LanguageProvider: Error saving language preference: $e");
        }
        // Continue even if saving fails
      }

      // Update ContentProvider with new language and wait for completion
      try {
        await _contentProvider.updateLanguage(languageCode);
      } catch (e) {
        if (kDebugMode) {
          print("LanguageProvider: Error updating content language: $e");
        }
      }

      notifyListeners();
    }
  }

  // Force a content reload with current language
  Future<void> reloadContent() async {
    try {
      await _contentProvider.updateLanguage(_currentLanguage);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("LanguageProvider: Error reloading content: $e");
      }
    }
  }

  // Get language name for display
  String getLanguageName(String langCode) {
    switch (langCode) {
      case 'en':
        return 'English';
      case 'de':
        return 'Deutsch';
      case 'fr':
        return 'Français';
      default:
        return 'English';
    }
  }
}