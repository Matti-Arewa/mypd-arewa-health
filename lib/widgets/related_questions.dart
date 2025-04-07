//widgets/related_questions.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/content_provider.dart';
import '../utils/app_theme.dart';
import '../screens/question_detail_screen.dart';
import '../models/content_model.dart';

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

    if (category == null) {
      return const Text('Keine verwandten Fragen verfügbar.');
    }

    // Get current question to find related keywords
    final currentQuestion = category.questions.firstWhere(
          (q) => q.id == currentQuestionId,
      orElse: () => category.questions.first,
    );

    // Get related questions (both from same category and other relevant categories)
    List<ContentQuestion> relatedQuestions = _findRelatedQuestions(
      contentProvider,
      currentQuestion,
      category,
    );

    if (relatedQuestions.isEmpty) {
      // Fallback: just show other questions from same category
      relatedQuestions = category.questions
          .where((q) => q.id != currentQuestionId)
          .take(3)
          .toList();
    }

    return Column(
      children: [
        ...relatedQuestions.map((question) => _buildRelatedQuestionCard(
          context,
          question,
          contentProvider.getCategoryById(question.categoryId)?.title ?? 'Kategorie',
        )),

        if (relatedQuestions.length > 2) ...[
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: () {
              // Navigate to category screen for more questions
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, size: 18),
            label: const Text('Zurück zur Kategorie'),
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.primaryColor,
            ),
          ),
        ]
      ],
    );
  }

  List<ContentQuestion> _findRelatedQuestions(
      ContentProvider contentProvider,
      ContentQuestion currentQuestion,
      ContentCategory category,
      ) {
    // Extract keywords from current question
    final questionText = currentQuestion.question.toLowerCase();
    final answerText = currentQuestion.answer.toLowerCase();

    // Define relevant keywords to match
    List<String> keywords = [];

    // Check for common pregnancy terms
    final pregnancyTerms = [
      'trimester', 'geburt', 'schwangerschaft', 'embryo', 'föt',
      'ultraschall', 'vorsorge', 'ernährung', 'sport', 'übung',
      'risiko', 'symptom', 'untersuchung', 'test', 'arzt', 'hebamme',
      'früh', 'spät', 'wehen', 'stillzeit', 'hygiene', 'nährstoff',
      'vitamin', 'eisen', 'folsäure', 'ctg', 'diagnos', 'schmerz'
    ];

    for (final term in pregnancyTerms) {
      if (questionText.contains(term) || answerText.contains(term)) {
        keywords.add(term);
      }
    }

    // Find questions that match the keywords
    Set<ContentQuestion> matchingQuestions = {};

    // First search within the same category (higher priority)
    for (final question in category.questions) {
      if (question.id == currentQuestionId) continue;

      int matchScore = 0;
      for (final keyword in keywords) {
        if (question.question.toLowerCase().contains(keyword) ||
            question.answer.toLowerCase().contains(keyword)) {
          matchScore++;
        }
      }

      if (matchScore > 0) {
        matchingQuestions.add(question);
      }

      // Limit to 2 questions from same category
      if (matchingQuestions.length >= 2) break;
    }

    // Then search in other categories for more diverse recommendations
    if (matchingQuestions.length < 3) {
      for (final cat in contentProvider.categories) {
        if (cat.id == categoryId) continue;

        for (final question in cat.questions) {
          int matchScore = 0;
          for (final keyword in keywords) {
            if (question.question.toLowerCase().contains(keyword) ||
                question.answer.toLowerCase().contains(keyword)) {
              matchScore++;
            }
          }

          if (matchScore > 0) {
            matchingQuestions.add(question);
            if (matchingQuestions.length >= 3) break;
          }
        }

        if (matchingQuestions.length >= 3) break;
      }
    }

    return matchingQuestions.toList();
  }

  Widget _buildRelatedQuestionCard(
      BuildContext context,
      ContentQuestion question,
      String categoryTitle,
      ) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => QuestionDetailScreen(
                question: question,
                categoryId: question.categoryId,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Show category name if from a different category
              if (question.categoryId != categoryId) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    categoryTitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],

              Row(
                children: [
                  const Icon(
                    Icons.question_answer_outlined,
                    size: 20,
                    color: AppTheme.accentColor,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      question.question,
                      style: const TextStyle(
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
            ],
          ),
        ),
      ),
    );
  }
}