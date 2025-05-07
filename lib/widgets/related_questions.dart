// widgets/related_questions.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/content_model.dart';
import '../providers/content_provider.dart';
import '../screens/question_detail_screen.dart';
import '../utils/app_theme.dart';

class RelatedQuestions extends StatelessWidget {
  final String currentQuestionId;
  final String categoryId;
  final int maxQuestions;

  const RelatedQuestions({
    Key? key,
    required this.currentQuestionId,
    required this.categoryId,
    this.maxQuestions = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contentProvider = Provider.of<ContentProvider>(context);
    final category = contentProvider.getCategoryById(categoryId);

    if (category == null) {
      return const SizedBox.shrink();
    }

    // Get related questions (excluding the current one)
    final relatedQuestions = category.questions
        .where((question) => question.id != currentQuestionId)
        .take(maxQuestions)
        .toList();

    if (relatedQuestions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: relatedQuestions.map((question) {
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
              final section = contentProvider.getSectionById(category.sectionId);
              if (section != null) {
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
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(
                    Icons.question_answer,
                    color: AppTheme.accentColor,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      question.question,
                      style: const TextStyle(
                        fontSize: 14,
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
      }).toList(),
    );
  }
}