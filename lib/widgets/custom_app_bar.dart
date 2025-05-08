import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../services/localization_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final Widget? leading;
  final double elevation;
  final Color? backgroundColor;
  final Color? titleColor; // Neuer Parameter für die Titelfarbe
  final FontWeight? titleFontWeight; // Neuer Parameter für die Schriftdicke
  final double? titleFontSize; // Optionaler Parameter für die Schriftgröße
  final VoidCallback? onBackPressed; // Callback für explizite Navigation

  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.showBackButton = true,
    this.leading,
    this.elevation = 0,
    this.backgroundColor,
    this.titleColor, // Standard ist null, wird dann in build gesetzt
    this.titleFontWeight, // Standard ist null, wird dann in build gesetzt
    this.titleFontSize, // Optional, ansonsten responsive
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Berücksichtige die Bildschirmgröße für responsive Textgrößen
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    // Passe Textgröße basierend auf Bildschirmbreite an, falls keine explizite Größe angegeben wurde
    final responsiveFontSize = isSmallScreen ? 16.0 : 18.0;

    // Passe Textgröße basierend auf Bildschirmbreite an
    final titleTextStyle = TextStyle(
      color: titleColor ?? AppTheme.textPrimaryColor, // Verwende übergebene Farbe oder Standard
      fontWeight: titleFontWeight ?? FontWeight.bold, // Verwende übergebene Dicke oder Standard
      fontSize: titleFontSize ?? responsiveFontSize, // Verwende übergebene Größe oder responsive Standard
    );

    return AppBar(
      title: Text(
        // Lokalisierter Titel, falls es ein Übersetzungsschlüssel ist
        title.startsWith('_') ? context.tr(title.substring(1)) : title,
        style: titleTextStyle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      backgroundColor: backgroundColor ?? AppTheme.backgroundColor,
      elevation: elevation,
      centerTitle: true,
      leading: showBackButton
          ? leading ??
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: AppTheme.textPrimaryColor),
            onPressed: onBackPressed ?? () {
              // Verwende WillPopScope's Verhalten für Navigation zurück
              Navigator.of(context).maybePop();
            },
            tooltip: context.tr('back'),
          )
          : leading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}