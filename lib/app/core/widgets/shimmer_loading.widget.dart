import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_getx_base/app/core/theme/app_colors.dart';

class ShimmerLoading extends StatefulWidget {
  final double width;
  final double height;
  final EdgeInsets? margin;
  final Color color;
  final int duration;
  final BorderRadius? borderRadius;

  const ShimmerLoading({
    super.key,
    required this.width,
    required this.height,
    this.margin,
    this.borderRadius,
    this.color = const Color(0xFFE8E8E8),
    this.duration = 500,
  });

  @override
  ShimmerLoadingState createState() => ShimmerLoadingState();
}

class ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.25, end: 1.0).animate(_controller!);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller!,
      builder: (context, child) {
        return Opacity(
          opacity: _animation!.value,
          child: Container(
            margin: widget.margin,
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(4),
              color: widget.color,
            ),
          ),
        );
      },
    );
  }
}

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({
    super.key,
    this.color = AppColors.kPrimary,
  });
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isIOS
          ? CupertinoActivityIndicator(
              color: color,
              radius: 12,
            )
          : CircularProgressIndicator(
              strokeWidth: 1.5,
              color: color,
            ),
    );
  }
}
