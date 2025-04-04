//widgets/related_questions.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/content_provider.dart';
import '../utils/app_theme.dart';
import '../screens/question_detail_screen.dart';

class RelatedQuestions extends StatelessWidget {
  final String currentQuestionId;
  final String categoryId;

  const RelatedQuestions({
    super.key,
    required this.currentQuestionId,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    final contentProvider = Provider.of<ContentProvider>(context);
    final category = contentProvider.getCategoryById(categoryId);

    // Get related questions (all questions from same category except current one)
    final relatedQuestions = category!.questions
        .where((q) => q.id != currentQuestionId)
        .take(3) // Limit to 3 related questions
        .toList();

    if (relatedQuestions.isEmpty) {
      return const Text('No related questions available.');
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: relatedQuestions.length,
      itemBuilder: (context, index) {
        final question = relatedQuestions[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => QuestionDetailScreen(
                    question: question,
                    categoryId: categoryId,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      question.question,
                      style: TextStyle(
                        color: AppTheme.textPrimaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppTheme.accentColor,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}