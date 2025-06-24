import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_getx_base/app/core/theme/app_colors.dart';
import 'package:flutter_getx_base/app/core/theme/app_size.dart';
import 'package:flutter_getx_base/app/core/theme/text_styles.dart';
import 'package:flutter_getx_base/app/core/widgets/app_rounded_button.widget.dart';
import 'package:flutter_getx_base/app/core/widgets/app_text_form_field.widget.dart';
import 'package:flutter_getx_base/app/modules/auth/controllers/register.controller.dart';
import 'package:flutter_getx_base/app/modules/auth/widgets/role_options.widget.dart';
//
import 'package:flutter_getx_base/generated/locales.g.dart';
import 'package:get/get.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Container _buildBody() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(AppSize.kHorizontalSpace),
      child: SingleChildScrollView(
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTitle(),
            _buildRoleOption(),
            _buildUserName(),
            _buildEmailOrPhoneNumber(),
            _buildPassword(),
            _buildConfirmPassword(),
            _buildRegister(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Container _buildRoleOption() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: AppSize.kSpacing20,
        top: AppSize.kSpacing16,
      ),
      child: RoleOptionWidget(
        roleSelected: controller.roleSelected.value,
        onChanged: (value) => controller.roleSelected.value = value,
      ),
    );
  }

  TextFieldWidget _buildEmailOrPhoneNumber() {
    return TextFieldWidget(
      controller: controller.emailOrPhoneController,
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
      errorText: controller.emailValidate.value,
      hintText:
          '${LocaleKeys.texts_email_address.tr} ${LocaleKeys.texts_or.tr} ${LocaleKeys.register_phone_number.tr}',
      label:
          '${LocaleKeys.texts_email_address.tr} ${LocaleKeys.texts_or.tr} ${LocaleKeys.register_phone_number.tr}',
    );
  }

  Widget _buildUserName() {
    return Row(
      children: [
        Expanded(
          child: TextFieldWidget(
            controller: controller.firstNameController,
            errorText: controller.firstNameValidate.value,
            label: LocaleKeys.register_first_name.tr,
            hintText: LocaleKeys.register_first_name.tr,
          ),
        ),
        const SizedBox(width: AppSize.kSpacing12),
        Expanded(
          child: TextFieldWidget(
            controller: controller.lastNameController,
            errorText: controller.lastNameValidate.value,
            label: LocaleKeys.register_last_name.tr,
            hintText: LocaleKeys.register_last_name.tr,
          ),
        )
      ],
    );
  }

  Row _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          LocaleKeys.register_have_acc.tr,
          style: AppStyles.body16,
        ),
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            LocaleKeys.login_login.tr,
            style: AppStyles.body16.copyWith(color: AppColors.kPrimary),
          ),
        )
      ],
    );
  }

  Container _buildRegister() {
    return Container(
      margin: const EdgeInsets.only(top: AppSize.kSpacing58),
      child: AppRoundedButton(
        onPressed: () => controller.onRegister(),
        isLoading: controller.isLoading.value,
        child: Text(
          LocaleKeys.register_register.tr,
          style: AppStyles.button18,
        ),
      ),
    );
  }

  TextFieldWidget _buildConfirmPassword() {
    return TextFieldWidget(
      controller: controller.confirmPasswordController,
      errorText: controller.confirmPasswordValidate.value,
      obscureText: controller.obscureTextConfirmPassword.value,
      maxLines: 1,
      textCapitalization: TextCapitalization.none,
      suffixIcon: controller.obscureTextConfirmPassword.value
          ? visibilityOffIc
          : visibilityIc,
      onTapSuffixIcon: () => controller.obscureTextConfirmPassword.value =
          !controller.obscureTextConfirmPassword.value,
      label: LocaleKeys.texts_confirm_password.tr,
      hintText: '********',
    );
  }

  TextFieldWidget _buildPassword() {
    return TextFieldWidget(
      controller: controller.passwordController,
      errorText: controller.passwordValidate.value,
      textCapitalization: TextCapitalization.none,
      obscureText: controller.obscureTextPassword.value,
      suffixIcon:
          controller.obscureTextPassword.value ? visibilityOffIc : visibilityIc,
      onTapSuffixIcon: () => controller.obscureTextPassword.value =
          !controller.obscureTextPassword.value,
      maxLines: 1,
      hintText: '********',
      label: LocaleKeys.texts_password.tr,
    );
  }

  Widget _buildTitle() {
    return Container(
      margin: const EdgeInsets.only(top: AppSize.kSpacing12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              LocaleKeys.register_create_an_acc.tr,
              style: AppStyles.heading36.copyWith(
                height: 1.28,
                color: AppColors.kDark6,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
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
}
