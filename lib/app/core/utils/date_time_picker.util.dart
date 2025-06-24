import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_getx_base/app/core/theme/app_colors.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class DateTimeHelper {
  static String calculateDurationValidate(DateTime validateDate) {
    final timeSpan = validateDate.difference(DateTime.now());
    final num totalMin = timeSpan.inMinutes;

    // 1 day = 1440 min
    int days = totalMin ~/ 1440;
    double remainingMinInDay = ((totalMin / 1440) - days) * 1440;
    int hours = remainingMinInDay ~/ 60;
    double remainingMinInHour = (remainingMinInDay / 60) - hours;
    int min = (remainingMinInHour * 60).round();
    return '$days Days ${hours}h ${min}m';
  }

  static String translateDateTime({required DateTime dateTime}) {
    String stringFormat = "dd/MM/yyyy";
    return DateFormat(stringFormat).format(dateTime.toLocal());
  }

  static String dayFormat(dynamic dateInput) {
    try {
      return DateFormat('dd/MM/yyyy').format(dateInput);
    } catch (e) {
      return "";
    }
  }

  static String timeFormat(dynamic dateInput) {
    try {
      return DateFormat('HH:mm').format(dateInput);
    } catch (e) {
      return "--:--";
    }
  }

  static String translateMonthDateTime(
      {required DateTime dateTime, required String langCode}) {
    String stringFormat = "MM/yyyy";
    return DateFormat(stringFormat, langCode).format(dateTime.toLocal());
  }

  static String dateTimeFormat(
      {required DateTime dateTime, required String languageCode}) {
    String stringFormat = "dd/MM/yyyy hh:mm a";
    return DateFormat(stringFormat).format(dateTime.toLocal());
  }

static DateTime getDateNow(DateTime? dateTime) {
    dateTime ??= DateTime.now();
    final DateTime data = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      0,
      1,
      0,
      0,
      0,
    );
    return data;
  }

  static DateTime cleanStartDateTimeRequest(DateTime? dateTime) {
    dateTime ??= DateTime.now();
    final DateTime data = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      0,
      1,
      0,
      0,
      0,
    );
    return data.toUtc();
  }

  static DateTime cleanEndDateTimeRequest(DateTime? dateTime) {
    dateTime ??= DateTime.now();
    final DateTime data = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      23,
      59,
      59,
      0,
      0,
    );
    return data.toUtc();
  }

  static String dateTimeFormatWithoutYearly(
      {required DateTime dateTime, required String languageCode}) {
    String stringFormat = "dd/MM hh:mm a";
    return DateFormat(stringFormat).format(dateTime.toLocal());
  }

  static bool isBefore(
      {required DateTime firstDate, required DateTime secondDate}) {
    return firstDate.isBefore(secondDate);
  }

  static bool isDateBefore(
      {required DateTime firstDate, required DateTime secondDate}) {
    var d1 = DateTime.utc(firstDate.year, firstDate.month, firstDate.day);
    var d2 = DateTime.utc(secondDate.year, secondDate.month, secondDate.day);
    return d1.isBefore(d2);
  }

  static Future<DateTime?> showDayPicker(
    BuildContext context,
    DateTime initDate, {
    int? interval,
    DateTime? firstDate,
    DateTime? lastDate,
  }) {
    final now = DateTime.now();

    firstDate ??= DateTime(now.year - 100, now.month, now.day, now.hour - 1);
    lastDate ??= DateTime(now.year + 100, now.month, now.day);

    if (interval != null) {
      firstDate = DateTime(now.year, now.month, now.day - interval);
      lastDate = DateTime(now.year, now.month, DateTime.now().day + interval);
    }

    return showRoundedDatePicker(
      context: context,
      initialDate: initDate,
      firstDate: firstDate,
      lastDate: lastDate,
      height: Get.height * 0.4,
      borderRadius: 16,
      locale: Get.locale ?? const Locale('vi', 'VN'),
      theme: ThemeData(
        primaryColor: AppColors.kBgColor,
        dialogBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch(accentColor: AppColors.kPrimary),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
        ),
        disabledColor: Colors.grey,
      ),
    );
  }

  static Future<DateTime?> showDatePicker(
    BuildContext context,
    DateTime initDate, {
    int? interval,
    DateTime? firstDate,
    DateTime? lastDate,
  }) {
    final now = DateTime.now();

    firstDate ??= DateTime(now.year, now.month, now.day - 8, now.hour - 1);
    lastDate ??= DateTime(now.year + 10, now.month, now.day);
    if (interval != null) {
      firstDate = DateTime(now.year, now.month, now.day - interval);
      lastDate = DateTime(now.year, now.month, DateTime.now().day + interval);
    }

    return showRoundedDatePicker(
      context: context,
      initialDate: initDate,
      firstDate: firstDate,
      lastDate: lastDate,
      height: Get.height * 0.4,
      borderRadius: 16,
      locale: Get.locale ?? const Locale('vi', 'VN'),
      theme: ThemeData(
        primaryColor: AppColors.kBgColor,
        dialogBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch(accentColor: AppColors.kPrimary),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
        ),
        disabledColor: Colors.grey,
      ),
    );
  }

  static Future<TimeOfDay?> showTimePickerDialog(
      BuildContext context, DateTime? initTime,
      {int? interval}) {
    initTime ??= DateTime.now();
    return showTimePicker(
      initialTime: TimeOfDay(hour: initTime.hour, minute: initTime.minute),
      context: context,
    );
  }

  static String calculateTimeAgo(DateTime postDate) {
    return timeAgo.format(postDate, locale: Get.locale!.languageCode);
  }
}

class CustomViMessages implements timeAgo.LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'trước';
  @override
  String suffixFromNow() => 'nữa';
  @override
  String lessThanOneMinute(int seconds) => '1 phút';
  @override
  String aboutAMinute(int minutes) => 'khoảng 1 phút';
  @override
  String minutes(int minutes) => '$minutes phút';
  @override
  String aboutAnHour(int minutes) => 'khoảng 1 tiếng';
  @override
  String hours(int hours) => '$hours tiếng';
  @override
  String aDay(int hours) => '1 ngày';
  @override
  String days(int days) => '$days ngày';
  @override
  String aboutAMonth(int days) => 'khoảng 1 tháng';
  @override
  String months(int months) => '$months tháng';
  @override
  String aboutAYear(int year) => 'khoảng 1 năm';
  @override
  String years(int years) => '$years năm';
  @override
  String wordSeparator() => ' ';
}
