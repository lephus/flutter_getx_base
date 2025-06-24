import 'package:flutter_getx_base/app/modules/base/controllers/base.controller.dart';
import 'package:flutter_getx_base/app/modules/base/controllers/splash.controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BaseController>(BaseController());
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
  }
}
