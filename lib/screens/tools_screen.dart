import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../widgets/tool_card.dart';
import 'due_date_calculator_screen.dart';
import 'kick_counter_screen.dart';
import 'weight_tracker_screen.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pregnancy Tools',
          style: TextStyle(color: AppTheme.textPrimaryColor),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Interactive Tools',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Track your pregnancy and stay informed with these helpful tools.',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            ToolCard(
              title: 'Due Date Calculator',
              description: 'Calculate your estimated due date based on your last period.',
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
            const SizedBox(height: 16),
            ToolCard(
              title: 'Kick Counter',
              description: 'Track your baby\'s movements and kicks.',
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
            const SizedBox(height: 16),
            ToolCard(
              title: 'Weight Tracker',
              description: 'Monitor your weight throughout your pregnancy.',
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
            const SizedBox(height: 32),
            Text(
              'Coming Soon',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ToolCard(
              title: 'Contraction Timer',
              description: 'Time and track your contractions during labor.',
              icon: Icons.timer,
              color: Colors.grey,
              isDisabled: true,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('This feature will be available in the next update'),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            ToolCard(
              title: 'Baby Name Explorer',
              description: 'Browse and save your favorite baby names with meanings.',
              icon: Icons.child_care,
              color: Colors.grey,
              isDisabled: true,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('This feature will be available in the next update'),
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