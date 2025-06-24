import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_getx_base/app/core/theme/app_colors.dart';
import 'package:flutter_getx_base/app/core/theme/app_size.dart';

class BackIconWidget extends StatelessWidget {
  final VoidCallback? onTapBack;
  final Color backgroundColor;
  final Color iconColor;
  final EdgeInsets? margin;

  const BackIconWidget(
      {super.key,
      this.onTapBack,
      this.margin,
      this.backgroundColor = AppColors.kDark3,
      this.iconColor = AppColors.kBgColor});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: onTapBack,
        child: Container(
          height: 32,
          width: 32,
          margin: margin ?? const EdgeInsets.all(AppSize.kHorizontalSpace),
          decoration: BoxDecoration(
              color: backgroundColor, borderRadius: BorderRadius.circular(4)),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
