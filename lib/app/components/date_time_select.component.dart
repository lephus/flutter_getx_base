import 'package:flutter/cupertino.dart';
import 'package:flutter_getx_base/app/core/theme/app_colors.dart';
import 'package:flutter_getx_base/app/core/theme/app_size.dart';
import 'package:flutter_getx_base/app/core/theme/text_styles.dart';
import 'package:flutter_getx_base/app/core/utils/date_time_picker.util.dart';
import 'package:flutter/material.dart' hide CarouselController;

// ignore: must_be_immutable
class DaySelect extends StatelessWidget {
  final DateTime? value;
  final Function chooseDate;
  final String? label;
  final String errorText;
  final String? hindText;
  final DateTime? from;
  Widget? suffixIcon;
  final Widget? prefixIcon;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color bgColor;
  final BorderRadius? borderRadius;
  final bool isDisable;
  Color borderColor;

  DaySelect({
    super.key,
    this.value,
    required this.chooseDate,
    this.label,
    this.errorText = '',
    this.hindText,
    this.from,
    this.isDisable = false,
    this.suffixIcon = const Icon(
      Icons.date_range_outlined,
      color: AppColors.kDark3,
    ),
    this.prefixIcon,
    this.padding,
    this.margin,
    this.bgColor = AppColors.kWhite,
    this.borderRadius,
    this.borderColor = AppColors.kDark3,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (isDisable == false) {
          DateTime? result = await DateTimeHelper.showDayPicker(
              context, value ?? DateTime.now(),
              firstDate: from);
          if (result != null) {
            chooseDate(result);
          }
        }
      },
      child: _buildChild(),
    );
  }

  Widget _buildChild() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label ?? '',
            style: AppStyles.body16.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              height: 16 / 12,
              leadingDistribution: TextLeadingDistribution.even,
            ),
          ),
        const SizedBox(
          height: AppSize.kSpacing8,
        ),
        Container(
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: AppSize.kSpacing20,
                vertical: AppSize.kSpacing8,
              ),
          margin: margin,
          decoration: _buildDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (prefixIcon != null) prefixIcon ?? const SizedBox(),
              if (prefixIcon != null) const SizedBox(width: 8),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    value != null
                        ? Text(DateTimeHelper.dayFormat(value))
                        : Text(
                            '--/--/--',
                            style: AppStyles.body18.copyWith(
                              color: AppColors.kDark7,
                            ),
                          ),
                    if (suffixIcon != null) suffixIcon ?? const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (errorText.isNotEmpty)
          Text(
            errorText,
            style: AppStyles.body16.copyWith(color: AppColors.kRed5),
          )
      ],
    );
  }

  BoxDecoration _buildDecoration() {
    if (errorText.isNotEmpty) {
      borderColor = AppColors.kRed5;
    }
    return BoxDecoration(
      color: isDisable ? AppColors.kDark1 : bgColor,
      borderRadius: borderRadius ?? BorderRadius.circular(AppSize.kRadius12),
      border: Border.all(color: borderColor),
    );
  }
}

class TimeSelect extends StatelessWidget {
  final DateTime value;
  final Function chooseTime;
  final String errorText;
  final String? hindText;

  const TimeSelect({
    super.key,
    required this.value,
    required this.chooseTime,
    this.errorText = '',
    this.hindText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.kPrimary,
              ),
              borderRadius: BorderRadius.circular(28.0),
              color: AppColors.kBgColor,
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            margin: const EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    DateTimeHelper.timeFormat(value),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                )
              ],
            ),
          ),
          onTap: () async {
            TimeOfDay? result =
                await DateTimeHelper.showTimePickerDialog(context, value);
            if (result != null) {
              DateTime res = DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, result.hour, result.minute, 0);
              chooseTime(res);
            }
          },
        ),
        if (errorText.isNotEmpty)
          Text(
            errorText,
            style: AppStyles.body16.copyWith(color: AppColors.kRed5),
          )
      ],
    );
  }
}

class CupertinoTimerPickerComponent extends StatefulWidget {
  final DateTime? initTime;
  final Function(Duration value)? onTimerDurationChanged;
  final EdgeInsets margin;
  const CupertinoTimerPickerComponent(
      {super.key,
      this.initTime,
      this.onTimerDurationChanged,
      this.margin = const EdgeInsets.symmetric(vertical: AppSize.kSpacing12)});

  @override
  CupertinoTimerPickerState createState() => CupertinoTimerPickerState();
}

class CupertinoTimerPickerState extends State<CupertinoTimerPickerComponent> {
  Duration _duration = Duration(hours: DateTime.now().hour, minutes: 0);

  @override
  void initState() {
    setState(() {
      if (widget.initTime != null) {
        _duration = Duration(
          hours: widget.initTime!.hour,
          minutes: widget.initTime!.minute,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: widget.margin,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.kDark1,
          borderRadius: BorderRadius.circular(18),
        ),
        child: SizedBox(
          height: 200,
          child: CupertinoTimerPicker(
            backgroundColor: Colors.transparent,
            initialTimerDuration: _duration,
            itemExtent: 48,
            minuteInterval: 30,
            mode: CupertinoTimerPickerMode.hm,
            onTimerDurationChanged: (Duration newDuration) {
              setState(() {
                _duration = newDuration;
                if (widget.onTimerDurationChanged != null) {
                  widget.onTimerDurationChanged!(newDuration);
                }
              });
            },
          ),
        ),
      ),
    );
  }
}
