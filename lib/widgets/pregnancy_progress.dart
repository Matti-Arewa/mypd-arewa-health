//widgets/pregnancy_progress.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/app_theme.dart';

class PregnancyProgress extends StatelessWidget {
  final int weeksPregnant;
  final int daysLeft;
  final DateTime dueDate;
  final bool compact; // Option für kompaktere Darstellung

  const PregnancyProgress({
    Key? key,
    required this.weeksPregnant,
    required this.daysLeft,
    required this.dueDate,
    this.compact = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Bildschirmbreite für responsive Anpassungen
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate total pregnancy duration and progress
    const totalWeeks = 40;
    final progress = weeksPregnant / totalWeeks;

    // Schriftgrößen und Abstände abhängig vom compact-Modus anpassen
    final titleFontSize = compact ? 14.0 : 16.0;
    final subtitleFontSize = compact ? 12.0 : 14.0;
    final smallFontSize = compact ? 10.0 : 12.0;
    final progressBarHeight = compact ? 16.0 : 24.0;
    final verticalSpacing = compact ? 4.0 : 8.0;
    final sectionSpacing = compact ? 8.0 : 16.0;
    final milestoneMarkerSize = compact ? 16.0 : 20.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$weeksPregnant Wochen',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: titleFontSize,
              ),
            ),
            Text(
              'Termin: ${DateFormat('dd.MM.yyyy').format(dueDate)}',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: subtitleFontSize,
              ),
            ),
          ],
        ),
        SizedBox(height: verticalSpacing),

        // Custom progress bar
        Container(
          height: progressBarHeight,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(progressBarHeight / 2),
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
                    borderRadius: BorderRadius.circular(progressBarHeight / 2),
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
                  _buildMilestoneMarker(0.25, progress >= 0.25, '10', milestoneMarkerSize),
                  _buildMilestoneMarker(0.5, progress >= 0.5, '20', milestoneMarkerSize),
                  _buildMilestoneMarker(0.75, progress >= 0.75, '30', milestoneMarkerSize),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: verticalSpacing),

        // Days remaining
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Fortschritt',
              style: TextStyle(
                color: Colors.white,
                fontSize: smallFontSize,
              ),
            ),
            Text(
              '$daysLeft Tage verbleibend',
              style: TextStyle(
                color: Colors.white,
                fontSize: smallFontSize,
              ),
            ),
          ],
        ),

        // Baby size comparison - nur wenn die Woche passt und kompakter im compact-Modus
        if (weeksPregnant > 4 && weeksPregnant < 41) ...[
          if (compact) ...[
            SizedBox(height: verticalSpacing),
            Row(
              children: [
                Icon(
                  _getBabySizeIcon(weeksPregnant),
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    _getBabySizeCompactDescription(weeksPregnant),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: smallFontSize,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ] else ...[
            SizedBox(height: sectionSpacing),
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
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Größenvergleich',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: subtitleFontSize,
                          ),
                        ),
                        Text(
                          _getBabySizeDescription(weeksPregnant, screenWidth),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: smallFontSize,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ],
    );
  }

  Widget _buildMilestoneMarker(double position, bool isReached, String label, double size) {
    return Container(
      width: size,
      height: size,
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
          fontSize: size * 0.5, // Schriftgröße relativ zur Markergröße
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

  // Normale Beschreibung mit Größenangabe
  String _getBabySizeDescription(int week, double screenWidth) {
    // Für sehr kleine Bildschirme, kürzere Beschreibungen
    if (screenWidth < 360) {
      return _getBabySizeCompactDescription(week);
    }

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
      return 'Dein Baby ist etwa so groß wie eine Kokosnuss (40 cm)';
    } else if (week < 36) {
      return 'Dein Baby ist etwa so groß wie ein Romakopfsalat (45 cm)';
    } else {
      return 'Dein Baby ist fast bereit für die Geburt (45-50 cm)';
    }
  }

  // Kompaktere Beschreibung ohne Details
  String _getBabySizeCompactDescription(int week) {
    if (week < 8) {
      return 'Reiskorn (< 1 cm)';
    } else if (week < 12) {
      return 'Erdbeere (3 cm)';
    } else if (week < 16) {
      return 'Zitrone (9 cm)';
    } else if (week < 20) {
      return 'Avocado (16 cm)';
    } else if (week < 24) {
      return 'Papaya (25 cm)';
    } else if (week < 28) {
      return 'Kohlkopf (35 cm)';
    } else if (week < 32) {
      return 'Kokosnuss (40 cm)';
    } else if (week < 36) {
      return 'Romakopfsalat (45 cm)';
    } else {
      return 'Fast geburtsbereit (45-50 cm)';
    }
  }
}