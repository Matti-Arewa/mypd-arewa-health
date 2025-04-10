//screens/question_detail.screen
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/content_model.dart';
import '../providers/content_provider.dart';
import '../utils/app_theme.dart';
import '../widgets/related_questions.dart';
import '../services/localization_service.dart';

class QuestionDetailScreen extends StatelessWidget {
  final ContentQuestion question;
  final String categoryId;

  const QuestionDetailScreen({
    super.key,
    required this.question,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    final contentProvider = Provider.of<ContentProvider>(context);
    final category = contentProvider.getCategoryById(categoryId);

    // Responsive Design-Anpassungen
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360 || screenHeight < 600;

    // Responsive Textstile basierend auf Bildschirmgröße
    final titleStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(
      color: AppTheme.primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: isSmallScreen ? 18.0 : 22.0,
    );

    final bodyStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
      fontSize: isSmallScreen ? 14.0 : 16.0,
    );

    final sectionTitleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
      color: AppTheme.primaryColor,
      fontSize: isSmallScreen ? 16.0 : 18.0,
    );

    // Responsive Abstände
    final padding = isSmallScreen ? 12.0 : 16.0;
    final spacing = isSmallScreen ? 16.0 : 20.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          category!.title,
          style: TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: isSmallScreen ? 18.0 : 20.0,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              contentProvider.isFavorite(question.id)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: AppTheme.accentColor,
            ),
            onPressed: () {
              contentProvider.toggleFavorite(question.id);
            },
            tooltip: context.tr('toggleFavorite'),
          ),
          IconButton(
            icon: const Icon(Icons.share, color: AppTheme.accentColor),
            onPressed: () {
              // Share functionality could be implemented here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.tr('sharingComingSoon'))),
              );
            },
            tooltip: context.tr('share'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question title
              Text(
                question.question,
                style: titleStyle,
              ),
              SizedBox(height: spacing),

              // Answer content
              Text(
                question.answer,
                style: bodyStyle,
              ),
              SizedBox(height: spacing),

              // Media section (if available)
              if (question.mediaUrls.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr('visualGuide'),
                      style: sectionTitleStyle,
                    ),
                    SizedBox(height: isSmallScreen ? 8 : 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: _buildMediaWidget(question.mediaUrls, isSmallScreen),
                    ),
                  ],
                ),
              SizedBox(height: isSmallScreen ? 24 : 32),

              // Related questions section
              Text(
                context.tr('relatedQuestions'),
                style: sectionTitleStyle,
              ),
              SizedBox(height: isSmallScreen ? 12 : 16),
              RelatedQuestions(
                currentQuestionId: question.id,
                categoryId: categoryId,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMediaWidget(List<String> mediaUrls, bool isSmallScreen) {
    final mediaUrl = mediaUrls.first;
    if (mediaUrl.endsWith('.mp4')) {
      return Container(
        height: isSmallScreen ? 160 : 200,
        color: Colors.grey[300],
        child: Center(
          child: Text(
            'Video content will be available here',
            style: TextStyle(fontSize: isSmallScreen ? 13.0 : 14.0),
          ),
        ),
      );
    } else {
      return Image.asset(
        mediaUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/placeholder.png',
            fit: BoxFit.cover,
          );
        },
      );
    }
  }
}