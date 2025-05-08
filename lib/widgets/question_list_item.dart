// widgets/question_list_item.dart
import 'package:flutter/material.dart';
import '../models/content_model.dart';
import '../utils/app_theme.dart';

class QuestionListItem extends StatelessWidget {
  final ContentQuestion question;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const QuestionListItem({
    super.key,
    required this.question,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isSmallScreen = mediaQuery.size.width < 360;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: isSmallScreen ? 12 : 14,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question icon
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.question_answer,
                  size: isSmallScreen ? 18 : 20,
                  color: AppTheme.accentColor,
                ),
              ),
              const SizedBox(width: 12),
              // Question text
              Expanded(
                child: Text(
                  question.question,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 14 : 15,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimaryColor,
                    height: 1.3,
                  ),
                ),
              ),
              // Favorite toggle
              GestureDetector(
                onTap: onFavoriteToggle,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: isSmallScreen ? 20 : 22,
                    color: isFavorite ? AppTheme.accentColor : Colors.grey[400],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}