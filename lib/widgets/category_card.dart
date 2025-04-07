import 'package:flutter/material.dart';
import '../services/localization_service.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final int questionCount;
  final VoidCallback onTap;

  const CategoryCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.questionCount,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Bildschirmgröße für responsive Anpassungen
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    // Responsive Textstile basierend auf Bildschirmgröße
    final titleStyle = Theme.of(context).textTheme.displaySmall?.copyWith(
      fontSize: isSmallScreen ? 16.0 : 18.0, // Kleinere Schriftgröße auf kleinen Bildschirmen
    );

    final descriptionStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontSize: isSmallScreen ? 12.0 : 14.0, // Kleinere Schriftgröße auf kleinen Bildschirmen
      color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
    );

    // Responsive Bildgröße
    final imageSize = isSmallScreen ? 70.0 : 80.0;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0), // Kleineres Padding für kleine Bildschirme
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imageUrl,
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: imageSize,
                      height: imageSize,
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      child: Icon(
                        Icons.image,
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: isSmallScreen ? 12.0 : 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: titleStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: isSmallScreen ? 2.0 : 4.0),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: descriptionStyle,
                    ),
                    SizedBox(height: isSmallScreen ? 6.0 : 8.0),
                    Row(
                      children: [
                        Icon(
                          Icons.question_answer_outlined,
                          size: isSmallScreen ? 14.0 : 16.0,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(width: isSmallScreen ? 2.0 : 4.0),
                        Text(
                          // Lokalisierter Text für Fragenzahl
                          '$questionCount ${context.tr('questions')}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: isSmallScreen ? 10.0 : 12.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: isSmallScreen ? 14.0 : 16.0,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}