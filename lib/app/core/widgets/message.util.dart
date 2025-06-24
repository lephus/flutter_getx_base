import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_getx_base/app/core/theme/app_colors.dart';
import 'package:flutter_getx_base/app/core/theme/text_styles.dart';
import 'package:flutter_getx_base/generated/locales.g.dart';
import 'package:get/get.dart';

class MessageDialog {
  static void showDialog(
    Widget child,
    BorderRadius? borderRadius,
  ) {
    Get.generalDialog(
      barrierDismissible: false,
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.3),
      transitionDuration: const Duration(milliseconds: 0),
      pageBuilder: (context, _, __) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ??
                const BorderRadius.all(
                  Radius.circular(5.0),
                ),
          ),
          content: Container(
            constraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 30,
            ),
            child: child,
          ),
          contentPadding:
              const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
        );
      },
    );
  }

  static void showFinalizingPleaseWait() {
    Get.generalDialog(
      barrierDismissible: false,
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.3),
      transitionDuration: const Duration(milliseconds: 0),
      pageBuilder: (context, _, __) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          content: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 30,
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              const CupertinoActivityIndicator(
                color: AppColors.kBlue4,
                radius: 14,
              ),
              const SizedBox(width: 16),
              Text(
                LocaleKeys.texts_please_wait.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: AppColors.kDark6),
              ),
            ]),
          ),
          contentPadding: const EdgeInsets.only(
            top: 8,
            left: 16,
            right: 16,
            bottom: 8,
          ),
        );
      },
    );
  }

  static void hideLoading() {
    Get.back();
  }

  static void showMessageConfirm(String message,
      {String? title,
      TextStyle? contentTextStyle,
      String? confirmButtonText,
      Function? onConfirm,
      Color textColor = AppColors.kDark6}) {
    _showDialog(
      content: message,
      title: title,
      textColor: textColor,
      contentTextStyle: contentTextStyle,
      onConfirmed: onConfirm,
      isConfirmDialog: true,
      confirmButtonText: confirmButtonText,
    );
  }

  static void showMessage(String message,
      {String? title,
      TextStyle? contentTextStyle,
      Function? onClosed,
      Color textColor = AppColors.kDark6}) {
    _showDialog(
      content: message,
      cancelButtonText: LocaleKeys.texts_ok.tr,
      title: title ?? '',
      textColor: textColor,
      contentTextStyle: contentTextStyle ??
          TextStyle(
            color: textColor,
            fontSize: 16,
          ),
      onClosed: onClosed ??
          () {
            Get.back();
          },
      isConfirmDialog: false,
    );
  }

  static void showError(
      {String? message,
      String? title,
      String? cancelButtonText,
      TextStyle? contentTextStyle,
      Function? onClosed}) {
    _showDialog(
      content: message ?? LocaleKeys.message_default_error.tr,
      title: '',
      textColor: Colors.red[600],
      cancelButtonText: cancelButtonText ?? '',
      contentTextStyle: contentTextStyle,
      onClosed: onClosed,
      isConfirmDialog: false,
    );
  }

  static void showCustomDialog({
    String? message,
    String? title,
    String? cancelButtonText,
    String? confirmButtonText,
    TextStyle? contentTextStyle,
    Function? onClosed,
    Function? onConfirm,
  }) {
    _showDialog(
      content: message ?? LocaleKeys.message_default_error.tr,
      title: '',
      textColor: Colors.red[600],
      cancelButtonText: cancelButtonText ?? LocaleKeys.texts_cancel.tr,
      confirmButtonText: confirmButtonText ?? LocaleKeys.texts_ok.tr,
      contentTextStyle: contentTextStyle,
      onClosed: onClosed,
      onConfirmed: onConfirm,
      isConfirmDialog: true,
    );
  }

  static void _showDialog(
      {String? title,
      String? content,
      String? confirmButtonText,
      String? cancelButtonText,
      TextStyle? contentTextStyle,
      Function? onConfirmed,
      Function? onClosed,
      Color? textColor,
      BorderRadius? borderRadius,
      bool isConfirmDialog = false}) {
    Get.generalDialog(
      barrierDismissible: false,
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.3),
      transitionDuration: const Duration(milliseconds: 0),
      pageBuilder: (context, _, __) {
        return AlertDialog(
          title: title != null
              ? Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                )
              : const SizedBox(height: 0),
          backgroundColor: Colors.white.withOpacity(0.85),
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ??
                const BorderRadius.all(
                  Radius.circular(12.0),
                ),
          ),
          content: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 120,
              minHeight: 30,
            ),
            child: Text(
              content ?? '',
              textAlign: TextAlign.center,
              style: contentTextStyle ??
                  AppStyles.body16.copyWith(color: AppColors.kDark6),
            ),
          ),
          contentPadding:
              const EdgeInsets.only(top: 8, left: 20, right: 20, bottom: 8),
          actionsPadding: const EdgeInsets.all(0),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildActionButton(
                    onTap: () async {
                      if (onClosed == null) {
                        Get.back();
                      } else {
                        await onClosed();
                      }
                    },
                    textButton: cancelButtonText ?? LocaleKeys.texts_cancel.tr,
                    buttonColor: AppColors.kDark6,
                    borderRadius: BorderRadius.only(
                      bottomLeft: radiusCircular12,
                      bottomRight: isConfirmDialog
                          ? radiusCircularZero
                          : radiusCircular12,
                    ),
                  ),
                ),
                if (isConfirmDialog)
                  Expanded(
                    child: _buildActionButton(
                      onTap: () async {
                        if (onConfirmed == null) {
                          Get.back();
                        } else {
                          await onConfirmed();
                        }
                      },
                      textButton: confirmButtonText ?? LocaleKeys.texts_ok.tr,
                      buttonColor: AppColors.kBlue5,
                      borderRadius: BorderRadius.only(
                        bottomRight: radiusCircular12,
                        bottomLeft: isConfirmDialog
                            ? radiusCircularZero
                            : radiusCircular12,
                      ),
                    ),
                  ),
              ],
            )
          ],
        );
      },
    );
  }

  static Widget _buildActionButton({
    required VoidCallback onTap,
    required String textButton,
    required Color buttonColor,
    required BorderRadius borderRadius,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.kDark2),
          borderRadius: borderRadius,
        ),
        child: Text(textButton,
            style: AppStyles.button18.copyWith(
              color: buttonColor,
              fontSize: 16,
            )),
      ),
    );
  }
}

showSnackBarSuccess({String? message}) {
  Get.snackbar(
    '',
    message ?? LocaleKeys.message_default_success.tr,
    backgroundColor: Colors.green,
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(seconds: 3),
    padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
    titleText: const SizedBox.shrink(),
    messageText: Text(
      message ?? LocaleKeys.message_default_success.tr,
      style: AppStyles.body18.copyWith(
        height: 1,
        color: Colors.white,
      ),
    ),
    snackStyle: SnackStyle.FLOATING,
    isDismissible: true,
    borderRadius: 8,
    forwardAnimationCurve: Curves.easeOutBack,
    colorText: Colors.white,
  );
}

showSnackBarError({String? message}) {
  Get.snackbar(
    '',
    message ?? LocaleKeys.message_default_error.tr,
    backgroundColor: Colors.red,
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(seconds: 3),
    padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
    titleText: const SizedBox.shrink(),
    messageText: Text(
      message ?? LocaleKeys.message_default_error.tr,
      style: AppStyles.body18.copyWith(
        height: 1,
        color: Colors.white,
      ),
    ),
    snackStyle: SnackStyle.FLOATING,
    isDismissible: true,
    borderRadius: 8,
    forwardAnimationCurve: Curves.ease,
    colorText: Colors.white,
  );
}

showSnackBarInfo({String? message}) {
  Get.snackbar(
    '',
    message ?? LocaleKeys.message_documents_uploaded.tr,
    backgroundColor: Colors.cyan,
    snackPosition: SnackPosition.TOP,
    duration: const Duration(seconds: 2),
    padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
    titleText: const SizedBox.shrink(),
    messageText: Text(
      message ?? LocaleKeys.message_documents_uploaded.tr,
      style: AppStyles.body18.copyWith(
        height: 1,
        color: Colors.white,
      ),
    ),
    snackStyle: SnackStyle.FLOATING,
    isDismissible: true,
    borderRadius: 8,
    forwardAnimationCurve: Curves.ease,
    colorText: Colors.white,
  );
}

showSnackBarWarning({String? message}) {
  Get.snackbar(
    '',
    message ?? LocaleKeys.message_documents_uploaded.tr,
    backgroundColor: Colors.amber,
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(seconds: 3),
    padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
    titleText: const SizedBox.shrink(),
    messageText: Text(
      message ?? LocaleKeys.message_documents_uploaded.tr,
      style: AppStyles.body18.copyWith(
        height: 1,
        color: Colors.white,
      ),
    ),
    snackStyle: SnackStyle.FLOATING,
    isDismissible: true,
    borderRadius: 8,
    forwardAnimationCurve: Curves.ease,
    colorText: Colors.white,
  );
}

showSnackBarErrorInCatch(String exception) {
  Get.snackbar(
    '',
    exception,
    backgroundColor: Colors.red,
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(seconds: 3),
    padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
    titleText: const SizedBox.shrink(),
    messageText: Text(
      exception,
      style: AppStyles.body18.copyWith(
        height: 1,
        color: Colors.white,
      ),
    ),
    snackStyle: SnackStyle.FLOATING,
    isDismissible: true,
    borderRadius: 8,
    forwardAnimationCurve: Curves.ease,
    colorText: Colors.white,
  );
}

get radiusCircular12 => const Radius.circular(12);
get radiusCircularZero => const Radius.circular(0);
