// screens/questions_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/content_model.dart';
import '../providers/content_provider.dart';
import '../screens/question_detail_screen.dart';
import '../utils/app_theme.dart';
import '../services/localization_service.dart';
import '../widgets/question_list_item.dart';

class CategoryDetailScreen extends StatefulWidget {
  final ContentCategory category;
  final ContentSection parentSection;

  const CategoryDetailScreen({
    super.key,
    required this.category,
    required this.parentSection,
  });

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<ContentQuestion> _filteredQuestions = [];
  final bool _onlyFavorites = false;

  @override
  void initState() {
    super.initState();
    _filteredQuestions = widget.category.questions;

    _searchController.addListener(() {
      _filterQuestions();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterQuestions() {
    final contentProvider = Provider.of<ContentProvider>(context, listen: false);

    setState(() {
      if (_searchController.text.isEmpty && !_onlyFavorites) {
        _filteredQuestions = widget.category.questions;
        return;
      }

      final searchText = _searchController.text.toLowerCase();
      _filteredQuestions = widget.category.questions.where((question) {
        final matchesSearch = searchText.isEmpty ||
            question.question.toLowerCase().contains(searchText) ||
            question.answer.toLowerCase().contains(searchText);

        final matchesFavorite = !_onlyFavorites ||
            contentProvider.isFavorite(question.id);

        return matchesSearch && matchesFavorite;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final isSmallScreen = screenHeight < 700;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, isSmallScreen),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //_buildSearchAndFilter(context, isSmallScreen),
                  //const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(
                        Icons.question_answer,
                        color: AppTheme.primaryColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        context.tr('questions'),
                        style: TextStyle(
                          fontSize: isSmallScreen ? 18 : 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimaryColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _filteredQuestions.length.toString(),
                          style: TextStyle(
                            fontSize: isSmallScreen ? 14 : 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          _buildQuestionsList(context, _filteredQuestions, isSmallScreen),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, bool isSmallScreen) {
    return SliverAppBar(
      expandedHeight: isSmallScreen ? 130 : 160,
      pinned: true,
      backgroundColor: AppTheme.primaryColor,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          widget.category.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.primaryColor.withOpacity(0.7),
                AppTheme.primaryColor,
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                left: 76,
                right: 16,
                bottom: 48,
                top: isSmallScreen ? 36 : 48
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildQuestionsList(
      BuildContext context,
      List<ContentQuestion> questions,
      bool isSmallScreen,
      ) {
    if (questions.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off,
                size: 48,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 16),
              Text(
                _searchController.text.isNotEmpty
                    ? context.tr('noQuestionsMatchSearch')
                    : _onlyFavorites
                    ? context.tr('noFavoritesInCategory')
                    : context.tr('noQuestionsInCategory'),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final question = questions[index];
            final contentProvider = Provider.of<ContentProvider>(context);

            return QuestionListItem(
              question: question,
              isFavorite: contentProvider.isFavorite(question.id),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionDetailScreen(
                      question: question,
                      category: widget.category,
                      parentSection: widget.parentSection,
                    ),
                  ),
                );
              },
              onFavoriteToggle: () {
                contentProvider.toggleFavorite(question.id);
                // If we're filtering by favorites, refresh the list
                if (_onlyFavorites) {
                  _filterQuestions();
                }
              },
            );
          },
          childCount: questions.length,
        ),
      ),
    );
  }

}