import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/content_model.dart';
import '../services/localization_service.dart';

class AppUtils {
  // Format date
  static String formatDate(DateTime date, BuildContext context) {
    return DateFormat.yMMMd(context.loc.locale.languageCode).format(date);
  }

  // Format date with time
  static String formatDateTime(DateTime date, BuildContext context) {
    return DateFormat.yMMMd(context.loc.locale.languageCode).add_Hm().format(date);
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
  static String getCurrentTrimester(int pregnancyWeek, BuildContext context) {
    if (pregnancyWeek < 1) return context.tr('prePregnancy');
    if (pregnancyWeek <= 13) return context.tr('firstTrimester');
    if (pregnancyWeek <= 26) return context.tr('secondTrimester');
    if (pregnancyWeek <= 40) return context.tr('thirdTrimester');
    return context.tr('postTerm');
  }

  // Get baby size comparison for current week
  static String getBabySizeComparison(int pregnancyWeek, BuildContext context) {
    String size;

    switch (pregnancyWeek) {
      case 4:
        size = context.tr('sizePoppy');
        break;
      case 5:
        size = context.tr('sizeSesame');
        break;
      case 6:
        size = context.tr('sizeLentil');
        break;
      case 7:
        size = context.tr('sizeBlueberry');
        break;
      case 8:
        size = context.tr('sizeRaspberry');
        break;
      case 9:
        size = context.tr('sizeGrape');
        break;
      case 10:
        size = context.tr('sizeStrawberry');
        break;
      case 11:
        size = context.tr('sizeLime');
        break;
      case 12:
        size = context.tr('sizePlum');
        break;
      case 13:
        size = context.tr('sizePeach');
        break;
      case 14:
        size = context.tr('sizeLemon');
        break;
      case 15:
        size = context.tr('sizeApple');
        break;
      case 16:
        size = context.tr('sizeAvocado');
        break;
      case 17:
        size = context.tr('sizePear');
        break;
      case 18:
        size = context.tr('sizeBellPepper');
        break;
      case 19:
        size = context.tr('sizeMango');
        break;
      case 20:
        size = context.tr('sizeBanana');
        break;
      case 21:
        size = context.tr('sizeCarrot');
        break;
      case 22:
        size = context.tr('sizePapaya');
        break;
      case 23:
        size = context.tr('sizeGrapefruit');
        break;
      case 24:
        size = context.tr('sizeEarOfCorn');
        break;
      case 25:
        size = context.tr('sizeCauliflower');
        break;
      case 26:
        size = context.tr('sizeLettuce');
        break;
      case 27:
        size = context.tr('sizeRutabaga');
        break;
      case 28:
        size = context.tr('sizeEggplant');
        break;
      case 29:
        size = context.tr('sizeButternutSquash');
        break;
      case 30:
        size = context.tr('sizeCabbage');
        break;
      case 31:
        size = context.tr('sizeCoconut');
        break;
      case 32:
        size = context.tr('sizeSquash');
        break;
      case 33:
        size = context.tr('sizePineapple');
        break;
      case 34:
        size = context.tr('sizeCantaloupe');
        break;
      case 35:
        size = context.tr('sizeHoneydew');
        break;
      case 36:
        size = context.tr('sizeRomaineLettuce');
        break;
      case 37:
        size = context.tr('sizeSwissChard');
        break;
      case 38:
        size = context.tr('sizeLeek');
        break;
      case 39:
        size = context.tr('sizeWatermelon');
        break;
      case 40:
        size = context.tr('sizePumpkin');
        break;
      default:
        if (pregnancyWeek < 4) return context.tr('sizeSmallerThanPoppy');
        if (pregnancyWeek > 40) return context.tr('sizePumpkin');
        return context.tr('sizeGrowingBaby');
    }

    return size;
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

      bool matchesQuestions = false;
      for (final question in category.questions) {
        if (question.question.toLowerCase().contains(lowercaseQuery) ||
            question.answer.toLowerCase().contains(lowercaseQuery)) {
          matchesQuestions = true;
          break;
        }
      }

      return matchesTitle || matchesQuestions;
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
        String? buttonText,
      }) async {
    final localizedButtonText = buttonText ?? context.tr('ok');

    // Responsive design adjustments
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    // Adjust sizes based on screen size
    final titleFontSize = isSmallScreen ? 16.0 : 18.0;
    final contentFontSize = isSmallScreen ? 14.0 : 16.0;
    final buttonFontSize = isSmallScreen ? 13.0 : 14.0;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontSize: titleFontSize),
          ),
          content: Text(
            content,
            style: TextStyle(fontSize: contentFontSize),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                localizedButtonText,
                style: TextStyle(fontSize: buttonFontSize),
              ),
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
        String? confirmText,
        String? cancelText,
      }) async {
    final localizedConfirmText = confirmText ?? context.tr('yes');
    final localizedCancelText = cancelText ?? context.tr('no');

    // Responsive design adjustments
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    // Adjust sizes based on screen size
    final titleFontSize = isSmallScreen ? 16.0 : 18.0;
    final contentFontSize = isSmallScreen ? 14.0 : 16.0;
    final buttonFontSize = isSmallScreen ? 13.0 : 14.0;

    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontSize: titleFontSize),
          ),
          content: Text(
            content,
            style: TextStyle(fontSize: contentFontSize),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                localizedCancelText,
                style: TextStyle(fontSize: buttonFontSize),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text(
                localizedConfirmText,
                style: TextStyle(fontSize: buttonFontSize),
              ),
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