// screens/subcategorys_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/content_model.dart';
import '../providers/content_provider.dart';
import '../screens/question_detail_screen.dart';
import '../utils/app_theme.dart';
import '../services/localization_service.dart';
import '../widgets/question_list_item.dart';

class ChapterDetailScreen extends StatefulWidget {
  final ContentSection section;

  const ChapterDetailScreen({
    super.key,
    required this.section,
  });

  @override
  State<ChapterDetailScreen> createState() => _ChapterDetailScreenState();
}

class _ChapterDetailScreenState extends State<ChapterDetailScreen> {
  // Map to track which categories are expanded
  final Map<String, bool> _expandedCategories = {};

  @override
  void initState() {
    super.initState();
    // Initialize all categories as collapsed
    for (var category in widget.section.categories) {
      _expandedCategories[category.id] = false;
    }
  }

  void _toggleCategoryExpansion(String categoryId) {
    setState(() {
      _expandedCategories[categoryId] = !(_expandedCategories[categoryId] ?? false);
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
          SliverAppBar(
            expandedHeight: isSmallScreen ? 130 : 160,
            pinned: true,
            backgroundColor: AppTheme.primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.section.title,
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
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.category,
                    color: AppTheme.primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    context.tr('categories'),
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
                      widget.section.categories.length.toString(),
                      style: TextStyle(
                        fontSize: isSmallScreen ? 14 : 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildCategoriesList(context, widget.section.categories, isSmallScreen),
        ],
      ),
    );
  }

  Widget _buildCategoriesList(
      BuildContext context,
      List<ContentCategory> categories,
      bool isSmallScreen,
      ) {
    if (categories.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.category_outlined,
                size: 48,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 16),
              Text(
                context.tr('noCategoriesInChapter'),
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
            final category = categories[index];
            final isExpanded = _expandedCategories[category.id] ?? false;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Card (now tappable to expand/collapse)
                _buildExpandableCategoryCard(context, category, isExpanded, isSmallScreen),

                // Questions list (only visible when category is expanded)
                if (isExpanded)
                  _buildQuestionsForCategory(context, category, isSmallScreen),
              ],
            );
          },
          childCount: categories.length,
        ),
      ),
    );
  }

  Widget _buildExpandableCategoryCard(BuildContext context, ContentCategory category, bool isExpanded, bool isSmallScreen) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: InkWell(
        onTap: () => _toggleCategoryExpansion(category.id),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
          child: Row(
            children: [
              // Icon container
              Container(
                width: isSmallScreen ? 44 : 50,
                height: isSmallScreen ? 44 : 50,
                decoration: BoxDecoration(
                  color: _getCategoryColor(category).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(
                    _getCategoryIcon(category),
                    size: isSmallScreen ? 24 : 28,
                    color: _getCategoryColor(category),
                  ),
                ),
              ),
              SizedBox(width: isSmallScreen ? 12 : 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.title,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 15 : 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimaryColor,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Show count of questions
                    Row(
                      children: [
                        const Icon(
                          Icons.question_answer,
                          size: 14,
                          color: AppTheme.accentColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${category.questions.length} ${context.tr('questions')}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.accentColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Expand/collapse icon
              AnimatedRotation(
                turns: isExpanded ? 0.5 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  size: isSmallScreen ? 24 : 28,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionsForCategory(BuildContext context, ContentCategory category, bool isSmallScreen) {
    final contentProvider = Provider.of<ContentProvider>(context);

    if (category.questions.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
        child: Center(
          child: Text(
            context.tr('noQuestionsInCategory'),
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(left: 16, right: 4, bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.withOpacity(0.05),
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: category.questions.length,
        itemBuilder: (context, index) {
          final question = category.questions[index];

          return QuestionListItem(
            question: question,
            isFavorite: contentProvider.isFavorite(question.id),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuestionDetailScreen(
                    question: question,
                    category: category,
                    parentSection: widget.section,
                  ),
                ),
              );
            },
            onFavoriteToggle: () {
              contentProvider.toggleFavorite(question.id);
              setState(() {}); // Refresh UI
            },
          );
        },
      ),
    );
  }

  IconData _getCategoryIcon(ContentCategory category) {
    final titleLower = category.title.toLowerCase();

    if (titleLower.contains('introduction') || titleLower.contains('einführung') ||
        titleLower.contains('basics') || titleLower.contains('grundlagen')) {
      return Icons.school;
    } else if (titleLower.contains('symptoms') || titleLower.contains('signs') ||
        titleLower.contains('symptome') || titleLower.contains('anzeichen')) {
      return Icons.medical_information;
    } else if (titleLower.contains('care') || titleLower.contains('health') ||
        titleLower.contains('pflege') || titleLower.contains('gesundheit')) {
      return Icons.healing;
    } else if (titleLower.contains('nutrition') || titleLower.contains('diet') ||
        titleLower.contains('ernährung') || titleLower.contains('diät')) {
      return Icons.restaurant;
    } else if (titleLower.contains('exercise') || titleLower.contains('übung')) {
      return Icons.fitness_center;
    } else if (titleLower.contains('preparation') || titleLower.contains('planning') ||
        titleLower.contains('vorbereitung') || titleLower.contains('planung')) {
      return Icons.event_note;
    } else if (titleLower.contains('tests') || titleLower.contains('screening') ||
        titleLower.contains('untersuchung')) {
      return Icons.science;
    } else if (titleLower.contains('menstrual') || titleLower.contains('cycle') ||
        titleLower.contains('menstruation') || titleLower.contains('zyklus')) {
      return Icons.calendar_today;
    } else if (titleLower.contains('pregnancy') || titleLower.contains('schwangerschaft')) {
      return Icons.pregnant_woman;
    } else if (titleLower.contains('emotional') || titleLower.contains('mental') ||
        titleLower.contains('psychisch') || titleLower.contains('psychologisch')) {
      return Icons.psychology;
    } else if (titleLower.contains('praktisch') || titleLower.contains('practical')) {
      return Icons.build;
    } else if (titleLower.contains('betreuung') || titleLower.contains('support')) {
      return Icons.support;
    } else if (titleLower.contains('geburt') || titleLower.contains('birth')) {
      return Icons.child_care;
    } else {
      return Icons.category;
    }
  }

  Color _getCategoryColor(ContentCategory category) {
    final titleLower = category.title.toLowerCase();

    if (titleLower.contains('introduction') || titleLower.contains('einführung') ||
        titleLower.contains('basics') || titleLower.contains('grundlagen')) {
      return Colors.blue;
    } else if (titleLower.contains('symptoms') || titleLower.contains('signs') ||
        titleLower.contains('symptome') || titleLower.contains('anzeichen')) {
      return Colors.red;
    } else if (titleLower.contains('care') || titleLower.contains('health') ||
        titleLower.contains('pflege') || titleLower.contains('gesundheit')) {
      return Colors.green;
    } else if (titleLower.contains('nutrition') || titleLower.contains('diet') ||
        titleLower.contains('ernährung') || titleLower.contains('diät')) {
      return Colors.orange;
    } else if (titleLower.contains('exercise') || titleLower.contains('übung')) {
      return Colors.teal;
    } else if (titleLower.contains('preparation') || titleLower.contains('planning') ||
        titleLower.contains('vorbereitung') || titleLower.contains('planung')) {
      return Colors.amber.shade700;
    } else if (titleLower.contains('tests') || titleLower.contains('screening') ||
        titleLower.contains('untersuchung')) {
      return Colors.purple;
    } else if (titleLower.contains('menstrual') || titleLower.contains('cycle') ||
        titleLower.contains('menstruation') || titleLower.contains('zyklus')) {
      return Colors.pink;
    } else if (titleLower.contains('pregnancy') || titleLower.contains('schwangerschaft')) {
      return Colors.indigo;
    } else if (titleLower.contains('emotional') || titleLower.contains('mental') ||
        titleLower.contains('psychisch') || titleLower.contains('psychologisch')) {
      return Colors.deepPurple;
    } else if (titleLower.contains('praktisch') || titleLower.contains('practical')) {
      return Colors.brown;
    } else if (titleLower.contains('betreuung') || titleLower.contains('support')) {
      return Colors.cyan;
    } else if (titleLower.contains('geburt') || titleLower.contains('birth')) {
      return Colors.lightBlue;
    } else {
      return AppTheme.primaryColor;
    }
  }
}