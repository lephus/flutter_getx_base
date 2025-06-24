import 'package:flutter/widgets.dart';
import 'package:flutter_getx_base/app/core/theme/app_colors.dart';
import 'package:flutter_getx_base/app/core/theme/text_styles.dart';
import 'package:flutter_getx_base/generated/locales.g.dart';
import 'package:get/get.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.texts_not_found.tr,
            style: AppStyles.body14.copyWith(
              color: AppColors.kDark5,
            ),
          ),
        ],
      ),
    );
  }
}
