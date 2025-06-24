import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_getx_base/app/core/theme/app_size.dart';
import 'package:flutter_getx_base/app/core/theme/text_styles.dart';
import 'package:flutter_getx_base/app/core/widgets/app_rounded_button.widget.dart';
import 'package:flutter_getx_base/app/core/widgets/app_text_form_field.widget.dart';
import 'package:flutter_getx_base/generated/locales.g.dart';
import 'package:get/get.dart';

class GetOTPForgotPasswordWidget extends StatefulWidget {
  final TextEditingController emailReceiveOtpCoController;
  final VoidCallback onSubmit;
  final bool isLoading;
  const GetOTPForgotPasswordWidget({
    super.key,
    required this.emailReceiveOtpCoController,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<GetOTPForgotPasswordWidget> createState() =>
      _GetOTPForgotPasswordWidgetState();
}

class _GetOTPForgotPasswordWidgetState
    extends State<GetOTPForgotPasswordWidget> {
  bool isEmailError = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppSize.kHorizontalSpace),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(AppSize.kSpacing20),
          child: Text(
            LocaleKeys.login_title_get_otp.tr,
            style: AppStyles.body18,
            textAlign: TextAlign.center,
          ),
        ),
        _buildEmail(),
        _buildSubmit(),
      ]),
    );
  }

  TextFieldWidget _buildEmail() {
    return TextFieldWidget(
      controller: widget.emailReceiveOtpCoController,
      errorText: isEmailError ? LocaleKeys.login_email_incorrect.tr : '',
      label: LocaleKeys.texts_email_address.tr,
      hintText: LocaleKeys.texts_email_address.tr,
      onChanged: (value) {
        setState(() {
          if (widget.emailReceiveOtpCoController.text.isEmail) {
            isEmailError = false;
          } else {
            isEmailError = true;
          }
        });
      },
    );
  }

  Widget _buildSubmit() {
    return AppRoundedButton(
      margin: const EdgeInsets.only(top: AppSize.kSpacing12),
      onPressed: () {
        isEmailError = false;
        if (widget.emailReceiveOtpCoController.text.isEmpty ||
            !widget.emailReceiveOtpCoController.text.isEmail) {
          isEmailError = true;
          return;
        }
        widget.onSubmit();
      },
      isLoading: widget.isLoading,
      child: Text(
        LocaleKeys.button_confirm.tr,
        style: AppStyles.button18,
      ),
    );
  }
}
