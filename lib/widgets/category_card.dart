//widgets/category_card.dart
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onTap,
    // Folgende Parameter werden nicht mehr benötigt, aber für Kompatibilität gelassen
    String? description,
    int? questionCount,
  });

  @override
  Widget build(BuildContext context) {
    // Bildschirmgröße für responsive Anpassungen
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    // Responsive Textstile basierend auf Bildschirmgröße
    final titleStyle = Theme.of(context).textTheme.displaySmall?.copyWith(
      fontSize: isSmallScreen ? 16.0 : 18.0,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).primaryColor,
    );

    // Responsive Bildgröße
    final imageSize = isSmallScreen ? 50.0 : 60.0;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 10.0 : 12.0),
          child: Row(
            children: [
              // Bild mit abgerundeten Ecken
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
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
              SizedBox(width: isSmallScreen ? 10.0 : 12.0),
              // Nur noch den Titel anzeigen
              Expanded(
                child: Text(
                  title,
                  style: titleStyle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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