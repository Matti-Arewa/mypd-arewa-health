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
import 'providers/settings_provider.dart'; // Add this if not already imported
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/help_screen.dart'; // Import the new help screen
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Open Hive boxes in try-catch blocks to handle potential errors
  try {
    await Hive.openBox('appSettings');
    if (kDebugMode) {
      print("Main: Successfully opened appSettings box");
    }
  } catch (e) {
    if (kDebugMode) {
      print("Main: Error opening appSettings box: $e");
    }
    // Delete the box if it's corrupted and try again
    await Hive.deleteBoxFromDisk('appSettings');
    await Hive.openBox('appSettings');
  }

  try {
    await Hive.openBox('content');
    if (kDebugMode) {
      print("Main: Successfully opened content box");
    }
  } catch (e) {
    if (kDebugMode) {
      print("Main: Error opening content box: $e");
    }
    // Delete the box if it's corrupted and try again
    await Hive.deleteBoxFromDisk('content');
    await Hive.openBox('content');
  }

  try {
    await Hive.openBox('favorites');
    if (kDebugMode) {
      print("Main: Successfully opened favorites box");
    }
  } catch (e) {
    if (kDebugMode) {
      print("Main: Error opening favorites box: $e");
    }
    // Delete the box if it's corrupted and try again
    await Hive.deleteBoxFromDisk('favorites');
    await Hive.openBox('favorites');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Create ContentProvider first
        ChangeNotifierProvider(create: (_) => ContentProvider()),

        // Create LanguageProvider which depends on ContentProvider
        ChangeNotifierProxyProvider<ContentProvider, LanguageProvider>(
          create: (context) => LanguageProvider(Provider.of<ContentProvider>(context, listen: false)),
          update: (context, contentProvider, previousLanguageProvider) =>
          previousLanguageProvider ?? LanguageProvider(contentProvider),
        ),

        // Create other providers
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()..loadSettings()),
      ],
      child: const AppWithLanguage(),
    );
  }
}

class AppWithLanguage extends StatelessWidget {
  const AppWithLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    // The Key property is critical here - it forces Flutter to rebuild
    // the entire app when the language code changes
    final languageProvider = Provider.of<LanguageProvider>(context);
    final contentProvider = Provider.of<ContentProvider>(context);

    // Track if content has been loaded for debugging
    if (kDebugMode) {
      print("AppWithLanguage: Language is ${languageProvider.currentLanguage}");
      print("AppWithLanguage: Content sections count: ${contentProvider.sections.length}");
    }

    // Shared properties for both platforms
    final Locale locale = Locale(languageProvider.currentLanguage);
    const String title = 'Pregnancy Guide';
    final Color primaryColor = Colors.pink[300]!;

    // iOS specific app implementation
    if (Platform.isIOS) {
      return CupertinoApp(
        key: ValueKey('ios_${languageProvider.currentLanguage}_${contentProvider.isInitialized}'),
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
        home: const HomeScreen(), // Keep HomeScreen as starting point
        routes: {
          SettingsScreen.routeName: (ctx) => const SettingsScreen(),
          HelpScreen.routeName: (ctx) => const HelpScreen(), // Add the help screen route
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
    // Android/other platforms use MaterialApp
    else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        key: ValueKey('android_${languageProvider.currentLanguage}_${contentProvider.isInitialized}'),
        title: title,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          useMaterial3: true,
          fontFamily: 'Poppins',
        ),
        home: const HomeScreen(), // Keep HomeScreen as starting point
        routes: {
          SettingsScreen.routeName: (ctx) => const SettingsScreen(),
          HelpScreen.routeName: (ctx) => const HelpScreen(), // Add the help screen route
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