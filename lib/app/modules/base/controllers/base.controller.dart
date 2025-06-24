import 'dart:async';

import 'package:flutter/material.dart' hide CarouselController;
//
import 'package:flutter_getx_base/app/core/di/di.dart';
import 'package:flutter_getx_base/app/core/service/dio/token_manager.dart';
import 'package:flutter_getx_base/app/core/service/firebase_message.service.dart';
import 'package:flutter_getx_base/app/core/service/hive.helper.dart';
import 'package:flutter_getx_base/app/core/settings/app_key.dart';
import 'package:flutter_getx_base/app/core/widgets/message.util.dart';
import 'package:flutter_getx_base/app/data/enum/language.enum.dart';
import 'package:flutter_getx_base/app/data/models/token.model.dart';
import 'package:flutter_getx_base/app/data/models/user.model.dart';
import 'package:flutter_getx_base/app/data/repository/user.repository.dart';
import 'package:flutter_getx_base/app/routes/app_pages.dart';
import 'package:get/get.dart';

class BaseController extends GetxService {
  final UserRepository userRepository = getIt<UserRepository>();

  final TokenManager _tokenManager = const TokenManager();
  static BaseController to = Get.find<BaseController>();
  //
  static Rx<UserModel> currentUser = Rx<UserModel>(UserModel(id: ''));

  static RxInt selectedIndex = RxInt(0);
  PageController pageController = PageController(initialPage: 0);
  int? inAppReviewCount;

  static RxBool isNewNotify = RxBool(true);

  @override
  void onInit() async {
    await initLocalTranslation();
    selectedIndex.value = 0;
    pageController = PageController(initialPage: selectedIndex.value);
    super.onInit();
  }

  void appRouter() {
    switch (selectedIndex.value) {
      case 0:
        Get.offAndToNamed(Routes.home); // Campaign
        break;
      default:
        break;
    }
  }

  Future<void> initLocalTranslation() async {
    final currentLocal =
        await HiveHelper.get(boxName: AppKey.box, keyValue: AppKey.language);
    if (currentLocal == LanguageEnum.vi) {
      Get.updateLocale(LanguageEnum.localeVi);
    } else {
      Get.updateLocale(LanguageEnum.localeEn);
    }
  }

  Future<void> getUserProfile() async {
    final response = await userRepository.authMe();
    response.fold(
      (failed) async {
        await Future.delayed(const Duration(milliseconds: 500));
        Get.offAllNamed(Routes.login);
      },
      (user) async {
        currentUser.value = user;
      },
    );
  }

  void setPageSelected(int pageIndex) {
    selectedIndex.value = pageIndex;
    appRouter();
  }

  Future<void> storeUserEmailAndPassword({
    required String emailOrPhone,
    required String password,
  }) async {
    await HiveHelper.put(
      boxName: AppKey.box,
      keyValue: AppKey.userEmailOrPhone,
      value: emailOrPhone,
    );

    await HiveHelper.put(
      boxName: AppKey.box,
      keyValue: AppKey.userPassword,
      value: password,
    );
  }

  Future<Map<String, String>> getUserEmailAndPassword() async {
    final userEmailOrPhone = await HiveHelper.get(
      boxName: AppKey.box,
      keyValue: AppKey.userEmailOrPhone,
    );
    final userPassword = await HiveHelper.get(
      boxName: AppKey.box,
      keyValue: AppKey.userPassword,
    );

    return {
      'userName': userEmailOrPhone ?? '',
      'password': userPassword ?? '',
    };
  }

  Future<void> onLogout() async {
    MessageDialog.showFinalizingPleaseWait();
    FirebaseMessageService.unsubscribeNotifyByTopic(currentUser.value.id);
    // Logout logic
    await _tokenManager.cleanAuthBox();

    await HiveHelper.delete(
      boxName: AppKey.box,
      keyValue: AppKey.accessToken,
    );

    await HiveHelper.delete(
      boxName: AppKey.box,
      keyValue: AppKey.refreshToken,
    );

    //
    await Future.delayed(const Duration(milliseconds: 1000));
    MessageDialog.hideLoading();
    await Future.delayed(const Duration(milliseconds: 500));
    Get.offAllNamed(Routes.login);
  }

  Future<void> storeToken(TokenModel token) async {
    await _tokenManager.setAccessToken(token.accessToken);
    await _tokenManager.setRefreshToken(token.refreshToken);
    await _tokenManager.setTokenExpiredTime(token.expiresIn);

    await HiveHelper.put(
      boxName: AppKey.box,
      keyValue: AppKey.accessToken,
      value: token.accessToken,
    );

    await HiveHelper.put(
      boxName: AppKey.box,
      keyValue: AppKey.refreshToken,
      value: token.refreshToken,
    );
  }

  get currentLocalLanguage =>
      HiveHelper.get(boxName: AppKey.box, keyValue: AppKey.language);
  get fcmToken => HiveHelper.get(
        boxName: AppKey.box,
        keyValue: AppKey.fcmToken,
      );

  static handleSubscriptionNotify() {
    try {
      FirebaseMessageService.handleSubscribeTopic("SYSTEM_PROMOTION");
      FirebaseMessageService.handleSubscribeTopic("SYSTEM_NOTIFY");
      FirebaseMessageService.handleSubscribeTopic(currentUser.value.id);
    } catch (_) {}
  }

  static onSetNotifyStatus(bool value) {
    isNewNotify.value = value;
    isNewNotify.refresh();
  }
}
