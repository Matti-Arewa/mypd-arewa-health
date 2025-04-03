import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final Widget? leading;
  final double elevation;
  final Color? backgroundColor;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.showBackButton = true,
    this.leading,
    this.elevation = 0,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: AppTheme.textPrimaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: backgroundColor ?? AppTheme.backgroundColor,
      elevation: elevation,
      centerTitle: true,
      leading: showBackButton
          ? leading ??
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: AppTheme.textPrimaryColor),
            onPressed: () => Navigator.of(context).pop(),
          )
          : leading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}