import 'package:get/get.dart';
import 'package:flutter_getx_base/app/modules/base/controllers/base.controller.dart';
import 'package:flutter_getx_base/app/modules/home/controllers/home.controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BaseController>(
      () => BaseController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
