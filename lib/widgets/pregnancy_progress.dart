import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    // Total pregnancy is generally considered 40 weeks
    final progress = weeksPregnant / 40;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Week $weeksPregnant',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              '$daysLeft days to go',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 12,
            backgroundColor: Colors.white.withOpacity(0.3),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Due Date: ${DateFormat('MMM dd, yyyy').format(dueDate)}',
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),
        _buildTrimesterIndicator(context, weeksPregnant),
      ],
    );
  }

  Widget _buildTrimesterIndicator(BuildContext context, int weeks) {
    String trimester;
    String description;

    if (weeks <= 13) {
      trimester = '1st Trimester';
      description = 'Development of major organs and systems';
    } else if (weeks <= 27) {
      trimester = '2nd Trimester';
      description = 'Baby\'s growth and movement becomes noticeable';
    } else {
      trimester = '3rd Trimester';
      description = 'Final growth and preparation for birth';
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.white.withOpacity(0.9),
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trimester,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  description,
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
    );
  }
}