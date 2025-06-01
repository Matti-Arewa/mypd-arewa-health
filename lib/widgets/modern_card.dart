// widgets/modern_card.dart
import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class ModernCard extends StatefulWidget {
  final Widget child;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final bool enableAnimation;
  final Color? backgroundColor;
  final double? borderRadius;
  final List<BoxShadow>? customShadows;

  const ModernCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.enableAnimation = true,
    this.backgroundColor,
    this.borderRadius,
    this.customShadows,
  });

  @override
  State<ModernCard> createState() => _ModernCardState();
}

class _ModernCardState extends State<ModernCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    if (widget.enableAnimation) {
      _animationController = AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      );

      _scaleAnimation = Tween<double>(
        begin: 1.0,
        end: 0.95,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ));
    }
  }

  @override
  void dispose() {
    if (widget.enableAnimation) {
      _animationController.dispose();
    }
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.enableAnimation && widget.onTap != null) {
      _animationController.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.enableAnimation && widget.onTap != null) {
      _animationController.reverse();
    }
  }

  void _onTapCancel() {
    if (widget.enableAnimation && widget.onTap != null) {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 360;

    Widget cardWidget = Container(
      padding: widget.padding ?? EdgeInsets.all(isSmallScreen ? 16 : 20),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 16),
        boxShadow: widget.customShadows ?? [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: widget.child,
    );

    if (widget.onTap != null) {
      cardWidget = GestureDetector(
        onTap: widget.onTap,
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: cardWidget,
      );
    }

    if (widget.enableAnimation && widget.onTap != null) {
      return AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: cardWidget,
          );
        },
      );
    }

    return cardWidget;
  }
}

// Beispiel-Verwendung für bestehende Screens:

class ModernListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Widget? trailing;

  const ModernListItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.iconColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 360;

    return ModernCard(
      onTap: onTap,
      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(isSmallScreen ? 10 : 12),
            decoration: BoxDecoration(
              color: (iconColor ?? AppTheme.primaryColor).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor ?? AppTheme.primaryColor,
              size: isSmallScreen ? 20 : 24,
            ),
          ),
          SizedBox(width: isSmallScreen ? 12 : 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 16 : 18,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
                SizedBox(height: isSmallScreen ? 4 : 6),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 14 : 16,
                    color: AppTheme.textSecondaryColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) ...[
            SizedBox(width: isSmallScreen ? 8 : 12),
            trailing!,
          ] else if (onTap != null)
            Icon(
              Icons.arrow_forward_ios,
              size: isSmallScreen ? 16 : 18,
              color: AppTheme.textSecondaryColor,
            ),
        ],
      ),
    );
  }
}

// Gradient Background Widget
class ModernGradientBackground extends StatelessWidget {
  final Widget child;
  final List<Color>? colors;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  const ModernGradientBackground({
    super.key,
    required this.child,
    this.colors,
    this.begin = Alignment.topCenter,
    this.end = Alignment.bottomCenter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: colors ?? [
            AppTheme.primaryColor.withOpacity(0.05),
            AppTheme.backgroundColor,
            AppTheme.accentColor.withOpacity(0.1),
          ],
        ),
      ),
      child: child,
    );
  }
}

// Modern Button Widget
class ModernElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isLoading;
  final bool isOutlined;

  const ModernElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.isLoading = false,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 360;

    if (isOutlined) {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: isLoading ? null : onPressed,
          icon: isLoading
              ? SizedBox(
            height: 16,
            width: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                backgroundColor ?? AppTheme.primaryColor,
              ),
            ),
          )
              : Icon(icon ?? Icons.arrow_forward_outlined),
          label: Text(
            text,
            style: TextStyle(
              fontSize: isSmallScreen ? 16 : 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: foregroundColor ?? AppTheme.primaryColor,
            side: BorderSide(
              color: backgroundColor ?? AppTheme.primaryColor,
              width: 1.5,
            ),
            padding: EdgeInsets.symmetric(
              vertical: isSmallScreen ? 14 : 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? SizedBox(
          height: 16,
          width: 16,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : Icon(icon ?? Icons.arrow_forward_outlined),
        label: Text(
          text,
          style: TextStyle(
            fontSize: isSmallScreen ? 16 : 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppTheme.primaryColor,
          foregroundColor: foregroundColor ?? Colors.white,
          padding: EdgeInsets.symmetric(
            vertical: isSmallScreen ? 14 : 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      ),
    );
  }
}