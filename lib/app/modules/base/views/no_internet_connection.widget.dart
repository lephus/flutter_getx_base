import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_getx_base/app/core/theme/app_colors.dart';
import 'package:flutter_getx_base/app/core/theme/text_styles.dart';
import 'package:flutter_getx_base/generated/locales.g.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

class NoInternetConnectionWidget extends StatelessWidget {
  const NoInternetConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBgColor,
      body: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppColors.kBgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Oh no!',
              style: AppStyles.heading24.copyWith(
                color: AppColors.kPrimary,
              ),
            ),
            Text(
              LocaleKeys.texts_no_internet_connection.tr,
              style: AppStyles.body18,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
