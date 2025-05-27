import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'services/localization_service.dart';
import 'providers/user_provider.dart';
import 'providers/content_provider.dart';
import 'providers/language_provider.dart';
import 'providers/settings_provider.dart';
import 'providers/auth_provider.dart'; // Add AuthProvider
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/language_selection_screen.dart';
import 'screens/intro_video_screen.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/help_screen.dart';
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
        // Create AuthProvider first
        ChangeNotifierProvider(create: (_) => AuthProvider()),

        // Create ContentProvider
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
        home: const AppEntryPoint(), // Use new entry point
        routes: {
          '/login': (ctx) => const LoginScreen(),
          '/language-selection': (ctx) => const LanguageSelectionScreen(),
          '/intro-video': (ctx) => const IntroVideoScreen(),
          '/home': (ctx) => const HomeScreen(),
          SettingsScreen.routeName: (ctx) => const SettingsScreen(),
          HelpScreen.routeName: (ctx) => const HelpScreen(),
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
        home: const AppEntryPoint(), // Use new entry point
        routes: {
          '/login': (ctx) => const LoginScreen(),
          '/language-selection': (ctx) => const LanguageSelectionScreen(),
          '/intro-video': (ctx) => const IntroVideoScreen(),
          '/home': (ctx) => const HomeScreen(),
          SettingsScreen.routeName: (ctx) => const SettingsScreen(),
          HelpScreen.routeName: (ctx) => const HelpScreen(),
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

class AppEntryPoint extends StatefulWidget {
  const AppEntryPoint({super.key});

  @override
  State<AppEntryPoint> createState() => _AppEntryPointState();
}

class _AppEntryPointState extends State<AppEntryPoint> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _determineInitialRoute();
  }

  Future<void> _determineInitialRoute() async {
    // Add a small delay to show splash screen
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // Check if user is authenticated (either real login or demo mode)
    if (authProvider.isAuthenticated || authProvider.isDemoMode) {
      // User is logged in, check if it's first launch
      if (userProvider.isFirstLaunch) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LanguageSelectionScreen(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    } else {
      // User is not logged in, show login screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show splash screen while determining route
    return const SplashScreen();
  }
}