import 'package:flutter/material.dart';
import 'package:flutter_getx_base/generated/locales.g.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:timezone/timezone.dart' as tz;

@injectable
class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher_foreground');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSettingsDarwin,
    );

    await _localNotificationService.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          onDidReceiveNotificationResponse, // ⚡ Thêm xử lý khi bấm notification
    );
  }

  void onDidReceiveNotificationResponse(NotificationResponse response) {
    final payload = response.payload;
    // Xử lý logic, ví dụ:
    // nếu payload có route, điều hướng tới màn hình khác
    if (payload != null) {
      debugPrint('Notification payload: $payload');
      // Navigate to a specific screen if needed
    }
  }

  Future<NotificationDetails> _notificationDetail() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("channel_id", "channel_name",
            channelDescription: "description",
            importance: Importance.max,
            priority: Priority.max,
            showWhen: true,
            playSound: true);

    const DarwinNotificationDetails iosNotificationDetail =
        DarwinNotificationDetails(
      sound: 'default.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      presentBanner: true,
    );

    return const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetail,
      macOS: iosNotificationDetail,
    );
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    // Nếu thời gian đã qua trong ngày hôm nay, thì đặt lịch cho ngày hôm sau
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    showNotification(
      id: id,
      title: title ?? LocaleKeys.texts_notification.tr,
      body: body ?? 'Hi, have a good day!',
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    try {
      final detail = await _notificationDetail();
      await _localNotificationService.show(id, title, body, detail);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> showScheduleNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    final detail = await _notificationDetail();
    await _localNotificationService.zonedSchedule(
      id,
      title,
      body,
      _nextInstanceOfTime(hour, minute),
      detail,
      androidScheduleMode: AndroidScheduleMode.exact,
    );
  }

  Future<void> cancel({required int id}) async {
    try {
      await _localNotificationService.cancel(id);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> isDailyNotificationScheduled() async {
    try {
      final pendingNotifications =
          await _localNotificationService.pendingNotificationRequests();
      final exists = pendingNotifications.any((n) => n.id == 0);

      debugPrint('Daily notification check: $exists');
      debugPrint('Total pending notifications: ${pendingNotifications.length}');

      return exists;
    } catch (e) {
      debugPrint('Error in isDailyNotificationScheduled: $e');
      return false;
    }
  }
}
