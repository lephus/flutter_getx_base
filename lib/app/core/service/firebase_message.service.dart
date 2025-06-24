import 'dart:developer' as developer;
import 'dart:io';
import 'dart:math' as math;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_getx_base/app/core/service/hive.helper.dart';
import 'package:flutter_getx_base/app/core/service/local_notification.service.dart';
import 'package:flutter_getx_base/app/core/settings/app_key.dart';
import 'package:flutter_getx_base/app/modules/base/controllers/base.controller.dart';
import 'package:flutter_getx_base/generated/locales.g.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class FirebaseMessageService {
  FirebaseMessageService();
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static final LocalNotificationService localNotificationService =
      LocalNotificationService();

  static Future<void> initialize() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    String? fcmToken = '';
    try {
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        if (Platform.isIOS) {
          fcmToken = await FirebaseMessaging.instance.getAPNSToken();
        } else {
          fcmToken = await FirebaseMessaging.instance.getToken();
        }
        developer.log('======Firebase Messaging Token=====');
        developer.log(fcmToken ?? 'NO TOKEN');
        developer.log('====================================');
        if (fcmToken != null) {
          // DEVELOP ENV
          // handleSubscribeTopic("DEV_SYSTEM_PROMOTION");
          // handleSubscribeTopic("DEV_SYSTEM_NOTIFY");

          // PRODUCT ENV
          handleSubscribeTopic("SYSTEM_PROMOTION");
          handleSubscribeTopic("SYSTEM_NOTIFY");
        }
      }
    } catch (_) {
      // showSnackBarError(message: LocaleKeys.message_default_error.tr);
    }

    await HiveHelper.put(
      boxName: AppKey.box,
      keyValue: AppKey.fcmToken,
      value: fcmToken,
    );
    await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    messaging.onTokenRefresh.listen((fcmToken) async {
      await HiveHelper.put(
        boxName: AppKey.box,
        keyValue: AppKey.fcmToken,
        value: fcmToken,
      );
    }).onError((err) {});

    // Background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    //Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(message.notification);
      BaseController.onSetNotifyStatus(true);
    });
  }

  static void showNotification(RemoteNotification? notification) async {
    if (notification != null) {
      await localNotificationService.showNotification(
        id: math.Random().nextInt(99999),
        title: notification.title ?? '',
        body: notification.body ?? '',
      );
    } else {
      await localNotificationService.showNotification(
        id: math.Random().nextInt(99999),
        title: LocaleKeys.texts_notification.tr,
        body: LocaleKeys.texts_notification_description.tr,
      );
    }
  }

  //Subscribe the client app to a topic
  Future<void> subscribeToTopic(String topic) async {
    // DEVELOP ENV
    // await FirebaseMessaging.instance.subscribeToTopic('DEV_$topic');

    // PRODUCT ENV
    await FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  // In this example, suppose that all messages contain a data field with the key 'type'.
  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    // Get.offAndToNamed(Routes.notification);
  }

  static void subscribeNotifyById(String userId) async {
    handleSubscribeTopic(userId);
  }

  static void unsubscribeNotifyByTopic(String topic) async {
    try {
      developer.log('❌ ===> unsubscribeNotifyByTopic $topic');
      await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
    } catch (_) {}
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
  }

  static Future<void> handleSubscribeTopic(String topic) async {
    try {
      if (Platform.isIOS) {
        String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        if (apnsToken != null) {
          await FirebaseMessaging.instance.subscribeToTopic(topic).then(
              (value) => developer.log('✅ ===> subscribeNotifyById $topic'));
        } else {
          await Future<void>.delayed(
            const Duration(
              seconds: 3,
            ),
          );
          apnsToken = await FirebaseMessaging.instance.getAPNSToken();
          if (apnsToken != null) {
            await FirebaseMessaging.instance.subscribeToTopic(topic).then(
                (value) => developer.log('✅ ===> subscribeNotifyById $topic'));
          }
        }
      } else {
        await FirebaseMessaging.instance.subscribeToTopic(topic).then(
            (value) => developer.log('✅ ===> subscribeNotifyById $topic'));
      }
    } catch (e) {
      developer.log(e.toString());
    }
  }
}
