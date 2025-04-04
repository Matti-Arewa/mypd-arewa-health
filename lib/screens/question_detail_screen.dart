//screens/question_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/content_model.dart';
import '../providers/content_provider.dart';
import '../utils/app_theme.dart';
import '../widgets/related_questions.dart';

class QuestionDetailScreen extends StatelessWidget {
  final ContentQuestion  question;
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          category!.title,
          style: const TextStyle(color: AppTheme.textPrimaryColor),
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
          ),
          IconButton(
            icon: const Icon(Icons.share, color: AppTheme.accentColor),
            onPressed: () {
              // Share functionality could be implemented here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sharing will be available in the next update')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question title
              Text(
                question.question,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Answer content
              Text(
                question.answer,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),

              // Media section (if available)
              if (question.mediaUrls.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Visual Guide',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: _buildMediaWidget(question.mediaUrls),
                    ),
                  ],
                ),
              const SizedBox(height: 32),

              // Related questions section
              Text(
                'Related Questions',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(height: 16),
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

  Widget _buildMediaWidget(List<String> mediaUrls) {
    final mediaUrl = mediaUrls.first;
    if (mediaUrl.endsWith('.mp4')) {
      return Container(
        height: 200,
        color: Colors.grey[300],
        child: const Center(
          child: Text('Video content will be available here'),
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