// widgets/chapter_list_item.dart
import 'package:flutter/material.dart';
import '../models/content_model.dart';
import '../utils/app_theme.dart';
import 'package:flutter/foundation.dart';

class ChapterListItem extends StatelessWidget {
  final ContentSection section;
  final VoidCallback onTap;

  // Definiere eine Map für die Kapitelbilder
  static final Map<String, String> chapterImages = {
    'chapter1': 'assets/icons/chapter1.png',
    'chapter2': 'assets/icons/chapter2.png',
    'chapter3': 'assets/icons/chapter3.png',
    'chapter4': 'assets/icons/chapter4.png',
    'chapter5': 'assets/icons/chapter5.png',
    'chapter6': 'assets/icons/chapter6.png',
  };

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

    // Verwende den Eintrag aus der Map oder einen Fallback
    final String imagePath = chapterImages[section.id] ?? 'assets/icons/default.png';

    if (kDebugMode) {
      print("Section ID: ${section.id}, Using image path: $imagePath");
    }

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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Entferne den Container und verwende stattdessen ClipRRect für abgerundete Ecken
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  width: isSmallScreen ? 60 : 70, // Größeres Bild
                  height: isSmallScreen ? 60 : 70, // Größeres Bild
                  fit: BoxFit.cover, // Bild füllt den verfügbaren Raum
                  errorBuilder: (context, error, stackTrace) {
                    if (kDebugMode) {
                      print("Error loading image '$imagePath': $error");
                    }
                    // Fallback-Icon mit Container für Hintergrundfarbe
                    return Container(
                      width: isSmallScreen ? 60 : 70,
                      height: isSmallScreen ? 60 : 70,
                      decoration: BoxDecoration(
                        color: _getColorForSection(section.title).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.book_outlined,
                        size: isSmallScreen ? 32 : 36,
                        color: _getColorForSection(section.title),
                      ),
                    );
                  },
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
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
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
        ),
      ),
    );
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