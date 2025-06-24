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
        AndroidInitializationSettings('@mipmap/ic_notify_foreground');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSettingsDarwin,
    );

    await _localNotificationService.initialize(settings);
  }

  Future<NotificationDetails> _notificationDetail() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("channel_id", "channel_name",
            channelDescription: "description",
            importance: Importance.max,
            priority: Priority.max,
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

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    showNotification(
      id: id,
      title: title ?? LocaleKeys.texts_notification.tr,
      body: body ?? LocaleKeys.texts_notification_description.tr,
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final detail = await _notificationDetail();
    await _localNotificationService.show(id, title, body, detail);
  }

  Future<void> showScheduleNotification({
    required int id,
    required String title,
    required String body,
    required int second,
  }) async {
    final detail = await _notificationDetail();
    await _localNotificationService.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(
            DateTime.now().add(Duration(seconds: second)), tz.local),
        detail,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
