//utils/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  // App color palette - soft and calming colors
  static const Color primaryColor = Color(0xFF8E97FD);
  static const Color accentColor = Color(0xFFF0A58E);
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color textPrimaryColor = Color(0xFF3F414E);
  static const Color textSecondaryColor = Color(0xFF7B7F9E);
  static const Color dividerColor = Color(0xFFEBEBEB);

  // Definierte Schriftgrößen, die keine Skalierung verwenden
  static const double fontSizeDisplayLarge = 22.0;  // War 26.0
  static const double fontSizeDisplayMedium = 18.0; // War 22.0
  static const double fontSizeDisplaySmall = 16.0;  // War 18.0
  static const double fontSizeBodyLarge = 15.0;     // War 16.0
  static const double fontSizeBodyMedium = 14.0;    // War 14.0
  static const double fontSizeSmall = 12.0;

  // Light theme - nur dieses Theme wird verwendet
  static final ThemeData theme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: Colors.white,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    cardTheme: CardTheme(
      color: cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Nunito',
        fontSize: fontSizeDisplayLarge,
        fontWeight: FontWeight.bold,
        color: textPrimaryColor,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Nunito',
        fontSize: fontSizeDisplayMedium,
        fontWeight: FontWeight.bold,
        color: textPrimaryColor,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Nunito',
        fontSize: fontSizeDisplaySmall,
        fontWeight: FontWeight.bold,
        color: textPrimaryColor,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Nunito',
        fontSize: fontSizeBodyLarge,
        color: textPrimaryColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Nunito',
        fontSize: fontSizeBodyMedium,
        color: textPrimaryColor,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: dividerColor,
      thickness: 1,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      secondary: accentColor,
    ),
  );
}