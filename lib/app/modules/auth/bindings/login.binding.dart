import 'package:get/get.dart';

import 'package:flutter_getx_base/app/modules/auth/controllers/login.controller.dart';
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
