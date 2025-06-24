import 'package:get/get.dart';
import 'package:flutter_getx_base/app/modules/auth/controllers/register.controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(),
    );
  }
}
