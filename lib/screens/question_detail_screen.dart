// screens/question_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/content_model.dart';
import '../providers/content_provider.dart';
import '../utils/app_theme.dart';
import '../services/localization_service.dart';

class QuestionDetailScreen extends StatelessWidget {
  final ContentQuestion question;
  final ContentCategory category;
  final ContentSection parentSection;

  const QuestionDetailScreen({
    super.key,
    required this.question,
    required this.category,
    required this.parentSection,
  });

  @override
  Widget build(BuildContext context) {
    final contentProvider = Provider.of<ContentProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final isSmallScreen = screenHeight < 700;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 0, // No expanded height for question detail
            pinned: true,
            backgroundColor: AppTheme.primaryColor,
            title: Text(
              category.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  // Navigate back to home screen (reset navigation stack)
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                tooltip: context.tr('home'),
              ),
              IconButton(
                icon: Icon(
                  contentProvider.isFavorite(question.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.white,
                ),
                onPressed: () {
                  contentProvider.toggleFavorite(question.id);
                },
                tooltip: context.tr('toggleFavorite'),
              ),
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {
                  _shareQuestion(context, question);
                },
                tooltip: context.tr('share'),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Breadcrumb navigation
                _buildBreadcrumbNavigation(context, isSmallScreen),

                // Question card
                _buildQuestionCard(context, isSmallScreen),

                // Answer content
                _buildAnswerContent(context, isSmallScreen),

                // Related questions
                _buildRelatedQuestionsSection(context, contentProvider, isSmallScreen),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreadcrumbNavigation(BuildContext context, bool isSmallScreen) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: isSmallScreen ? 8 : 12,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Wrap(
        spacing: 4,
        children: [
          GestureDetector(
            onTap: () {
              // Navigate back to home
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.home,
                  size: isSmallScreen ? 14 : 16,
                  color: AppTheme.primaryColor,
                ),
                const SizedBox(width: 4),
                Text(
                  context.tr('home'),
                  style: TextStyle(
                    fontSize: isSmallScreen ? 12 : 13,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            size: isSmallScreen ? 14 : 16,
            color: Colors.grey[400],
          ),
          GestureDetector(
            onTap: () {
              // Pop twice to return to chapter
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              parentSection.title,
              style: TextStyle(
                fontSize: isSmallScreen ? 12 : 13,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
          Icon(
            Icons.chevron_right,
            size: isSmallScreen ? 14 : 16,
            color: Colors.grey[400],
          ),
          GestureDetector(
            onTap: () {
              // Pop once to return to category
              Navigator.pop(context);
            },
            child: Text(
              category.title,
              style: TextStyle(
                fontSize: isSmallScreen ? 12 : 13,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(BuildContext context, bool isSmallScreen) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.question_mark,
                      color: AppTheme.primaryColor,
                      size: isSmallScreen ? 24 : 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      question.question,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 18 : 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnswerContent(BuildContext context, bool isSmallScreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.lightbulb_outline,
                  color: AppTheme.accentColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  context.tr('answer'),
                  style: TextStyle(
                    fontSize: isSmallScreen ? 16 : 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.accentColor,
                  ),
                ),
              ],
            ),
          ),
          Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: Colors.grey[200]!,
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                question.answer,
                style: TextStyle(
                  fontSize: isSmallScreen ? 15 : 16,
                  height: 1.5,
                  color: AppTheme.textPrimaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedQuestionsSection(BuildContext context, ContentProvider contentProvider, bool isSmallScreen) {
    // Find related questions from the same category
    final relatedQuestions = category.questions
        .where((q) => q.id != question.id)
        .take(3)
        .toList();

    if (relatedQuestions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 16),
            child: Row(
              children: [
                const Icon(
                  Icons.launch,
                  color: AppTheme.primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  context.tr('relatedQuestions'),
                  style: TextStyle(
                    fontSize: isSmallScreen ? 16 : 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          ...relatedQuestions.map((relatedQuestion) {
            return Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Colors.grey[200]!,
                  width: 1,
                ),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionDetailScreen(
                        question: relatedQuestion,
                        category: category,
                        parentSection: parentSection,
                      ),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(
                        Icons.question_answer,
                        color: AppTheme.accentColor,
                        size: isSmallScreen ? 18 : 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          relatedQuestion.question,
                          style: TextStyle(
                            fontSize: isSmallScreen ? 14 : 15,
                            color: AppTheme.textPrimaryColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // Improved sharing functionality
  void _shareQuestion(BuildContext context, ContentQuestion question) {
    final String shareText = '${question.question}\n\n${question.answer}';

    Share.share(
      shareText,
      subject: question.question,
    );
  }
}