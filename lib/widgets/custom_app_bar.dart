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
  final VoidCallback? onBackPressed; // Neuer Callback für explizite Navigation

  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.showBackButton = true,
    this.leading,
    this.elevation = 0,
    this.backgroundColor,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Berücksichtige die Bildschirmgröße für responsive Textgrößen
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    // Passe Textgröße basierend auf Bildschirmbreite an
    final titleTextStyle = TextStyle(
      color: AppTheme.textPrimaryColor,
      fontWeight: FontWeight.bold,
      fontSize: isSmallScreen ? 16.0 : 18.0, // Kleinere Schriftgröße auf kleinen Bildschirmen
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