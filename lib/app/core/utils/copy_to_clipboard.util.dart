import 'package:flutter/services.dart';
import 'package:flutter_getx_base/app/core/widgets/message.util.dart';
import 'package:flutter_getx_base/generated/locales.g.dart';
import 'package:get/get.dart';

void copyToClipboard(String text) {
  Clipboard.setData(ClipboardData(text: text));
  showSnackBarSuccess(
      message: "${LocaleKeys.texts_copy_to_clipboard.tr} $text");
}
