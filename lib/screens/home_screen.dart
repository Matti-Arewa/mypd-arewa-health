import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/content_provider.dart';
import '../providers/user_provider.dart';
import '../providers/language_provider.dart';
import '../screens/category_screen.dart';
import '../screens/welcome_screen.dart';
import '../screens/search_screen.dart';
import '../screens/tools_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/community_screen.dart';
import '../widgets/category_card.dart';
import '../widgets/section_card.dart';
import '../utils/app_theme.dart';
import '../services/localization_service.dart';
import '../widgets/under_development_overlay.dart';
import '../screens/medical_records_screen.dart';
import 'package:flutter/foundation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 4;
  bool _communityDevMode = false;
  bool _medicalRecordsDevMode = false;
  bool _forceRefresh = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkContentLoaded();
    });
  }

  // Check if content is loaded, and force a reload if needed
  Future<void> _checkContentLoaded() async {
    final contentProvider = Provider.of<ContentProvider>(context, listen: false);
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);

    if (contentProvider.sections.isEmpty && !contentProvider.isLoading) {
      if (kDebugMode) {
        print("HomeScreen: Content is empty, forcing reload");
      }

      // Try to reload content if sections are empty
      try {
        await languageProvider.reloadContent();
        setState(() {
          _forceRefresh = true;
        });
      } catch (e) {
        if (kDebugMode) {
          print("HomeScreen: Error reloading content: $e");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build destinations here so they use the current language
    final destinations = [
      NavigationDestination(
        icon: const Icon(Icons.menu_book_outlined),
        selectedIcon: const Icon(Icons.menu_book),
        label: context.tr('guide'),
      ),
      NavigationDestination(
        icon: const Icon(Icons.calculate_outlined),
        selectedIcon: const Icon(Icons.calculate),
        label: context.tr('tools'),
      ),
      NavigationDestination(
        icon: const Icon(Icons.medical_services_outlined),
        selectedIcon: const Icon(Icons.medical_services),
        label: context.tr('medicalRecords'),
      ),
      NavigationDestination(
        icon: const Icon(Icons.forum_outlined),
        selectedIcon: const Icon(Icons.forum),
        label: context.tr('community'),
      ),
      NavigationDestination(
        // Original Favorites icon used for Welcome Screen
        icon: const Icon(Icons.info_outline),
        selectedIcon: const Icon(Icons.info),
        label: context.tr('welcomeTab'),
      ),
    ];

    // IMPORTANT: Recreate screens on EACH build to use current state
    final screens = [
      const _InfoContent(),            // Guide (0)
      const ToolsScreen(),             // Tools (1)
      UnderDevelopmentOverlay(         // Medical Records (2)
        child: const MedicalRecordsScreen(),
        developmentMode: _medicalRecordsDevMode,
        onTestButtonPressed: () {
          if (kDebugMode) {
            print("Medical Records: Enabling dev mode");
          }
          setState(() {
            _medicalRecordsDevMode = true;
          });
        },
      ),
      UnderDevelopmentOverlay(         // Community (3)
        child: const CommunityScreen(),
        developmentMode: _communityDevMode,
        onTestButtonPressed: () {
          if (kDebugMode) {
            print("Community: Enabling dev mode");
          }
          setState(() {
            _communityDevMode = true;
          });
        },
      ),
      const WelcomeScreen(),           // Welcome Screen (formerly Favorites) (4)
    ];

    // Check if ContentProvider has finished loading
    final contentProvider = Provider.of<ContentProvider>(context);

    if (contentProvider.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Reset force refresh if we've already refreshed
    if (_forceRefresh && contentProvider.sections.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _forceRefresh = false;
        });
      });
    }

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        labelTextStyle: MaterialStateProperty.all(
          const TextStyle(fontSize: 11.0), // Smaller font size
        ),
        onDestinationSelected: (index) {
          if (kDebugMode) {
            print("Navigation: Changing tab to $index");
          }
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: destinations,
      ),
    );
  }
}

class _InfoContent extends StatefulWidget {
  const _InfoContent({Key? key}) : super(key: key);

  @override
  State<_InfoContent> createState() => _InfoContentState();
}

class _InfoContentState extends State<_InfoContent> {
  // Track which sections are expanded
  Map<String, bool> expandedSections = {};
  bool _hasLoadedInitialContent = false;

  @override
  void initState() {
    super.initState();
    // Try to force reload content if needed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkContentLoaded();
    });
  }

  Future<void> _checkContentLoaded() async {
    final contentProvider = Provider.of<ContentProvider>(context, listen: false);
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);

    if (contentProvider.sections.isEmpty && !contentProvider.isLoading) {
      if (kDebugMode) {
        print("InfoContent: Content is empty, trying to reload");
      }

      try {
        await languageProvider.reloadContent();
        setState(() {});
      } catch (e) {
        if (kDebugMode) {
          print("InfoContent: Error reloading content: $e");
        }
      }
    } else if (contentProvider.sections.isNotEmpty && !_hasLoadedInitialContent) {
      if (kDebugMode) {
        print("InfoContent: Content loaded, initializing expanded sections");
      }

      // Initialize expanded sections only once, when content is first loaded
      setState(() {
        _hasLoadedInitialContent = true;
        // Set first section to be initially expanded
        if (contentProvider.sections.isNotEmpty) {
          expandedSections[contentProvider.sections.first.id] = true;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final contentProvider = Provider.of<ContentProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    // Determine if we should use compact view based on screen size
    final bool useCompactView = screenHeight < 700 || screenWidth < 360;

    if (contentProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Check for empty content even if not loading
    if (contentProvider.sections.isEmpty) {
      if (kDebugMode) {
        print("InfoContent: Sections is empty!");
      }

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.tr('noContentAvailable'),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (kDebugMode) {
                  print("InfoContent: Manual reload button pressed");
                }

                final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
                await languageProvider.reloadContent();
                setState(() {});
              },
              child: Text(context.tr('reload')),
            ),
          ],
        ),
      );
    }

    // Display all sections
    final sections = contentProvider.sections;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
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
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
            tooltip: context.tr('search'),
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
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
          // Section heading
          Padding(
            padding: EdgeInsets.fromLTRB(16, useCompactView ? 12 : 16, 16, useCompactView ? 6 : 8),
            child: Row(
              children: [
                const Icon(Icons.menu_book, color: AppTheme.primaryColor),
                const SizedBox(width: 8),
                Text(
                  context.tr('pregnancyGuide'),
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

          // Section list
          Expanded(
            child: ListView.builder(
              key: const PageStorageKey('section-list'),
              padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: useCompactView ? 6 : 8
              ),
              itemCount: sections.length,
              itemBuilder: (context, index) {
                final section = sections[index];

                // Initialize expanded state if not set
                expandedSections.putIfAbsent(section.id, () => index == 0); // First section is open by default

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section header with toggle
                      SectionCard(
                        title: section.title,
                        imageUrl: section.imageUrl,
                        isExpanded: expandedSections[section.id] ?? false,
                        onTap: () {
                          setState(() {
                            expandedSections[section.id] = !(expandedSections[section.id] ?? false);
                          });
                        },
                      ),

                      // Categories for this section (only show if expanded)
                      if (expandedSections[section.id] ?? false)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          child: Column(
                            children: section.categories.map((category) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                                child: CategoryCard(
                                  title: category.title,
                                  imageUrl: category.imageUrl,
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
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}