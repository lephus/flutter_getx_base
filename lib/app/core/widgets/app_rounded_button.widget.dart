import 'dart:io';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter/cupertino.dart';
import 'package:flutter_getx_base/app/core/theme/app_colors.dart';
import 'package:flutter_getx_base/app/core/theme/app_size.dart';

class AppRoundedButton extends StatelessWidget {
  final VoidCallback? onPressed;

  final double? width;
  final double? height;
  final double? borderRadius;
  final double? elevation;

  final Color? backgroundColor;
  final Color? disableBackgroundColor;
  final Color? shadowColor;

  final bool isLoading;
  final bool isDisable;
  final bool isFullSize;

  final Widget? child;
  final EdgeInsetsGeometry margin;
  final BorderSide borderSide;
  final ShapeBorder? shape;

  const AppRoundedButton({
    super.key,
    required this.onPressed,
    this.width,
    this.height,
    this.borderRadius,
    this.elevation = 1.8,
    this.backgroundColor,
    this.disableBackgroundColor,
    this.shadowColor,
    this.isDisable = false,
    this.isLoading = false,
    this.isFullSize = true,
    this.child,
    this.borderSide = BorderSide.none,
    this.margin = EdgeInsets.zero,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 42,
      width: isFullSize ? double.infinity : null,
      margin: margin,
      child: MaterialButton(
        shape: shape ??
            RoundedRectangleBorder(
              side: borderSide,
              borderRadius: BorderRadius.circular(
                borderRadius ?? AppSize.kRadius12,
              ),
            ),
        elevation: elevation,
        color: backgroundColor ?? AppColors.kPrimary,
        onPressed: isDisable || isLoading ? null : onPressed,
        disabledColor: disableBackgroundColor ?? AppColors.kDark4,
        child: _buildChild(),
      ),
    );
  }

  Widget? _buildChild() {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: Platform.isIOS
            ? const CupertinoActivityIndicator(color: AppColors.kTextButtonConfirm)
            : const CircularProgressIndicator(
                strokeWidth: 1.8,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.kTextButtonConfirm),
              ),
      );
    }
    return child;
  }
}
