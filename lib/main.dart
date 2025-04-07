import 'package:flutter/material.dart';
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
      child: Consumer<LanguageProvider>(
          builder: (context, languageProvider, _) {
            return MaterialApp(
              title: 'Pregnancy Guide',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink[300]!),
                useMaterial3: true,
              ),
              home: const HomeScreen(),
              routes: {
                SettingsScreen.routeName: (ctx) => const SettingsScreen(),
                // Add other routes here
              },
              // Localization setup
              locale: Locale(languageProvider.currentLanguage),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              localeResolutionCallback: AppLocalizations.localeResolutionCallback,
            );
          }
      ),
    );
  }
}