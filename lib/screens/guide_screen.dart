// screens/guide_screen.dart
import 'package:flutter/material.dart';
import 'package:mypd_2/screens/question_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

import '../providers/content_provider.dart';
import '../providers/language_provider.dart';
import '../screens/search_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/subcategorys_screen.dart';
import '../models/content_model.dart';
import '../utils/app_theme.dart';
import '../services/localization_service.dart';
import '../widgets/chapter_list_item.dart';
import '../widgets/favorite_question_item.dart';

class GuideScreen extends StatefulWidget {
  const GuideScreen({Key? key}) : super(key: key);

  @override
  State<GuideScreen> createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> with SingleTickerProviderStateMixin {
  bool _hasLoadedInitialContent = false;
  late TabController _tabController;
  String _currentTab = 'chapters'; // 'chapters', 'favorites', 'recent'

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      if (_tabController.index == 0) {
        setState(() {
          _currentTab = 'chapters';
        });
      } else if (_tabController.index == 1) {
        setState(() {
          _currentTab = 'favorites';
        });
      } else if (_tabController.index == 2) {
        setState(() {
          _currentTab = 'recent';
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkContentLoaded();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _checkContentLoaded() async {
    final contentProvider = Provider.of<ContentProvider>(context, listen: false);
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);

    if (contentProvider.sections.isEmpty && !contentProvider.isLoading) {
      if (kDebugMode) {
        print("GuideScreen: Content is empty, trying to reload");
      }

      try {
        await languageProvider.reloadContent();
        setState(() {});
      } catch (e) {
        if (kDebugMode) {
          print("GuideScreen: Error reloading content: $e");
        }
      }
    } else if (contentProvider.sections.isNotEmpty && !_hasLoadedInitialContent) {
      if (kDebugMode) {
        print("GuideScreen: Content loaded");
      }
      setState(() {
        _hasLoadedInitialContent = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final contentProvider = Provider.of<ContentProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final isSmallScreen = screenWidth < 360 || screenHeight < 700;

    if (contentProvider.isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: AppTheme.primaryColor),
              const SizedBox(height: 16),
              Text(
                context.tr('loadingContent'),
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    // Check for empty content
    if (contentProvider.sections.isEmpty) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning_amber_rounded, size: 64, color: Colors.amber),
              const SizedBox(height: 16),
              Text(
                context.tr('noContentAvailable'),
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () async {
                  final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
                  await languageProvider.reloadContent();
                  setState(() {});
                },
                icon: const Icon(Icons.refresh),
                label: Text(context.tr('reload')),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('pregnancyGuide'),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: isSmallScreen ? 18 : 20,
          ),
        ),
        backgroundColor: AppTheme.primaryColor,
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
          // Tab Bar
          Container(
            color: AppTheme.primaryColor,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withOpacity(0.7),
              tabs: [
                Tab(
                  icon: const Icon(Icons.menu_book),
                  text: context.tr('chapters'),
                ),
                Tab(
                  icon: const Icon(Icons.favorite),
                  text: context.tr('favorites'),
                ),
                Tab(
                  icon: const Icon(Icons.history),
                  text: context.tr('recent'),
                ),
              ],
            ),
          ),

          // Content based on selected tab
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildChaptersTab(contentProvider),
                _buildFavoritesTab(contentProvider),
                _buildRecentTab(contentProvider),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChaptersTab(ContentProvider contentProvider) {
    final sections = contentProvider.sections;

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      itemCount: sections.length,
      itemBuilder: (context, index) {
        final section = sections[index];
        return ChapterListItem(
          section: section,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChapterDetailScreen(section: section),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFavoritesTab(ContentProvider contentProvider) {
    final favoriteQuestions = contentProvider.getFavoriteQuestions();

    if (favoriteQuestions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 64,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              context.tr('noFavorites'),
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      itemCount: favoriteQuestions.length,
      itemBuilder: (context, index) {
        final question = favoriteQuestions[index];
        final ContentProvider contentProvider = Provider.of<ContentProvider>(context, listen: false);
        final category = contentProvider.getCategoryById(question.categoryId);
        final section = category != null ? contentProvider.getSectionById(category.sectionId) : null;

        return FavoriteQuestionItem(
          question: question,
          onTap: () {
            if (category != null && section != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuestionDetailScreen(
                    question: question,
                    category: category,
                    parentSection: section,
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

  Widget _buildRecentTab(ContentProvider contentProvider) {
    // You'll need to implement a recent questions tracker in your ContentProvider
    // For now, just show a placeholder
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 64,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            context.tr('noRecentlyViewed'),
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}