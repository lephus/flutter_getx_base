import 'dart:convert';
import 'dart:math';

import 'package:flutter_getx_base/generated/locales.g.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StringUtil {
  // VALIDATION RECORD NAME
  static String modifyStringToSatisfyConditions(String input) {
    final List<String> allowedChars =
        List.generate(94, (i) => String.fromCharCode(i + 32))
            .where((char) => !['.', '\$', '#', '[', ']', '/'].contains(char))
            .toList();

    String modifiedString =
        input.replaceAllMapped(RegExp(r'[\x00-\x1F\x7F.]'), (match) {
      return allowedChars[match.group(0)!.codeUnitAt(0) - 32];
    });
    final utf8Bytes = const Utf8Encoder().convert(modifiedString);
    if (utf8Bytes.length > 768) {
      final truncatedLength =
          (768 * (utf8Bytes.length / modifiedString.length)).floor();
      modifiedString = modifiedString.substring(0, truncatedLength);
    }

    return modifiedString;
  }

  static String jsonToQueryParams(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return '';
    }
    List<String> queryParamsList = [];
    json.forEach((key, value) {
      if (value != null && value != '') {
        queryParamsList.add(
            '${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(value.toString())}');
      }
    });

    return queryParamsList.join('&');
  }

  static String stringNumberFormatInt(String number) {
    try {
      String newText = number.replaceAll(RegExp(r'[^\d]'), '');
      final f = NumberFormat("#,##0", "vi_VN");
      return f.format(int.parse(newText));
    } catch (_) {
      return '0';
    }
  }

  static int stringToNumber(String number) {
    try {
      String newText = number.replaceAll(RegExp(r'[^\d]'), '');
      return int.parse(newText);
    } catch (_) {
      return 0;
    }
  }

  static String generateRandomString(int length) {
    const characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
      length,
      (_) => characters.codeUnitAt(random.nextInt(characters.length)),
    ));
  }

  static int dayOfWeekToNumber(String value) {
    value = value.toLowerCase();
    switch (value) {
      case 'mon':
        return 1;
      case 'tue':
        return 2;
      case 'wed':
        return 3;
      case 'thu':
        return 4;
      case 'fri':
        return 5;
      case 'sat':
        return 6;
      case 'sun':
        return 7;
      default:
        return 7;
    }
  }
}
