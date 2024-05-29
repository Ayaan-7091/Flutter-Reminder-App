import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../Model/Reminder.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> initializeNotifications() async {
  // Initialize the timezone
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('India/Delhi'));

  // Configure notification plugin
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,

  );
}

Future<void> selectNotification(String? payload) async {
  // Handle notification tap
}

Future<void> scheduleNotification(Reminder reminder, int id) async {
  final androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'channel id',
    'channel name',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );

  final iOSPlatformChannelSpecifics = DarwinNotificationDetails();


  final platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );

  final scheduledTime = tz.TZDateTime.from(
    reminder.time as DateTime,
    tz.local,
  );

  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    reminder.title,
    reminder.description,
    scheduledTime,
    platformChannelSpecifics,
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
    UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}

Future<void> cancelNotification(int id) async {
  await flutterLocalNotificationsPlugin.cancel(id);
}
