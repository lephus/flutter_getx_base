import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter/services.dart';
import 'package:flutter_getx_base/app/core/theme/app_colors.dart';
import 'package:flutter_getx_base/app/core/theme/app_size.dart';
import 'package:flutter_getx_base/app/core/theme/text_styles.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final String label;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final void Function(String?)? onSaved;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final void Function()? onTapPrefixIcon;
  final VoidCallback? onTapSuffixIcon;
  final double? textfieldHeight;
  final FormFieldValidator? validator;
  final TextInputAction? textInputAction;
  final String? errorText;
  final int? maxLines;
  final bool readOnly;
  final double borderRadius;
  final bool paddingTop;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  const TextFieldWidget({
    super.key,
    this.hintText = '',
    this.onChanged,
    this.onTapPrefixIcon,
    this.onSaved,
    this.prefixIcon,
    required this.controller,
    this.label = '',
    this.onFieldSubmitted,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.onTapSuffixIcon,
    this.textfieldHeight,
    this.validator,
    this.textInputAction,
    this.errorText,
    this.maxLines,
    this.readOnly = false,
    this.borderRadius = 12,
    this.paddingTop = true,
    this.focusNode,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.sentences,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (paddingTop)
          Text(
            label,
            style: AppStyles.body16.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              height: 16 / 12,
              leadingDistribution: TextLeadingDistribution.even,
            ),
          ),
        if (paddingTop)
          const SizedBox(
            height: AppSize.kSpacing10,
          ),
        _buildTextFormField(context),
        Text(
          errorText ?? '',
          style: AppStyles.body14.copyWith(
            color: AppColors.kRed5,
            leadingDistribution: TextLeadingDistribution.even,
          ),
        ),
        SizedBox(
          height: (errorText ?? '').isEmpty ? 0 : AppSize.kSpacing8,
        ),
      ],
    );
  }

  Widget _buildTextFormField(BuildContext context) {
    if (maxLines == null || maxLines == 1) {
      return SizedBox(
        height: 42,
        child: TextFormField(
            focusNode: focusNode,
            maxLines: maxLines,
            decoration: _textFieldInputDecoration(context),
            cursorColor: AppColors.kPrimary,
            cursorHeight: 18,
            validator: validator,
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.left,
            style: AppStyles.body16,
            textInputAction: textInputAction ?? TextInputAction.done,
            textCapitalization: textCapitalization,
            onChanged: onChanged,
            onSaved: onSaved,
            onFieldSubmitted: onFieldSubmitted,
            readOnly: readOnly,
            inputFormatters: inputFormatters),
      );
    }
    return TextFormField(
        maxLines: maxLines,
        decoration: _textFieldInputDecoration(context),
        cursorColor: AppColors.kPrimary,
        cursorHeight: 18,
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.left,
        style: AppStyles.body16,
        textInputAction: textInputAction ?? TextInputAction.done,
        textCapitalization: textCapitalization,
        onChanged: onChanged,
        onSaved: onSaved,
        onFieldSubmitted: onFieldSubmitted,
        readOnly: readOnly,
        inputFormatters: inputFormatters);
  }

  InputDecoration _textFieldInputDecoration(BuildContext context) {
    return InputDecoration(
      prefixIcon: prefixIcon != null
          ? GestureDetector(
              onTap: onTapPrefixIcon ?? () {},
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: prefixIcon,
              ),
            )
          : null,
      prefixIconConstraints: const BoxConstraints(),
      suffixIconConstraints: const BoxConstraints(),
      suffixIcon: suffixIcon != null
          ? GestureDetector(
              onTap: onTapSuffixIcon ?? () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: suffixIcon,
              ),
            )
          : null,
      hintText: hintText,
      constraints: const BoxConstraints(),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 18,
        vertical: (suffixIcon != null && prefixIcon != null) ? 0 : 4,
      ),
      hintStyle: AppStyles.body16.copyWith(
        color: AppColors.kDark3,
      ),
      filled: true,
      fillColor: readOnly ? AppColors.kDark1 : AppColors.kWhite,
      border: _buildBorder(),
      enabledBorder: _buildBorder(),
      focusedBorder: _buildFocusedBorder(),
      errorBorder: _buildErrorBorder(),
    );
  }

  OutlineInputBorder _buildFocusedBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.kPrimary,
      ),
      borderRadius: BorderRadius.circular(
        borderRadius,
      ),
    );
  }

  OutlineInputBorder _buildErrorBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.kRed5,
      ),
      borderRadius: BorderRadius.circular(
        borderRadius,
      ),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.kDark3,
      ),
      borderRadius: BorderRadius.circular(
        borderRadius,
      ),
    );
  }
}
