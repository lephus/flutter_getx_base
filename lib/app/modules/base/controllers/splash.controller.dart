import 'package:flutter_getx_base/app/core/di/di.dart';
import 'package:flutter_getx_base/app/data/models/user.model.dart';
import 'package:flutter_getx_base/app/data/repository/user.repository.dart';
import 'package:flutter_getx_base/app/modules/base/controllers/base.controller.dart';
import 'package:flutter_getx_base/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final UserRepository userRepository = getIt<UserRepository>();
  final BaseController baseController = BaseController.to;

  RxBool isLoading = RxBool(true);
  String userAgent = '';

  @override
  void onReady() async {
    await checkUserLogin();
    super.onReady();
  }

  Future<void> checkUserLogin() async {
    final response = await userRepository.authMe();

    isLoading.value = false;

    response.fold(
      (failed) async {
        Get.offAllNamed(Routes.login);
      },
      (user) async {
        await onNavigatedInToApp(user);
      },
    );
  }

  Future<void> onNavigatedInToApp(UserModel user) async {
    BaseController.handleSubscriptionNotify();
    Get.offAllNamed(Routes.home);
  }
}
