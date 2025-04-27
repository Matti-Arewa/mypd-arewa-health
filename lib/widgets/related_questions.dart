import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/content_provider.dart';
import '../utils/app_theme.dart';
import '../screens/question_detail_screen.dart';
import '../models/content_model.dart';
import '../services/localization_service.dart';

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

    // Responsive design adjustments
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    // Adjust sizes based on screen size
    final titleFontSize = isSmallScreen ? 12.0 : 14.0;
    final textFontSize = isSmallScreen ? 13.0 : 15.0;
    final iconSize = isSmallScreen ? 16.0 : 20.0;
    final padding = isSmallScreen ? 12.0 : 16.0;
    final cardMargin = isSmallScreen ? 8.0 : 12.0;

    if (category == null) {
      return Text(
        context.tr('noRelatedQuestions'),
        style: TextStyle(fontSize: textFontSize),
      );
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
          contentProvider.getCategoryById(question.categoryId)?.title ?? context.tr('category'),
          isSmallScreen,
          titleFontSize,
          textFontSize,
          iconSize,
          padding,
          cardMargin,
        )),

        if (relatedQuestions.length > 2) ...[
          SizedBox(height: isSmallScreen ? 6 : 8),
          TextButton.icon(
            onPressed: () {
              // Navigate to category screen for more questions
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, size: isSmallScreen ? 16 : 18),
            label: Text(
              context.tr('backToCategory'),
              style: TextStyle(fontSize: isSmallScreen ? 13 : 14),
            ),
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

    // Check for common pregnancy terms in different languages
    final pregnancyTerms = [
      // English terms
      'trimester', 'birth', 'pregnancy', 'embryo', 'fetus',
      'ultrasound', 'prenatal', 'nutrition', 'exercise',
      'risk', 'symptom', 'checkup', 'test', 'doctor', 'midwife',
      'early', 'late', 'contractions', 'breastfeeding', 'hygiene', 'nutrient',
      'vitamin', 'iron', 'folic acid', 'ctg', 'diagnosis', 'pain',

      // German terms
      'trimester', 'geburt', 'schwangerschaft', 'embryo', 'föt',
      'ultraschall', 'vorsorge', 'ernährung', 'sport', 'übung',
      'risiko', 'symptom', 'untersuchung', 'test', 'arzt', 'hebamme',
      'früh', 'spät', 'wehen', 'stillzeit', 'hygiene', 'nährstoff',
      'vitamin', 'eisen', 'folsäure', 'ctg', 'diagnos', 'schmerz',

      // French terms
      'trimestre', 'naissance', 'grossesse', 'embryon', 'fœtus',
      'échographie', 'prénatal', 'nutrition', 'exercice',
      'risque', 'symptôme', 'examen', 'test', 'médecin', 'sage-femme',
      'précoce', 'tardif', 'contractions', 'allaitement', 'hygiène', 'nutriment',
      'vitamine', 'fer', 'acide folique', 'ctg', 'diagnostic', 'douleur'
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
      bool isSmallScreen,
      double titleFontSize,
      double textFontSize,
      double iconSize,
      double padding,
      double cardMargin,
      ) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.only(bottom: cardMargin),
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
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Show category name if from a different category
              if (question.categoryId != categoryId) ...[
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 6 : 8,
                    vertical: isSmallScreen ? 1 : 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    categoryTitle,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: isSmallScreen ? 6 : 8),
              ],

              Row(
                children: [
                  Icon(
                    Icons.question_answer_outlined,
                    size: iconSize,
                    color: AppTheme.accentColor,
                  ),
                  SizedBox(width: isSmallScreen ? 8 : 12),
                  Expanded(
                    child: Text(
                      question.question,
                      style: TextStyle(
                        color: AppTheme.textPrimaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: textFontSize,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: isSmallScreen ? 12 : 16,
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