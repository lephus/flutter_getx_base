import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NumberInputFormatter extends TextInputFormatter {
  final NumberFormat numberFormat;

  NumberInputFormatter({required this.numberFormat});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.text == ''){
      return const TextEditingValue(text: '');
    }
    // Xóa hết các ký tự không phải số
    String newText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // Định dạng số
    String formattedText = numberFormat.format(int.parse(newText.isEmpty ? '0' : newText));

    // Cập nhật vị trí con trỏ
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
