//screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/content_provider.dart';
import '../providers/user_provider.dart';
import '../screens/category_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/search_screen.dart';
import '../screens/tools_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/community_screen.dart';
import '../widgets/pregnancy_progress.dart';
import '../widgets/category_card.dart';
import '../utils/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _screens;
  late final List<NavigationDestination> _destinations;

  @override
  void initState() {
    super.initState();
    _screens = [
      const _InfoContent(),
      const ToolsScreen(),
      const CommunityScreen(),
      const FavoritesScreen(),
    ];

    _destinations = const [
      NavigationDestination(
        icon: Icon(Icons.menu_book_outlined),
        selectedIcon: Icon(Icons.menu_book_outlined),
        label: 'Guide',
      ),
      NavigationDestination(
        icon: Icon(Icons.calculate_outlined),
        selectedIcon: Icon(Icons.calculate),
        label: 'Tools',
      ),
      NavigationDestination(
        icon: Icon(Icons.forum_outlined),
        selectedIcon: Icon(Icons.forum),
        label: 'Community',
      ),
      NavigationDestination(
        icon: Icon(Icons.favorite_border),
        selectedIcon: Icon(Icons.favorite),
        label: 'Favoriten',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
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
        title: const Text(
          'Schwangerschaftsratgeber',
          style: TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: AppTheme.fontSizeDisplaySmall,
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
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: AppTheme.primaryColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header und Schwangerschaftsfortschritt
          _buildHeader(context, userProvider, useCompactView),

          // Kategorien-Überschrift
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Icon(Icons.menu_book, color: AppTheme.primaryColor),
                SizedBox(width: 8),
                Text(
                  'Kategorien',
                  style: const TextStyle(
                    fontSize: AppTheme.fontSizeDisplaySmall,
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  'Ihre Schwangerschaft',
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
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Entbindungstermin festlegen',
                      style: TextStyle(
                        fontSize: AppTheme.fontSizeBodyLarge,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Verfolgen Sie Ihre Schwangerschaft',
                      style: TextStyle(
                        fontSize: AppTheme.fontSizeBodyMedium,
                      ),
                    ),
                    const SizedBox(height: 8),
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
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          minimumSize: const Size(double.infinity, 36),
                        ),
                        child: const Text('Termin festlegen'),
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