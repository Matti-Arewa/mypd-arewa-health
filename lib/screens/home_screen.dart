// home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

import '../providers/content_provider.dart';
import '../providers/language_provider.dart';

import '../screens/guide_screen.dart';  // Neue zusammengefasste Komponente
import '../screens/tools_screen.dart';
import '../screens/medical_records_screen.dart';
import '../screens/community_screen.dart';
import '../screens/welcome_screen.dart';

import '../widgets/under_development_overlay.dart';

import '../services/localization_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 2;
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
        icon: const Icon(Icons.info_outline),
        selectedIcon: const Icon(Icons.info),
        label: context.tr('welcomeTab'),
      ),
    ];

    // Screens für die Bottom-Navigation
    final screens = [
      const GuideScreen(),           // Guide (0) - neue zusammengefasste Komponente
      const ToolsScreen(),            // Tools (1)
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
      const WelcomeScreen(),           // Welcome Screen (4)
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