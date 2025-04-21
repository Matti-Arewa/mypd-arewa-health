import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'services/localization_service.dart';
import 'providers/user_provider.dart';
import 'providers/content_provider.dart';
import 'providers/language_provider.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';
// Import other screens as needed

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  await Hive.openBox('appSettings');
  await Hive.openBox('content');
  await Hive.openBox('favorites');


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ContentProvider()),
        ChangeNotifierProxyProvider<ContentProvider, LanguageProvider>(
          create: (context) => LanguageProvider(Provider.of<ContentProvider>(context, listen: false)),
          update: (context, contentProvider, previous) =>
          previous ?? LanguageProvider(contentProvider),
        ),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const AppWithLanguage(),
    );
  }
}

class AppWithLanguage extends StatelessWidget {
  const AppWithLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    // Die Key-Eigenschaft ist entscheidend hier - sie zwingt Flutter, die ganze App
    // neu aufzubauen, wenn sich der Sprachcode ändert
    final languageProvider = Provider.of<LanguageProvider>(context);

    // Gemeinsame Eigenschaften für beide Plattformen
    final Locale locale = Locale(languageProvider.currentLanguage);
    const String title = 'Pregnancy Guide';
    final Color primaryColor = Colors.pink[300]!;

    // iOS spezifische App-Implementierung
    if (Platform.isIOS) {
      return CupertinoApp(
        key: ValueKey('ios_${languageProvider.currentLanguage}'),
        title: title,
        theme: CupertinoThemeData(
          primaryColor: primaryColor,
          brightness: Brightness.light,
          textTheme: const CupertinoTextThemeData(
            navLargeTitleTextStyle: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: CupertinoColors.label,
            ),
            navTitleTextStyle: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: CupertinoColors.label,
            ),
            textStyle: TextStyle(
              fontFamily: 'Poppins',
              color: CupertinoColors.label,
            ),
          ),
        ),
        home: const HomeScreen(), // Weiterhin HomeScreen als Startpunkt verwenden
        routes: {
          SettingsScreen.routeName: (ctx) => const SettingsScreen(),
          // Add other routes here
        },
        // Localization setup
        locale: locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: [
          ...AppLocalizations.localizationsDelegates,
          DefaultCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: AppLocalizations.localeResolutionCallback,
      );
    }
    // Android/andere Plattformen verwenden MaterialApp
    else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        key: ValueKey('android_${languageProvider.currentLanguage}'),
        title: title,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          useMaterial3: true,
          fontFamily: 'Poppins',
        ),
        home: const HomeScreen(), // Weiterhin HomeScreen als Startpunkt verwenden
        routes: {
          SettingsScreen.routeName: (ctx) => const SettingsScreen(),
          // Add other routes here
        },
        // Localization setup
        locale: locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        localeResolutionCallback: AppLocalizations.localeResolutionCallback,
      );
    }
  }
}