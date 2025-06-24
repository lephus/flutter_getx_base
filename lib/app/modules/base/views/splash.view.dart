import 'package:get/get.dart';
import 'package:flutter/material.dart' hide CarouselController;
//
import 'package:flutter_getx_base/app/core/theme/app_colors.dart';
import 'package:flutter_getx_base/app/core/widgets/image_view.widget.dart';
import 'package:flutter_getx_base/app/modules/base/controllers/splash.controller.dart';
import 'package:flutter_getx_base/gen/assets.gen.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      body: Obx(() => controller.isLoading.isTrue
          ? logoWaitingWidget()
          : logoWaitingWidget()),
    );
  }

  Center logoWaitingWidget() {
    return Center(
      child: ImageViewWidget(
        Assets.icons.launcher.logoNoBg.path,
        width: 128,
        height: 128,
        fit: BoxFit.cover,
        borderRadius: BorderRadius.circular(128),
      ),
    );
  }
}
