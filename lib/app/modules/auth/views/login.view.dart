import 'dart:io';

import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_getx_base/app/core/theme/app_colors.dart';
import 'package:flutter_getx_base/app/core/theme/app_size.dart';
import 'package:flutter_getx_base/app/core/theme/text_styles.dart';
import 'package:flutter_getx_base/app/core/utils/size_config.dart';
import 'package:flutter_getx_base/app/core/widgets/app_rounded_button.widget.dart';
import 'package:flutter_getx_base/app/core/widgets/app_text_form_field.widget.dart';
import 'package:flutter_getx_base/app/core/widgets/bottom_sheet.widget.dart';
import 'package:flutter_getx_base/app/core/widgets/image_view.widget.dart';
import 'package:flutter_getx_base/app/modules/auth/controllers/login.controller.dart';
import 'package:flutter_getx_base/app/modules/auth/widgets/role_options.widget.dart';
import 'package:flutter_getx_base/app/modules/base/views/language_options.widget.dart';
import 'package:flutter_getx_base/app/routes/app_pages.dart';
import 'package:flutter_getx_base/gen/assets.gen.dart';
import 'package:flutter_getx_base/generated/locales.g.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(AppSize.kHorizontalSpace),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 38),
                _buildLogo(),
                _buildTitle(),
                _buildEmail(),
                _buildPassword(),
                _buildLogin(),
                _buildFooter(),
                _buildSocialLogin(context),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 50,
          right: 0,
          child: LanguageOptionsWidget(),
        ),
      ],
    );
  }

  ImageViewWidget _buildLogo() => ImageViewWidget(
        Assets.icons.launcher.logoNoBg.path,
        width: 140,
      );

  Widget _buildFooter() {
    return Container(
      margin: const EdgeInsets.only(top: AppSize.kSpacing16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.login_done_have_acc.tr,
            style: AppStyles.body16,
          ),
          TextButton(
            onPressed: () => Get.toNamed(Routes.register),
            child: Text(
              LocaleKeys.register_register.tr,
              style: AppStyles.body16.copyWith(color: AppColors.kPrimary),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLogin() {
    return AppRoundedButton(
      margin: const EdgeInsets.only(top: AppSize.kSpacing12),
      onPressed: () => controller.onLogin(),
      isLoading: controller.isLoading.value,
      child: Text(
        LocaleKeys.login_login.tr,
        style: AppStyles.button16,
      ),
    );
  }

  Widget _buildSocialLogin(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSize.kHorizontalSpace),
      child: Column(
        children: [
          // Text(
          //   LocaleKeys.login_or.tr,
          //   style: AppStyles.body14.copyWith(color: AppColors.kDark6),
          // ),
          const SizedBox(height: AppSize.kSpacing18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialButton(
                InkWell(
                  onTap: () async {
                    showCommonBottomSheet(
                      maxHeight: SizeConfig.screenHeight / 2,
                      context,
                      child: Obx(
                        () => Column(
                          children: [
                            _buildRoleOption(),
                            AppRoundedButton(
                              margin: const EdgeInsets.all(
                                  AppSize.kHorizontalSpace),
                              onPressed: () async {
                                Get.back();
                                // await controller.googleLogin();
                              },
                              child: Text(LocaleKeys.button_confirm.tr),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(AppSize.kRadius12),
                  child: ImageViewWidget(
                    Assets.icons.icGoogle.path,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                  width: (Platform.isMacOS || Platform.isIOS)
                      ? AppSize.kSpacing28
                      : 0),
              (Platform.isMacOS || Platform.isIOS)
                  ? _buildSocialButton(
                      InkWell(
                        onTap: () async {
                          showCommonBottomSheet(
                            maxHeight: SizeConfig.screenHeight / 2,
                            context,
                            child: Obx(
                              () => Column(
                                children: [
                                  _buildRoleOption(),
                                  AppRoundedButton(
                                    margin: const EdgeInsets.all(
                                        AppSize.kHorizontalSpace),
                                    onPressed: () async {
                                      Get.back();
                                      // await controller.appleLogin();
                                    },
                                    child: Text(LocaleKeys.button_confirm.tr),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(AppSize.kRadius12),
                        child: ImageViewWidget(
                          Assets.icons.icApple.path,
                          width: 62,
                          height: 62,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }

  TextFieldWidget _buildPassword() {
    return TextFieldWidget(
      controller: controller.passwordController,
      obscureText: controller.isObscureText.value,
      textCapitalization: TextCapitalization.none,
      hintText: '********',
      maxLines: 1,
      errorText: controller.isPasswordError.isTrue
          ? LocaleKeys.login_password_incorrect.tr
          : '',
      label: LocaleKeys.texts_password.tr,
      suffixIcon:
          controller.isObscureText.value ? visibilityOffIc : visibilityIc,
      onTapSuffixIcon: () =>
          controller.isObscureText.value = !controller.isObscureText.value,
    );
  }

  TextFieldWidget _buildEmail() {
    return TextFieldWidget(
      controller: controller.emailOrPhoneController,
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
      hintText: 'email - phone',
      errorText: controller.isEmailError.isTrue
          ? LocaleKeys.login_email_incorrect.tr
          : '',
      label:
          '${LocaleKeys.texts_email_address.tr} ${LocaleKeys.texts_or.tr} ${LocaleKeys.register_phone_number.tr}',
    );
  }

  Widget _buildTitle() {
    return Container(
      margin: const EdgeInsets.only(top: AppSize.kSpacing32),
      padding: const EdgeInsets.only(bottom: AppSize.kSpacing32),
      child: Text(
        LocaleKeys.login_welcome_back.tr,
        style:
            AppStyles.heading36.copyWith(height: 1.28, color: AppColors.kDark6),
        textAlign: TextAlign.left,
      ),
    );
  }

  Icon get visibilityIc => const Icon(
        Icons.visibility,
        color: AppColors.kDark3,
      );

  Icon get visibilityOffIc => const Icon(
        Icons.visibility_off,
        color: AppColors.kDark3,
      );

  Widget _buildSocialButton(Widget child) {
    return Container(
      width: 58,
      height: 58,
      padding: const EdgeInsets.all(AppSize.kSpacing8),
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(1, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  Container _buildRoleOption() {
    return Container(
      margin: const EdgeInsets.all(AppSize.kHorizontalSpace),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoleOptionWidget(
            roleSelected: controller.roleSelected.value,
            onChanged: (value) => controller.roleSelected.value = value,
          ),
        ],
      ),
    );
  }
}
