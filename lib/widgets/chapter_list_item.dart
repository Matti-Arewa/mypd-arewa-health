// widgets/chapter_list_item.dart
import 'package:flutter/material.dart';
import '../models/content_model.dart';
import '../utils/app_theme.dart';

class ChapterListItem extends StatelessWidget {
  final ContentSection section;
  final VoidCallback onTap;

  const ChapterListItem({
    super.key,
    required this.section,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isSmallScreen = mediaQuery.size.width < 360;

    // Extraktion der Kapitelnummer aus der ID (z.B. "chapter1" -> "1")
    final chapterNumber = section.id.replaceAll(RegExp(r'[^0-9]'), '');
    final chapterLabel = "Kapitel $chapterNumber";

    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 16,
      ),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Use an icon instead of an image
                  Container(
                    width: isSmallScreen ? 50 : 60,
                    height: isSmallScreen ? 50 : 60,
                    decoration: BoxDecoration(
                      color: _getColorForSection(section.title).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Icon(
                        _getIconForSection(section.title),
                        size: isSmallScreen ? 28 : 32,
                        color: _getColorForSection(section.title),
                      ),
                    ),
                  ),
                  SizedBox(width: isSmallScreen ? 12 : 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chapterLabel,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          section.title,
                          style: TextStyle(
                            fontSize: isSmallScreen ? 16 : 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),

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
            ],
          ),
        ),
      ),
    );
  }


  IconData _getIconForSection(String title) {
    final titleLower = title.toLowerCase();

    if (titleLower.contains('visit') || titleLower.contains('practice')) {
      return Icons.local_hospital;
    } else if (titleLower.contains('body') || titleLower.contains('anatomy')) {
      return Icons.woman;
    } else if (titleLower.contains('birth') || titleLower.contains('delivery')) {
      return Icons.child_care;
    } else if (titleLower.contains('nutrition') || titleLower.contains('diet')) {
      return Icons.restaurant;
    } else if (titleLower.contains('exercise') || titleLower.contains('fitness')) {
      return Icons.fitness_center;
    } else if (titleLower.contains('health') || titleLower.contains('wellness')) {
      return Icons.favorite;
    } else if (titleLower.contains('trimester') || titleLower.contains('stages')) {
      return Icons.timeline;
    } else if (titleLower.contains('prepare') || titleLower.contains('planning')) {
      return Icons.event_note;
    } else {
      return Icons.menu_book;
    }
  }

  Color _getColorForSection(String title) {
    final titleLower = title.toLowerCase();

    if (titleLower.contains('visit') || titleLower.contains('practice')) {
      return Colors.blue;
    } else if (titleLower.contains('body') || titleLower.contains('anatomy')) {
      return Colors.purple;
    } else if (titleLower.contains('birth') || titleLower.contains('delivery')) {
      return Colors.green;
    } else if (titleLower.contains('nutrition') || titleLower.contains('diet')) {
      return Colors.orange;
    } else if (titleLower.contains('exercise') || titleLower.contains('fitness')) {
      return Colors.teal;
    } else if (titleLower.contains('health') || titleLower.contains('wellness')) {
      return Colors.red;
    } else if (titleLower.contains('trimester') || titleLower.contains('stages')) {
      return Colors.indigo;
    } else if (titleLower.contains('prepare') || titleLower.contains('planning')) {
      return Colors.amber.shade700;
    } else {
      return AppTheme.primaryColor;
    }
  }
}