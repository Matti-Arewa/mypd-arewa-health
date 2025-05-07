// utils/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  // Warme, einladende Farbpalette für Schwangerschafts-App
  static const Color primaryColor = Color(0xFFDC7B9B);    // Gedämpftes Altrosa
  static const Color accentColor = Color(0xFF7CA0C7);     // Sanftes Blau
  static const Color backgroundColor = Color(0xFFFFFBF5); // Cremefarbener Hintergrund
  static const Color cardColor = Color(0xFFFFFFFF);       // Weiß
  static const Color textPrimaryColor = Color(0xFF4A4A4A); // Dunkelgrau
  static const Color textSecondaryColor = Color(0xFF7A7A7A); // Mittelgrau
  static const Color dividerColor = Color(0xFFF0E9E9);    // Sehr leichtes Rosa-Grau

  // Akzent-Farben für Kategorien und Abschnitte
  static const Color accentBlue = Color(0xFF81DEEA);      // Sanftes Türkis
  static const Color accentPurple = Color(0xFFCE93D8);    // Helles Lavendel
  static const Color accentGreen = Color(0xFFA5D6A7);     // Sanftes Grün
  static const Color accentPink = Color(0xFFF8BBD0);      // Helles Rosa
  static const Color accentOrange = Color(0xFFFFCC80);    // Sanftes Orange

  // Feste Schriftgrößen
  static const double fontSizeDisplayLarge = 22.0;
  static const double fontSizeDisplayMedium = 18.0;
  static const double fontSizeDisplaySmall = 16.0;
  static const double fontSizeBodyLarge = 15.0;
  static const double fontSizeBodyMedium = 14.0;
  static const double fontSizeSmall = 12.0;

  // Modernes Theme
  static final ThemeData theme = ThemeData(
    useMaterial3: true, // Material 3 Funktionen aktivieren
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      secondary: accentColor,
      surface: backgroundColor,
      error: Colors.redAccent,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      centerTitle: false,
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
      shadowColor: Colors.black.withOpacity(0.07),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFFFFE0E0), // Sehr helles Rosa
      selectedColor: primaryColor.withOpacity(0.2),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle: const TextStyle(
        color: textPrimaryColor,
        fontSize: 14,
      ),
      secondaryLabelStyle: const TextStyle(
        color: primaryColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Color(0xFFEADFDF)), // Leichtes Rosa-Grau
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Color(0xFFEADFDF)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: primaryColor),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      hintStyle: const TextStyle(color: Color(0xFFBDBDBD)), // Hellgrau
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
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryColor,
      unselectedItemColor: Color(0xFFBDBDBD), // Hellgrau
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white.withOpacity(0.7),
      indicatorColor: Colors.white,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
      ),
    ),
  );

  // Aktualisierte Methode für ChapterListItem Widget
  static Color getColorForSection(String title) {
    final titleLower = title.toLowerCase();

    if (titleLower.contains('visit') || titleLower.contains('practice')) {
      return const Color(0xFF81DEEA); // Sanftes Türkis
    } else if (titleLower.contains('body') || titleLower.contains('anatomy')) {
      return const Color(0xFFCE93D8); // Helles Lavendel
    } else if (titleLower.contains('birth') || titleLower.contains('delivery')) {
      return const Color(0xFFA5D6A7); // Sanftes Grün
    } else if (titleLower.contains('nutrition') || titleLower.contains('diet')) {
      return const Color(0xFFFFCC80); // Sanftes Orange
    } else if (titleLower.contains('exercise') || titleLower.contains('fitness')) {
      return const Color(0xFF80CBC4); // Türkis-Grün
    } else if (titleLower.contains('health') || titleLower.contains('wellness')) {
      return const Color(0xFFEF9A9A); // Helles Korallenrot
    } else if (titleLower.contains('trimester') || titleLower.contains('stages')) {
      return const Color(0xFF9FA8DA); // Helles Indigo
    } else if (titleLower.contains('prepare') || titleLower.contains('planning')) {
      return const Color(0xFFFFD54F); // Warmes Gelb
    } else {
      return primaryColor;
    }
  }
}