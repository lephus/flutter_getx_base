import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_getx_base/app/core/theme/app_colors.dart';

Widget appDivider({EdgeInsets? margin}) => Container(
      margin: margin,
      child: const Divider(
        color: AppColors.kDark1,
        height: 0.5,
      ),
    );
