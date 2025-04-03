import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/content_model.dart';

class AppUtils {
  // Format date
  static String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  // Format date with time
  static String formatDateTime(DateTime date) {
    return DateFormat('MMM dd, yyyy - HH:mm').format(date);
  }

  // Calculate weeks between two dates
  static int weeksBetween(DateTime from, DateTime to) {
    return ((to.difference(from).inDays) / 7).floor();
  }

  // Calculate pregnancy week based on due date
  static int calculatePregnancyWeek(DateTime dueDate) {
    final now = DateTime.now();
    final startDate = dueDate.subtract(const Duration(days: 280));
    final weeksPassed = weeksBetween(startDate, now);
    return weeksPassed > 42 ? 42 : weeksPassed;
  }

  // Calculate trimester based on pregnancy week
  static String getCurrentTrimester(int pregnancyWeek) {
    if (pregnancyWeek < 1) return "Pre-pregnancy";
    if (pregnancyWeek <= 13) return "First Trimester";
    if (pregnancyWeek <= 26) return "Second Trimester";
    if (pregnancyWeek <= 40) return "Third Trimester";
    return "Post-term";
  }

  // Get baby size comparison for current week
  static String getBabySizeComparison(int pregnancyWeek) {
    switch (pregnancyWeek) {
      case 4:
        return "Poppy seed";
      case 5:
        return "Sesame seed";
      case 6:
        return "Lentil";
      case 7:
        return "Blueberry";
      case 8:
        return "Raspberry";
      case 9:
        return "Grape";
      case 10:
        return "Strawberry";
      case 11:
        return "Lime";
      case 12:
        return "Plum";
      case 13:
        return "Peach";
      case 14:
        return "Lemon";
      case 15:
        return "Apple";
      case 16:
        return "Avocado";
      case 17:
        return "Pear";
      case 18:
        return "Bell pepper";
      case 19:
        return "Mango";
      case 20:
        return "Banana";
      case 21:
        return "Carrot";
      case 22:
        return "Papaya";
      case 23:
        return "Grapefruit";
      case 24:
        return "Ear of corn";
      case 25:
        return "Cauliflower";
      case 26:
        return "Lettuce";
      case 27:
        return "Rutabaga";
      case 28:
        return "Eggplant";
      case 29:
        return "Butternut squash";
      case 30:
        return "Cabbage";
      case 31:
        return "Coconut";
      case 32:
        return "Squash";
      case 33:
        return "Pineapple";
      case 34:
        return "Cantaloupe";
      case 35:
        return "Honeydew melon";
      case 36:
        return "Romaine lettuce";
      case 37:
        return "Swiss chard";
      case 38:
        return "Leek";
      case 39:
        return "Watermelon";
      case 40:
        return "Small pumpkin";
      default:
        if (pregnancyWeek < 4) return "Smaller than a poppy seed";
        if (pregnancyWeek > 40) return "Small pumpkin";
        return "Growing baby";
    }
  }

  // Format duration in a human-readable way
  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  // Filter categories based on search query
  static List<ContentCategory> filterCategories(List<ContentCategory> categories, String query) {
    if (query.isEmpty) return categories;

    final lowercaseQuery = query.toLowerCase();
    return categories.where((category) {
      final matchesTitle = category.title.toLowerCase().contains(lowercaseQuery);
      final matchesDescription = category.description.toLowerCase().contains(lowercaseQuery);

      bool matchesQuestions = false;
      for (final question in category.questions) {
        if (question.question.toLowerCase().contains(lowercaseQuery) ||
            question.answer.toLowerCase().contains(lowercaseQuery)) {
          matchesQuestions = true;
          break;
        }
      }

      return matchesTitle || matchesDescription || matchesQuestions;
    }).toList();
  }

  // Launch URL
  static Future<void> launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Show a basic dialog
  static Future<void> showInfoDialog(
      BuildContext context, {
        required String title,
        required String content,
        String buttonText = 'OK',
      }) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text(buttonText),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Show a confirmation dialog
  static Future<bool> showConfirmationDialog(
      BuildContext context, {
        required String title,
        required String content,
        String confirmText = 'Yes',
        String cancelText = 'No',
      }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text(cancelText),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text(confirmText),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
    return result ?? false;
  }
}