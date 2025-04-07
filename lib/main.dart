import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'providers/content_provider.dart';
import 'providers/user_provider.dart';
import 'providers/settings_provider.dart';
import 'utils/app_theme.dart';
import 'utils/app_router.dart';
import 'services/localization_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive initialisieren und benötigte Boxes öffnen
  await Hive.initFlutter();
  await Hive.openBox('content');
  await Hive.openBox('favorites');
  await Hive.openBox('appSettings');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ContentProvider>(
          create: (_) => ContentProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider<SettingsProvider>(
          create: (_) => SettingsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Pregnancy Guide',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        // Optional: Systemweite Theme-Einstellungen nutzen
        // themeMode: ThemeMode.system,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRouter.splash,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        localeResolutionCallback:
        AppLocalizations.localeResolutionCallback,
      ),
    );
  }
}
