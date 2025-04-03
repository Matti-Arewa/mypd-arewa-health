import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_init;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsService {
  static final NotificationsService _instance =
  NotificationsService._internal();
  factory NotificationsService() => _instance;
  NotificationsService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz_init.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

    // Verwende DarwinInitializationSettings für iOS
    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        if (notificationResponse.payload != null) {
          debugPrint('Notification payload: ${notificationResponse.payload}');
        }
      },
    );
  }

  Future<void> scheduleMilestoneNotifications(DateTime dueDate) async {
    // Aktuelles Datum
    final now = DateTime.now();

    // Schwangerschaftsstart: 280 Tage vor dem Due Date
    final pregnancyStartDate = dueDate.subtract(const Duration(days: 280));

    // Berechne die aktuelle Schwangerschaftswoche
    final differenceInDays = now.difference(pregnancyStartDate).inDays;
    final currentWeek = (differenceInDays / 7).floor();

    // Plane wöchentliche Benachrichtigungen für die verbleibenden Wochen
    for (int week = currentWeek + 1; week <= 40; week++) {
      await _scheduleWeeklyNotification(week, pregnancyStartDate);
    }

    // Speichere das Due Date in den SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('due_date', dueDate.toIso8601String());
  }

  Future<void> _scheduleWeeklyNotification(
      int week, DateTime pregnancyStartDate) async {
    final notificationDate = pregnancyStartDate.add(Duration(days: week * 7));

    // Keine Planung, falls das Datum in der Vergangenheit liegt
    if (notificationDate.isBefore(DateTime.now())) {
      return;
    }

    // Hole den Meilenstein-Text für die jeweilige Woche
    final milestone = _getMilestoneForWeek(week);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      week, // Verwende die Woche als Notification-ID
      'Week $week of Your Pregnancy',
      milestone,
      tz.TZDateTime.from(notificationDate, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'pregnancy_milestones',
          'Pregnancy Milestones',
          channelDescription: 'Weekly updates about your pregnancy progress',
          importance: Importance.high,
          priority: Priority.high,
          color: Color(0xFFE5C1CD),
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: 'week_$week',
    );
  }

  String _getMilestoneForWeek(int week) {
    // Beispielhafte Meilensteine – in der Realität können diese aus deiner Content-Datenbank stammen
    switch (week) {
      case 4:
        return "Your baby is now the size of a poppy seed. The amniotic sac forms.";
      case 8:
        return "Your baby is now the size of a raspberry. All essential organs have begun to form!";
      case 12:
        return "Your baby is now the size of a lime. The baby's reflexes are developing!";
      case 16:
        return "Your baby is now the size of an avocado. You might start feeling the baby move!";
      case 20:
        return "Halfway there! Your baby is now the size of a banana. You might have your anatomy scan soon.";
      case 24:
        return "Your baby is now the size of an ear of corn. Your baby's face is fully formed!";
      case 28:
        return "Your baby is now the size of an eggplant. The baby can open their eyes!";
      case 32:
        return "Your baby is now the size of a squash. The baby is practicing breathing!";
      case 36:
        return "Your baby is now the size of a head of romaine lettuce. The baby is getting ready for birth!";
      case 40:
        return "Your baby is now the size of a small pumpkin. You're at your due date!";
      default:
        return "Week $week: Your pregnancy is progressing well. Keep up with your prenatal appointments!";
    }
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> requestPermissions() async {
    // Für iOS: Verwende den iOS-spezifischen Plugin
    final IOSFlutterLocalNotificationsPlugin ? iosPlugin =
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin >();

    await iosPlugin?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
