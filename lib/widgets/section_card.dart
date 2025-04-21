//widgets/section_card.dart
import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final bool isExpanded;
  final VoidCallback onTap;

  const SectionCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.isExpanded,
    required this.onTap,
    // Folgende Parameter werden nicht mehr benötigt, aber für Kompatibilität gelassen
    String? description,
    int? categoryCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Bildschirmgröße für responsive Anpassungen
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    // Responsive Textstile basierend auf Bildschirmgröße
    final titleStyle = Theme.of(context).textTheme.displaySmall?.copyWith(
      fontSize: isSmallScreen ? 18.0 : 20.0,
      fontWeight: FontWeight.bold,
      color: AppTheme.primaryColor,
    );

    // Responsive Bildgröße
    final imageSize = isSmallScreen ? 60.0 : 70.0;

    return Card(
      elevation: 3, // Stärkere Elevation für Hauptkategorien
      margin: const EdgeInsets.only(bottom: 8), // Weniger Abstand, da die Unterkategorien folgen können
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
          child: Row(
            children: [
              // Bild mit abgerundeten Ecken
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
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      child: Icon(
                        Icons.menu_book,
                        color: AppTheme.primaryColor,
                        size: imageSize / 2,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: isSmallScreen ? 12.0 : 16.0),
              // Nur noch den Titel anzeigen
              Expanded(
                child: Text(
                  title,
                  style: titleStyle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Expand/Collapse Icon
              Icon(
                isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: isSmallScreen ? 24.0 : 28.0,
                color: AppTheme.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}