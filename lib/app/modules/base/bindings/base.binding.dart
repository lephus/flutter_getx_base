import 'package:flutter_getx_base/app/modules/base/controllers/base.controller.dart';
import 'package:flutter_getx_base/app/modules/home/controllers/home.controller.dart';
import 'package:get/get.dart';

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BaseController>(BaseController());
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
