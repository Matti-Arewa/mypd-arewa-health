import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../widgets/tool_card.dart';
import 'due_date_calculator_screen.dart';
import 'kick_counter_screen.dart';
import 'weight_tracker_screen.dart';
import '../services/localization_service.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Responsive design adjustments
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360 || screenHeight < 600;

    // Adjust sizes based on screen size
    final titleFontSize = isSmallScreen ? 18.0 : 22.0;
    final subtitleFontSize = isSmallScreen ? 12.0 : 14.0;
    final sectionTitleFontSize = isSmallScreen ? 16.0 : 20.0;
    final padding = isSmallScreen ? 12.0 : 16.0;
    final spacing = isSmallScreen ? 8.0 : 16.0;
    final sectionSpacing = isSmallScreen ? 24.0 : 32.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('pregnancyTools'),
          style: TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: isSmallScreen ? 18.0 : 20.0,
          ),
        ),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.tr('interactiveTools'),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: titleFontSize,
              ),
            ),
            SizedBox(height: spacing / 2),
            Text(
              context.tr('toolsDescription'),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: subtitleFontSize,
              ),
            ),
            SizedBox(height: spacing * 1.5),
            ToolCard(
              title: context.tr('dueDateCalculator'),
              description: context.tr('dueDateCalculatorDesc'),
              icon: Icons.calendar_today,
              color: AppTheme.primaryColor,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const DueDateCalculatorScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: spacing),
            ToolCard(
              title: context.tr('kickCounter'),
              description: context.tr('kickCounterDesc'),
              icon: Icons.touch_app,
              color: AppTheme.accentColor,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const KickCounterScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: spacing),
            ToolCard(
              title: context.tr('weightTracker'),
              description: context.tr('weightTrackerDesc'),
              icon: Icons.monitor_weight,
              color: Colors.green,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const WeightTrackerScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: sectionSpacing),
            Text(
              context.tr('comingSoon'),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: sectionTitleFontSize,
              ),
            ),
            SizedBox(height: spacing),
            ToolCard(
              title: context.tr('contractionTimer'),
              description: context.tr('contractionTimerDesc'),
              icon: Icons.timer,
              color: Colors.grey,
              isDisabled: true,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(context.tr('featureComingSoon')),
                  ),
                );
              },
            ),
            SizedBox(height: spacing),
            ToolCard(
              title: context.tr('babyNameExplorer'),
              description: context.tr('babyNameExplorerDesc'),
              icon: Icons.child_care,
              color: Colors.grey,
              isDisabled: true,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(context.tr('featureComingSoon')),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}