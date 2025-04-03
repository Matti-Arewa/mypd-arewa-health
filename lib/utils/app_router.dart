import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/home_screen.dart';
import '../screens/category_screen.dart';
import '../screens/question_detail_screen.dart';
import '../screens/search_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/tools_screen.dart';
import '../screens/due_date_calculator_screen.dart';
import '../screens/kick_counter_screen.dart';
import '../screens/weight_tracker_screen.dart';
import '../screens/nutrition_screen.dart';
import '../screens/settings_screen.dart';
import '../models/content_model.dart';

class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String category = '/category';
  static const String questionDetail = '/question_detail';
  static const String search = '/search';
  static const String favorites = '/favorites';
  static const String tools = '/tools';
  static const String dueDateCalculator = '/due_date_calculator';
  static const String kickCounter = '/kick_counter';
  static const String weightTracker = '/weight_tracker';
  static const String nutrition = '/nutrition';
  static const String settings = '/settings';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case category:
        final ContentCategory category = settings.arguments as ContentCategory;
        return MaterialPageRoute(
          builder: (_) => CategoryScreen(categoryId: category.id),
        );

      case questionDetail:
        final Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => QuestionDetailScreen(
            question: args['question'],
            categoryId: args['categoryId'],
          ),
        );

      case search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());

      case favorites:
        return MaterialPageRoute(builder: (_) => const FavoritesScreen());

      case tools:
        return MaterialPageRoute(builder: (_) => const ToolsScreen());

      case dueDateCalculator:
        return MaterialPageRoute(builder: (_) => const DueDateCalculatorScreen());

      case kickCounter:
        return MaterialPageRoute(builder: (_) => const KickCounterScreen());

      case weightTracker:
        return MaterialPageRoute(builder: (_) => const WeightTrackerScreen());

      case nutrition:
        return MaterialPageRoute(builder: (_) => const NutritionScreen());

      case AppRouter.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}