import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_getx_base/app/core/di/di.dart';
import 'package:flutter_getx_base/app/core/widgets/message.util.dart';
import 'package:flutter_getx_base/app/data/enum/user.enum.dart';
import 'package:flutter_getx_base/app/data/models/login.model.dart';
import 'package:flutter_getx_base/app/data/models/token.model.dart';
import 'package:flutter_getx_base/app/data/repository/user.repository.dart';
import 'package:flutter_getx_base/app/modules/base/controllers/base.controller.dart';
import 'package:flutter_getx_base/app/routes/app_pages.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final UserRepository userRepository = getIt<UserRepository>();
  final BaseController baseController = BaseController.to;

  TextEditingController emailOrPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Rx<String> roleSelected = Rx<String>(RoleEnum.user);
  RxBool isLoading = RxBool(false);
  RxBool isEmailError = RxBool(false);
  RxBool isPasswordError = RxBool(false);
  RxBool isObscureText = RxBool(true);
  bool hasShownBottomSheet = false;

  @override
  void dispose() {
    emailOrPhoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> onLogin() async {
    final checkValidateForm = validateLoginForm();
    if (checkValidateForm) {
      // Validate successful
      isLoading.value = true;
      final response = await userRepository.login(
        LoginModel(
          userName: emailOrPhoneController.text.toLowerCase().trim(),
          password: passwordController.text.trim(),
        ),
      );
      response.fold(
        (failed) {
          isLoading.value = false;
          showSnackBarError(message: failed.message);
        },
        (right) async {
          await handleNavigateToApp(right);
        },
      );
    }
  }

  bool validateLoginForm() {
    isEmailError.value = false;
    isPasswordError.value = false;
    if (emailOrPhoneController.text.isEmpty) {
      isEmailError.value = true;
      return false;
    }
    if (passwordController.text.isEmpty) {
      isPasswordError.value = true;
      return false;
    }
    return true;
  }

  Future<void> handleNavigateToApp(Map<String, dynamic> right) async {
    final TokenModel token = right['token'];
    BaseController.currentUser.value = right['user'];

    String emailOrPhone = '';
    if (BaseController.currentUser.value.email != null) {
      BaseController.currentUser.value.email!.toLowerCase().trim();
    } else if (BaseController.currentUser.value.phoneNumber != null) {
      BaseController.currentUser.value.phoneNumber!.trim();
    }

    baseController.storeUserEmailAndPassword(
      emailOrPhone: emailOrPhone,
      password: passwordController.text.trim(),
    );

    await baseController.storeToken(TokenModel(
      accessToken: token.accessToken,
      refreshToken: token.refreshToken,
      expiresIn: token.expiresIn,
    ));
    BaseController.handleSubscriptionNotify();
    Get.offAllNamed(Routes.home);
  }

}
