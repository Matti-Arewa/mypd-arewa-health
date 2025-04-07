//widgets/pregnancy_progress.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/app_theme.dart';

class PregnancyProgress extends StatelessWidget {
  final int weeksPregnant;
  final int daysLeft;
  final DateTime dueDate;

  const PregnancyProgress({
    Key? key,
    required this.weeksPregnant,
    required this.daysLeft,
    required this.dueDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate total pregnancy duration and progress
    const totalWeeks = 40;
    final progress = weeksPregnant / totalWeeks;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$weeksPregnant Wochen',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              'Termin: ${DateFormat('dd.MM.yyyy').format(dueDate)}',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Custom progress bar
        Container(
          height: 24,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              // Progress fill
              FractionallySizedBox(
                widthFactor: progress.clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.accentColor,
                        AppTheme.accentColor.withOpacity(0.7),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),

              // Pregnancy milestones markers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMilestoneMarker(0.25, progress >= 0.25, '10'),
                  _buildMilestoneMarker(0.5, progress >= 0.5, '20'),
                  _buildMilestoneMarker(0.75, progress >= 0.75, '30'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Days remaining
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Fortschritt',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            Text(
              '$daysLeft Tage verbleibend',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),

        // Baby size comparison
        if (weeksPregnant > 4 && weeksPregnant < 41) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  _getBabySizeIcon(weeksPregnant),
                  color: Colors.white,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Größenvergleich',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        _getBabySizeDescription(weeksPregnant),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildMilestoneMarker(double position, bool isReached, String label) {
    return Container(
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isReached
            ? Colors.white
            : Colors.white.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isReached ? AppTheme.primaryColor : Colors.white.withOpacity(0.7),
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  IconData _getBabySizeIcon(int week) {
    if (week < 8) {
      return Icons.egg_outlined;
    } else if (week < 14) {
      return Icons.egg_alt;
    } else if (week < 24) {
      return Icons.spa;
    } else {
      return Icons.child_care;
    }
  }

  String _getBabySizeDescription(int week) {
    if (week < 8) {
      return 'Dein Baby ist etwa so groß wie ein Reiskorn (< 1 cm)';
    } else if (week < 12) {
      return 'Dein Baby ist etwa so groß wie eine Erdbeere (3 cm)';
    } else if (week < 16) {
      return 'Dein Baby ist etwa so groß wie eine Zitrone (9 cm)';
    } else if (week < 20) {
      return 'Dein Baby ist etwa so groß wie eine Avocado (16 cm)';
    } else if (week < 24) {
      return 'Dein Baby ist etwa so groß wie eine Papaya (25 cm)';
    } else if (week < 28) {
      return 'Dein Baby ist etwa so groß wie ein Kohlkopf (35 cm)';
    } else if (week < 32) {
      return 'Dein Baby ist etwa so groß wie ein Kokosnuss (40 cm)';
    } else if (week < 36) {
      return 'Dein Baby ist etwa so groß wie ein Romakopfsalat (45 cm)';
    } else {
      return 'Dein Baby ist fast bereit für die Geburt (45-50 cm)';
    }
  }
}