import 'package:flutter_getx_base/app/core/settings/endpoints.dart';

bool isURL(String value) {
  value = value.toLowerCase().trim();
  const urlPattern =
      r'^(https?:\/\/)?((([a-zA-Z0-9\-]+\.)+[a-zA-Z]{2,})|localhost|(\d{1,3}\.){3}\d{1,3})(:\d+)?(\/.*)?$';
  final result = RegExp(urlPattern).hasMatch(value);
  return result;
}

bool isPhoneNumber(String value) {
  value = value.toLowerCase().trim();
  const phonePattern = r'^\+?[\d\s\-\(\)]+$';
  final result = RegExp(phonePattern).hasMatch(value);
  return result;
}

bool isSSmartData(String value) {
  try {
    return value.toString().contains(Endpoints.masterHost);
  } catch (_) {
    return false;
  }
}
