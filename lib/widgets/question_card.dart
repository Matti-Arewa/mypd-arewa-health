import 'package:flutter/material.dart';
import '../services/localization_service.dart';

class QuestionCard extends StatelessWidget {
  final String question;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const QuestionCard({
    super.key,
    required this.question,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    // Responsive design adjustments
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    // Adjust sizes based on screen size
    final iconSize = isSmallScreen ? 18.0 : 22.0;
    final padding = isSmallScreen ? 12.0 : 16.0;
    final spacingWidth = isSmallScreen ? 8.0 : 12.0;

    // Text style with responsive font size
    final textStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: isSmallScreen ? 14.0 : 16.0,
    );

    return Card(
      margin: EdgeInsets.symmetric(
          horizontal: padding,
          vertical: isSmallScreen ? 6 : 8
      ),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.question_mark_rounded,
                color: const Color(0xFFF0A58E),
                size: iconSize,
              ),
              SizedBox(width: spacingWidth),
              Expanded(
                child: Text(
                  // Support for localization - if question starts with underscore, assume it's a key to translate
                  question.startsWith('_') ? context.tr(question.substring(1)) : question,
                  style: textStyle,
                ),
              ),
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? const Color(0xFFF0A58E) : Colors.grey,
                  size: iconSize,
                ),
                onPressed: onFavoriteToggle,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                tooltip: context.tr('toggleFavorite'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}