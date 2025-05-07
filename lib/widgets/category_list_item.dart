// widgets/category_list_item.dart
import 'package:flutter/material.dart';
import '../models/content_model.dart';
import '../utils/app_theme.dart';

class CategoryListItem extends StatelessWidget {
  final ContentCategory category;
  final VoidCallback onTap;

  const CategoryListItem({
    Key? key,
    required this.category,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isSmallScreen = mediaQuery.size.width < 360;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
          child: Row(
            children: [
              // Icon container
              Container(
                width: isSmallScreen ? 44 : 50,
                height: isSmallScreen ? 44 : 50,
                decoration: BoxDecoration(
                  color: _getCategoryColor().withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(
                    _getCategoryIcon(),
                    size: isSmallScreen ? 24 : 28,
                    color: _getCategoryColor(),
                  ),
                ),
              ),
              SizedBox(width: isSmallScreen ? 12 : 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.title,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 15 : 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimaryColor,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Show count of questions
                    Row(
                      children: [
                        const Icon(
                          Icons.question_answer,
                          size: 14,
                          color: AppTheme.accentColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${category.questions.length} questions",
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.accentColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: isSmallScreen ? 14 : 16,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon() {
    final titleLower = category.title.toLowerCase();

    if (titleLower.contains('introduction') || titleLower.contains('basics')) {
      return Icons.school;
    } else if (titleLower.contains('symptoms') || titleLower.contains('signs')) {
      return Icons.medical_information;
    } else if (titleLower.contains('care') || titleLower.contains('health')) {
      return Icons.healing;
    } else if (titleLower.contains('nutrition') || titleLower.contains('diet')) {
      return Icons.restaurant;
    } else if (titleLower.contains('exercise')) {
      return Icons.fitness_center;
    } else if (titleLower.contains('preparation') || titleLower.contains('planning')) {
      return Icons.event_note;
    } else if (titleLower.contains('tests') || titleLower.contains('screening')) {
      return Icons.science;
    } else if (titleLower.contains('menstrual') || titleLower.contains('cycle')) {
      return Icons.calendar_today;
    } else if (titleLower.contains('pregnancy')) {
      return Icons.pregnant_woman;
    } else {
      return Icons.category;
    }
  }

  Color _getCategoryColor() {
    final titleLower = category.title.toLowerCase();

    if (titleLower.contains('introduction') || titleLower.contains('basics')) {
      return Colors.blue;
    } else if (titleLower.contains('symptoms') || titleLower.contains('signs')) {
      return Colors.red;
    } else if (titleLower.contains('care') || titleLower.contains('health')) {
      return Colors.green;
    } else if (titleLower.contains('nutrition') || titleLower.contains('diet')) {
      return Colors.orange;
    } else if (titleLower.contains('exercise')) {
      return Colors.teal;
    } else if (titleLower.contains('preparation') || titleLower.contains('planning')) {
      return Colors.amber.shade700;
    } else if (titleLower.contains('tests') || titleLower.contains('screening')) {
      return Colors.purple;
    } else if (titleLower.contains('menstrual') || titleLower.contains('cycle')) {
      return Colors.pink;
    } else if (titleLower.contains('pregnancy')) {
      return Colors.indigo;
    } else {
      return AppTheme.primaryColor;
    }
  }
}