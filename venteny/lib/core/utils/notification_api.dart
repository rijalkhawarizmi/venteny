import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'dart:async';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final _notifications = FlutterLocalNotificationsPlugin();
  static Future<void> _configuretime() async {
    tz.initializeTimeZones();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
    final timeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }
  
static void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
  }
  static Future init() async {
    _configuretime();

    // for icon I take on link -> <a href="https://www.flaticon.com/free-icons/files-and-folders" title="files and folders icons">Files and folders icons created by manshagraphics - Flaticon</a>
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = DarwinInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: iOS);
    await _notifications.initialize(settings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
   );
  }

  

  static Future _notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          icon: '@mipmap/ic_launcher',
          channelDescription: 'channel description',
          importance: Importance.max,
          priority: Priority.high
        ),
        iOS: DarwinNotificationDetails());
  }

  

  static Future showScheduledNotification(
      {required int id,
      String? title,
      String? body,
      String? payload,
      int? hour,
      int? minutes,
      int? date,
      int? month,
      int? year // required DateTime timer
      }) async {
//         final tz.TZDateTime scheduledDate = tz.TZDateTime(
//     tz.local, year!, month!, date!, hour!,minutes!
//   );

//   print("Scheduled notification at: $scheduledDate");
//   final now = tz.TZDateTime.now(tz.local);
// print("⏰ Sekarang: $now");
// print("📅 Jadwal Notifikasi: $scheduledDate");

// if (scheduledDate.isBefore(now)) {
//   print("⚠️ scheduledDate sudah lewat!");
// }
    _notifications.zonedSchedule(
        id,
        title,
        body,
        _scheduledDaily(hour, minutes, date, month, year),
        await _notificationDetails(),
        payload: payload,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime);
  }

  

  static tz.TZDateTime _scheduledDaily(
      int? hour, int? minutes, int? date, int? month, int? year) {
        
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, year ?? now.year,
        month ?? now.month, date ?? now.day, hour!, minutes!);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  static cancelNotification(int id) async {
    await _notifications.cancel(id);
  }
}
