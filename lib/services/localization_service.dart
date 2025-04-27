import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalizations {
  final Locale locale;
  Map<String, String> _localizedStrings = {};

  AppLocalizations(this.locale);

  // Helper method to keep the code in the widgets concise
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();

  static List<Locale> supportedLocales = [
    const Locale('en', ''), // English
    const Locale('de', ''), // German
    const Locale('fr', ''), // French
  ];

  static List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    // A class which loads the translations from JSON files
    AppLocalizations.delegate,
    // Built-in localization of basic text for Material widgets
    GlobalMaterialLocalizations.delegate,
    // Built-in localization for text direction LTR/RTL
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  // Static method to determine the locale based on the device settings
  static Locale localeResolutionCallback(
      Locale? locale, Iterable<Locale> supportedLocales) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale?.languageCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  }

  Future<bool> load() async {
    // Load the language JSON file from the "lang" folder
    String jsonString =
    await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key, [Map<String, String>? args]) {
    String text = _localizedStrings[key] ?? key;

    // Replace placeholders with provided arguments if any
    if (args != null) {
      args.forEach((key, value) {
        text = text.replaceAll('{$key}', value);
      });
    }

    return text;
  }
}

// LocalizationsDelegate is a factory for a set of localized resources
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  // This delegate instance will never change
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return ['en', 'de', 'fr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

// Extension to make it easier to use
extension LocalizationExtension on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);
  String tr(String key, [Map<String, String>? args]) => AppLocalizations.of(this).translate(key, args);
}