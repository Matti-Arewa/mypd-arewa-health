import 'package:flutter/material.dart';
import '../services/localization_service.dart';

class ToolCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool isDisabled;

  const ToolCard({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Responsive design adjustments
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    final titleFontSize = isSmallScreen ? 16.0 : 18.0;
    final descriptionFontSize = isSmallScreen ? 12.0 : 14.0;
    final iconSize = isSmallScreen ? 28.0 : 32.0;
    final padding = isSmallScreen ? 12.0 : 16.0;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 10 : 12),
                decoration: BoxDecoration(
                  color: isDisabled ? Colors.grey[200] : color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: isDisabled ? Colors.grey : color,
                  size: iconSize,
                ),
              ),
              SizedBox(width: isSmallScreen ? 12 : 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // Support for localized titles
                      title.startsWith('_') ? context.tr(title.substring(1)) : title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: titleFontSize,
                        color: isDisabled ? Colors.grey : Colors.black87,
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 2 : 4),
                    Text(
                      // Support for localized descriptions
                      description.startsWith('_') ? context.tr(description.substring(1)) : description,
                      style: TextStyle(
                        color: isDisabled ? Colors.grey : Colors.grey[600],
                        fontSize: descriptionFontSize,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: isDisabled ? Colors.grey[300] : Colors.grey,
                size: isSmallScreen ? 14 : 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}