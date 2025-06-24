import 'package:flutter/material.dart';
import 'package:flutter_getx_base/app/core/theme/app_colors.dart';

abstract class ListItem<T, X> {
  ListItem(this.key, this.value,
      {this.backgroundColor = AppColors.kDark1,
      this.textColor = AppColors.kDark7});
  final T key;
  final X value;
  final Color backgroundColor;
  final Color textColor;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is ListItem && other.value == value);

  @override
  int get hashCode => key.hashCode;
}

class BaseItem implements ListItem<int, String> {
  @override
  final int key;
  @override
  final String value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is ListItem && other.value == value);

  @override
  int get hashCode => key.hashCode;

  BaseItem(this.key, this.value);

  @override
  Color get backgroundColor => Colors.black12;

  @override
  Color get textColor => Colors.black87;
}

class ServiceItem implements ListItem<String, String> {
  @override
  final String key;

  @override
  final String value;

  @override
  Color get backgroundColor => Colors.black12;

  @override
  Color get textColor => Colors.black87;

@override
  bool operator ==(Object other) =>
      identical(this, other) || (other is ListItem && other.value == value);

  @override
  int get hashCode => key.hashCode;

  ServiceItem(this.key, this.value);
}

class BookingStatusItem implements ListItem<String, String> {
  @override
  final String key;
  @override
  final String value;
  @override
  final Color backgroundColor;
  @override
  final Color textColor;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is ListItem && other.value == value);

  @override
  int get hashCode => key.hashCode;

  BookingStatusItem(this.key, this.value,
      {required this.backgroundColor, required this.textColor});
}
