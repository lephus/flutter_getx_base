import 'dart:async';

import 'package:flutter/material.dart' hide CarouselController;
//
import 'package:flutter_getx_base/app/core/di/di.dart';
import 'package:flutter_getx_base/app/core/widgets/message.util.dart';
import 'package:flutter_getx_base/app/data/enum/user.enum.dart';
import 'package:flutter_getx_base/app/data/models/register.model.dart';
import 'package:flutter_getx_base/app/data/models/token.model.dart';
import 'package:flutter_getx_base/app/data/repository/user.repository.dart';
import 'package:flutter_getx_base/app/modules/base/controllers/base.controller.dart';
import 'package:flutter_getx_base/app/routes/app_pages.dart';
import 'package:flutter_getx_base/generated/locales.g.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final UserRepository userRepository = getIt<UserRepository>();
  final BaseController baseController = BaseController.to;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailOrPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Rx<String> roleSelected = Rx<String>(RoleEnum.user);

  RxBool isLoading = RxBool(false);
  RxString firstNameValidate = RxString('');
  RxString lastNameValidate = RxString('');
  RxString emailValidate = RxString('');
  RxString phoneValidate = RxString('');
  RxString passwordValidate = RxString('');
  RxString confirmPasswordValidate = RxString('');

  RxBool obscureTextConfirmPassword = RxBool(true);
  RxBool obscureTextPassword = RxBool(true);

  RxString referrer = RxString('no');

  Timer? _debounce;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailOrPhoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> onRegister() async {
    RegisterModel registerModel = RegisterModel(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      role: roleSelected.value,
      password: passwordController.text.trim(),
    );

    if (checkEmailValidate()) {
      registerModel.email = emailOrPhoneController.text.toLowerCase().trim();
    } else {
      registerModel.phoneNumber =
          emailOrPhoneController.text.toLowerCase().trim();
    }

    final validateForm = validateRegisterForm();
    if (validateForm) {
      isLoading.value = true;
      final response = await userRepository.register(registerModel);
      isLoading.value = false;
      response.fold(
        (failed) {
          isLoading.value = false;
          showSnackBarError(
              message: LocaleKeys.register_email_or_phone_already_used.tr);
        },
        (right) async {
          MessageDialog.hideLoading();
          final TokenModel token = right['token'];
          BaseController.currentUser.value = right['user'];
          await baseController.storeToken(TokenModel(
            accessToken: token.accessToken,
            refreshToken: token.refreshToken,
            expiresIn: token.expiresIn,
          ));

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

          BaseController.handleSubscriptionNotify();
          isLoading.value = false;
          Get.offAllNamed(Routes.home);
        },
      );
    }
  }

  bool validateRegisterForm() {
    final result = checkUserNameValidate() &&
        checkPasswordValidate() &&
        checkConfirmPasswordValidate();
    return result;
  }

  bool checkUserNameValidate() {
    firstNameValidate.value = '';
    if (firstNameController.text.isEmpty) {
      firstNameValidate.value = LocaleKeys.validator_first_name_required.tr;
      return false;
    }

    lastNameValidate.value = '';
    if (lastNameController.text.isEmpty) {
      lastNameValidate.value = LocaleKeys.validator_last_name_required.tr;
      return false;
    }
    return true;
  }

  bool checkEmailValidate() {
    emailValidate.value = '';
    if (emailOrPhoneController.text.isEmpty) {
      emailValidate.value = LocaleKeys.validator_email_required.tr;
      return false;
    }
    return true;
  }

  bool checkPasswordValidate() {
    passwordValidate.value = '';
    if (passwordController.text.isEmpty) {
      passwordValidate.value = LocaleKeys.validator_password_required.tr;
      return false;
    }
    if (passwordController.text.length < 8) {
      passwordValidate.value = LocaleKeys.validator_password_least_eight.tr;
      return false;
    }
    return true;
  }

  bool checkConfirmPasswordValidate() {
    confirmPasswordValidate.value = '';
    if (passwordController.text != confirmPasswordController.text) {
      confirmPasswordValidate.value = LocaleKeys.validator_wrong_information.tr;
      return false;
    }
    return true;
  }
}
