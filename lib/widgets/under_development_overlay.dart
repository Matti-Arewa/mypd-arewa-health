import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../services/localization_service.dart';

class UnderDevelopmentOverlay extends StatelessWidget {
  final Widget child;
  final bool developmentMode;
  final VoidCallback onTestButtonPressed;

  const UnderDevelopmentOverlay({
    Key? key,
    required this.child,
    required this.developmentMode,
    required this.onTestButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (developmentMode) {
      return child;
    }

    // Responsive Anpassungen
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    final padding = isSmallScreen ? 16.0 : 24.0;
    final fontSize = isSmallScreen ? 18.0 : 22.0;
    final buttonHeight = isSmallScreen ? 42.0 : 48.0;

    return Stack(
      children: [
        // Original-Screen im Hintergrund
        Opacity(
          opacity: 0.3,
          child: AbsorbPointer(child: child),
        ),

        // Overlay
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.1),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: screenWidth * 0.85, // Begrenze die maximale Breite
              ),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SingleChildScrollView( // Füge ScrollView hinzu, um Overflow zu vermeiden
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.construction,
                          size: isSmallScreen ? 48 : 64,
                          color: AppTheme.primaryColor,
                        ),
                        SizedBox(height: isSmallScreen ? 16 : 24),
                        Text(
                          context.tr('underDevelopment'),
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: isSmallScreen ? 8 : 12),
                        Text(
                          context.tr('comingSoon'),
                          style: TextStyle(
                            fontSize: isSmallScreen ? 14 : 16,
                            color: Colors.grey[700],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: isSmallScreen ? 24 : 32),
                        SizedBox(
                          width: double.infinity,
                          height: buttonHeight,
                          child: ElevatedButton(
                            onPressed: onTestButtonPressed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(context.tr('testFeatures')),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}