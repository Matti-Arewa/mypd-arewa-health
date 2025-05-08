// widgets/favorite_question_item.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/content_model.dart';
import '../providers/content_provider.dart';
import '../utils/app_theme.dart';

class FavoriteQuestionItem extends StatelessWidget {
  final ContentQuestion question;
  final VoidCallback onTap;

  const FavoriteQuestionItem({
    super.key,
    required this.question,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final contentProvider = Provider.of<ContentProvider>(context);
    final category = contentProvider.getCategoryById(question.categoryId);
    final section = category != null
        ? contentProvider.getSectionById(category.sectionId)
        : null;

    final mediaQuery = MediaQuery.of(context);
    final isSmallScreen = mediaQuery.size.width < 360;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category and section info
              if (category != null) ...[
                Row(
                  children: [
                    const Icon(
                      Icons.bookmark,
                      size: 14,
                      color: AppTheme.primaryColor,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        section != null
                            ? '${section.title} > ${category.title}'
                            : category.title,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],

              // Question
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.accentColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.question_answer,
                      color: AppTheme.accentColor,
                      size: isSmallScreen ? 16 : 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          question.question,
                          style: TextStyle(
                            fontSize: isSmallScreen ? 14 : 15,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimaryColor,
                            height: 1.3,
                          ),
                        ),
                        if (question.answer.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            question.answer,
                            style: TextStyle(
                              fontSize: isSmallScreen ? 12 : 13,
                              color: AppTheme.textSecondaryColor,
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: AppTheme.accentColor,
                    ),
                    onPressed: () {
                      contentProvider.toggleFavorite(question.id);
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    iconSize: isSmallScreen ? 18 : 20,
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