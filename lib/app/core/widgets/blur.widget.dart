import 'dart:ui';

import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_getx_base/app/core/theme/app_colors.dart';

class BlurWidget extends StatelessWidget {
  final Color blurColor;
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
  final double withOpacity;
  const BlurWidget({
    super.key,
    required this.child,
    this.blurColor = AppColors.kBlurColor,
    this.withOpacity = 0.2,
    this.borderRadius,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
        child: Container(
          margin: margin,
          padding: padding ?? const EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(8),
            color: blurColor.withOpacity(withOpacity),
          ),
          child: child,
        ),
      ),
    );
  }
}
