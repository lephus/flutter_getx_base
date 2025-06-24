import 'dart:math';

import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_getx_base/app/core/theme/app_colors.dart';
import 'package:flutter_getx_base/app/core/theme/app_size.dart';
import 'package:flutter_getx_base/app/core/theme/text_styles.dart';
import 'package:flutter_getx_base/app/core/utils/size_config.dart';
import 'package:flutter_getx_base/generated/locales.g.dart';
import 'package:get/get.dart';

void showCommonBottomSheet(
  BuildContext context, {
  required Widget child,
  Widget? trailing,
  double? radius,
  double? maxHeight,
  Color? backgroundColor,
  VoidCallback? whenComplete,
  VoidCallback? onTapDone,
  bool? isShowDoneButton,
  bool? isDismissible,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useRootNavigator: false,
    isDismissible: isDismissible ?? true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(radius ?? AppSize.kRadius16),
        topLeft: Radius.circular(radius ?? AppSize.kRadius16),
      ),
    ),
    constraints: BoxConstraints(
      minHeight: MediaQuery.of(context).size.height * 0.2,
      maxHeight: maxHeight ?? MediaQuery.of(context).size.height * 0.92,
    ),
    backgroundColor: backgroundColor ?? AppColors.kBgColor,
    builder: (builder) {
      return Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.kBgColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(radius ?? AppSize.kRadius16),
            topLeft: Radius.circular(radius ?? AppSize.kRadius16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeaderNotch(
                isShowDoneButton: isShowDoneButton ?? true,
                onTapDone: onTapDone),
            trailing ?? const SizedBox(),
            Expanded(
              child: Container(
                color: backgroundColor ?? AppColors.kBgColor,
                child: child,
              ),
            )
          ],
        ),
      );
    },
  ).whenComplete(() {
    debugPrint('Close Modal Bottom Sheet');
    if (whenComplete != null) {
      whenComplete();
    }
  });
}

Widget _buildHeaderNotch(
    {required bool isShowDoneButton, required VoidCallback? onTapDone}) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        width: min(120, SizeConfig.screenWidth / 6),
        height: 6,
        margin: const EdgeInsets.symmetric(
          vertical: AppSize.kSpacing12,
        ),
        decoration: BoxDecoration(
          color: AppColors.kDark3,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      isShowDoneButton
          ? Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(right: 6),
                child: TextButton(
                  onPressed: () {
                    if (onTapDone != null) {
                      onTapDone();
                    }
                    Get.back();
                  },
                  child: Text(
                    LocaleKeys.button_done.tr,
                    style: AppStyles.button18.copyWith(
                      color: AppColors.kPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox(),
    ],
  );
}
