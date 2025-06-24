import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_getx_base/app/core/theme/app_colors.dart';
import 'package:flutter_getx_base/app/modules/base/controllers/base.controller.dart';
import 'package:get/get.dart';

class BottomNavigationBarWidget extends GetView<BaseController> {
  final BaseController controller = BaseController.to;
  BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
          enableFeedback: false,
          currentIndex: BaseController.selectedIndex.value,
          selectedItemColor: AppColors.kPrimary,
          backgroundColor: AppColors.kDark1,
          elevation: 1,
          unselectedFontSize: 8,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: AppColors.kDark4,
          unselectedIconTheme: const IconThemeData(
            color: AppColors.kDark5,
          ),
          selectedFontSize: 12,
          onTap: (index) {
            if( BaseController.selectedIndex.value == index) return;
            BaseController.selectedIndex.value = index;
            controller.appRouter();
          },
          items: barItem),
    );
  }

  List<BottomNavigationBarItem> get barItem => [
        const BottomNavigationBarItem(
          icon: const Icon(
            CupertinoIcons.house_fill,
            size: 22,
          ),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.app,
            color: Colors.transparent,
          ),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: const Icon(Icons.calendar_month_sharp),
          label: 'Booking',
        ),
      ];
}
