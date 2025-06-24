import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_getx_base/app/core/utils/size_config.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppStyles {
  AppStyles._();
  static const _medium = FontWeight.w400;
  static const _regular = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  // ===== Heading =====
  static TextStyle heading36 = GoogleFonts.inter(
    fontWeight: _bold,
    fontSize: getFontSizeRadio(36.0),
    height: getFontHeightRadio(36),
  );

  static TextStyle heading32 = GoogleFonts.inter(
    fontWeight: _bold,
    fontSize: getFontSizeRadio(32.0),
    height: getFontHeightRadio(32),
  );

  static TextStyle heading24 = GoogleFonts.inter(
    fontWeight: _bold,
    fontSize: getFontSizeRadio(24.0),
    height: getFontHeightRadio(24),
  );

  static TextStyle heading20 = GoogleFonts.inter(
    fontWeight: _bold,
    fontSize: getFontSizeRadio(20.0),
    height: getFontHeightRadio(20),
  );

  // ======= Sub Heading =======
  static TextStyle subHeading24 = GoogleFonts.inter(
    fontWeight: _semiBold,
    fontSize: getFontSizeRadio(24.0),
    height: getFontHeightRadio(24),
  );

  static TextStyle subHeading20 = GoogleFonts.inter(
    fontWeight: _semiBold,
    fontSize: getFontSizeRadio(20.0),
    height: getFontHeightRadio(20),
  );

  static TextStyle subHeading18 = GoogleFonts.inter(
    fontWeight: _semiBold,
    fontSize: getFontSizeRadio(18.0),
    height: getFontHeightRadio(18),
  );

  // ======= Body =======
  static TextStyle body18 = GoogleFonts.inter(
    fontWeight: _medium,
    fontSize: getFontSizeRadio(18.0),
    height: getFontHeightRadio(18),
  );

  static TextStyle body16 = GoogleFonts.inter(
    fontWeight: _medium,
    fontSize: getFontSizeRadio(16.0),
    height: getFontHeightRadio(16),
  );

  static TextStyle body14 = GoogleFonts.inter(
    fontWeight: _medium,
    fontSize: getFontSizeRadio(14.0),
    height: getFontHeightRadio(14),
  );

  static TextStyle body12 = GoogleFonts.inter(
    fontWeight: _medium,
    fontSize: getFontSizeRadio(12.0),
    height: getFontHeightRadio(12),
  );

  static TextStyle body10 = GoogleFonts.inter(
    fontWeight: _medium,
    fontSize: getFontSizeRadio(10),
    height: getFontHeightRadio(10),
  );

  static TextStyle body8 = GoogleFonts.inter(
    fontWeight: _medium,
    fontSize: getFontSizeRadio(8),
    height: getFontHeightRadio(8),
  );

  // ======= Overline =======
  static TextStyle overline16 = GoogleFonts.inter(
    fontWeight: _bold,
    fontSize: getFontSizeRadio(16.0),
    height: getFontHeightRadio(16),
  );

  static TextStyle overline14 = GoogleFonts.inter(
    fontWeight: _bold,
    fontSize: getFontSizeRadio(14.0),
    height: getFontHeightRadio(14),
  );

  // ======= Caption =======
  static TextStyle caption16 = GoogleFonts.inter(
    fontWeight: _regular,
    fontSize: getFontSizeRadio(16.0),
    height: getFontHeightRadio(16),
  );

  static TextStyle caption14 = GoogleFonts.inter(
    fontWeight: _regular,
    fontSize: getFontSizeRadio(14.0),
    height: getFontHeightRadio(14),
  );

  static TextStyle caption12 = GoogleFonts.inter(
    fontWeight: _regular,
    fontSize: getFontSizeRadio(12.0),
    height: getFontHeightRadio(12),
  );

  static TextStyle caption10 = GoogleFonts.inter(
    fontWeight: _regular,
    fontSize: getFontSizeRadio(10.0),
    height: getFontHeightRadio(10),
  );

  // ======= Button =======
  static TextStyle button18 = GoogleFonts.inter(
    fontWeight: _semiBold,
    fontSize: getFontSizeRadio(18.0),
    height: getFontHeightRadio(18),
  );

  static TextStyle button16 = GoogleFonts.inter(
    fontWeight: _semiBold,
    fontSize: getFontSizeRadio(16.0),
    height: getFontHeightRadio(16),
  );

  static TextStyle button14 = GoogleFonts.inter(
    fontWeight: _semiBold,
    fontSize: getFontSizeRadio(14.0),
    height: getFontHeightRadio(14),
  );

  static TextStyle button12 = GoogleFonts.inter(
    fontWeight: _semiBold,
    fontSize: getFontSizeRadio(12.0),
    height: getFontHeightRadio(12),
  );

  // ======================
  static double getFontSizeRadio(double baseValue) {
    if (SizeConfig.isMobile) {
      return baseValue;
    }
    return baseValue + 2;
  }

  static double getFontHeightRadio(double baseValue) {
    if (SizeConfig.isMobile) {
      return (baseValue + 4) / baseValue;
    }
    return (baseValue + 6) / (baseValue + 2);
  }
}
