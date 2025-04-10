import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/content_provider.dart';
import '../providers/user_provider.dart';
import '../providers/language_provider.dart';
import '../screens/category_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/search_screen.dart';
import '../screens/tools_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/community_screen.dart';
import '../widgets/pregnancy_progress.dart';
import '../widgets/category_card.dart';
import '../utils/app_theme.dart';
import '../services/localization_service.dart';
import 'package:flutter/foundation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  late final List<Widget> _screens;
  late List<NavigationDestination> _destinations;

  @override
  void initState() {
    super.initState();
    _initializeScreens();
  }

  void _initializeScreens() {
    // Erstelle die Screens nur einmal und speichere sie
    _screens = [
      const _InfoContent(),
      const ToolsScreen(),
      const CommunityScreen(),
      const FavoritesScreen(),
    ];
  }

  List<NavigationDestination> _buildDestinations(BuildContext context) {
    // Dies stellt sicher, dass die Labels übersetzt werden, wenn sich die Sprache ändert
    return [
      NavigationDestination(
        icon: const Icon(Icons.menu_book_outlined),
        selectedIcon: const Icon(Icons.menu_book_outlined),
        label: context.tr('guide'),
      ),
      NavigationDestination(
        icon: const Icon(Icons.calculate_outlined),
        selectedIcon: const Icon(Icons.calculate),
        label: context.tr('tools'),
      ),
      NavigationDestination(
        icon: const Icon(Icons.forum_outlined),
        selectedIcon: const Icon(Icons.forum),
        label: context.tr('community'),
      ),
      NavigationDestination(
        icon: const Icon(Icons.favorite_border),
        selectedIcon: const Icon(Icons.favorite),
        label: context.tr('favorites'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Navigation-Destinations hier erstellen, um die aktuelle Sprache zu verwenden
    _destinations = _buildDestinations(context);

    // Überprüfe, ob der Content-Provider fertig geladen hat
    final contentProvider = Provider.of<ContentProvider>(context);
    if (contentProvider.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          if (kDebugMode) {
            print("Navigation: Changing tab to $index");
          }
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: _destinations,
      ),
    );
  }
}

class _InfoContent extends StatelessWidget {
  const _InfoContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contentProvider = Provider.of<ContentProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    // Bestimme, ob wir eine kompakte Anzeige verwenden sollen
    // basierend auf der Bildschirmgröße
    final bool useCompactView = screenHeight < 700 || screenWidth < 360;

    if (contentProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Alle Kategorien anzeigen
    final categories = contentProvider.categories;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          context.tr('app_name'),
          style: TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: useCompactView
                ? AppTheme.fontSizeBodyLarge
                : AppTheme.fontSizeDisplaySmall,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppTheme.primaryColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
            tooltip: context.tr('search'),
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: AppTheme.primaryColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
            tooltip: context.tr('settings'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Header und Schwangerschaftsfortschritt
          //_buildHeader(context, userProvider, useCompactView),

          // Kategorien-Überschrift
          Padding(
            padding: EdgeInsets.fromLTRB(16, useCompactView ? 12 : 16, 16, useCompactView ? 6 : 8),
            child: Row(
              children: [
                const Icon(Icons.menu_book, color: AppTheme.primaryColor),
                const SizedBox(width: 8),
                Text(
                  context.tr('categories'),
                  style: TextStyle(
                    fontSize: useCompactView
                        ? AppTheme.fontSizeBodyLarge
                        : AppTheme.fontSizeDisplaySmall,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
              ],
            ),
          ),

          // Kategorien-Liste
          Expanded(
            child: ListView.builder(
              key: PageStorageKey('category-list'),
              padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: useCompactView ? 6 : 8
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return CategoryCard(
                  title: category.title,
                  description: category.description,
                  imageUrl: category.imageUrl,
                  questionCount: category.questions.length,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryScreen(
                          categoryId: category.id,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, UserProvider userProvider, bool compact) {
    // Berechne die optimale Padding-Größe basierend auf der Bildschirmhöhe
    final screenHeight = MediaQuery.of(context).size.height;
    final verticalPadding = compact ? 12.0 : 16.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: verticalPadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryColor,
            AppTheme.primaryColor.withOpacity(0.8),
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  context.tr('yourPregnancy'),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: compact
                        ? AppTheme.fontSizeBodyLarge
                        : AppTheme.fontSizeDisplaySmall,
                    height: 1.1,
                  ),
                ),
              ),
              // Information Icon für medizinischen Touch - kompaktere Größe
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(compact ? 20 : 24),
                ),
                padding: EdgeInsets.all(compact ? 4 : 6),
                child: Icon(
                  Icons.medical_information,
                  color: Colors.white,
                  size: compact ? 20 : 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (userProvider.dueDate != null) ...[
            PregnancyProgress(
              weeksPregnant: userProvider.weeksPregnant,
              daysLeft: userProvider.daysLeft,
              dueDate: userProvider.dueDate!,
              compact: compact, // Übergebe die compact-Flag an die PregnancyProgress-Komponente
            ),
          ] else ...[
            Card(
              elevation: 2,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(compact ? 10 : 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr('setDueDate'),
                      style: TextStyle(
                        fontSize: compact
                            ? AppTheme.fontSizeBodyMedium
                            : AppTheme.fontSizeBodyLarge,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: compact ? 2 : 4),
                    Text(
                      context.tr('trackYourPregnancy'),
                      style: TextStyle(
                        fontSize: compact
                            ? AppTheme.fontSizeSmall
                            : AppTheme.fontSizeBodyMedium,
                      ),
                    ),
                    SizedBox(height: compact ? 6 : 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: compact ? 6 : 8),
                          minimumSize: Size(double.infinity, compact ? 32 : 36),
                        ),
                        child: Text(context.tr('setDate')),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}