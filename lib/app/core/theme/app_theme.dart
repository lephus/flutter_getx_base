import 'package:flutter/material.dart' hide CarouselController;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_getx_base/app/core/theme/app_colors.dart';

class AppThemeData {
  AppThemeData._();
  static ThemeData lightThemeData = themeData(brightness: Brightness.light);
  static ThemeData darkThemeData = themeData(brightness: Brightness.dark);

  static ThemeData themeData({required Brightness brightness}) {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.kBgColor,
      primaryColor: AppColors.kPrimary,
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.kPrimary,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.kBgColor,
        modalBackgroundColor: AppColors.kBgColor,
      ),
      colorScheme: const ColorScheme.light(
        primary: AppColors.kPrimary,
      ).copyWith(background: AppColors.kBgColor),
    );
  }
}
