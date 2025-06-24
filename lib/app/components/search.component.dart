import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_getx_base/app/core/theme/app_colors.dart';
import 'package:flutter_getx_base/app/core/theme/app_size.dart';
import 'package:flutter_getx_base/app/core/theme/text_styles.dart';
import 'package:flutter_getx_base/app/core/widgets/image_view.widget.dart';
import 'package:flutter_getx_base/gen/assets.gen.dart';

typedef OnSearchSubmitted = Function(String keyWork);

class SearchComponent extends StatefulWidget {
  final TextEditingController searchController;
  final OnSearchSubmitted onSearchSubmitted;
  final String? hintText;
  final EdgeInsets? edgeInsets;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
  final bool autoFocus;
  const SearchComponent(
      {super.key,
      required this.searchController,
      required this.onSearchSubmitted,
      this.hintText,
      this.edgeInsets,
      this.margin,
      this.autoFocus = false,
      this.borderRadius});

  @override
  State<SearchComponent> createState() => _SearchComponentState();
}

class _SearchComponentState extends State<SearchComponent> {
  bool isShowClearSearchKey = false;

  @override
  void initState() {
    onUpdateShowClearSearchKey();
    super.initState();
  }

  void onUpdateShowClearSearchKey() {
    setState(() {
      isShowClearSearchKey = widget.searchController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildInputDecoration();
  }

  Widget _buildInputDecoration() {
    return Container(
      margin: widget.margin ?? const EdgeInsets.all(0),
      height: 42,
      child: TextField(
        controller: widget.searchController,
        decoration: inputDecoration,
        onSubmitted: widget.onSearchSubmitted,
        cursorHeight: 16,
        autofocus: widget.autoFocus,
        style: AppStyles.body18.copyWith(color: AppColors.kDark8),
        onChanged: (value) {
          onUpdateShowClearSearchKey();
        },
      ),
    );
  }

  OutlineInputBorder get outlineInputBorder => OutlineInputBorder(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(12.0),
        borderSide: const BorderSide(
          color: AppColors.kDark3,
        ),
      );

  InputDecoration get inputDecoration => InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSize.kSpacing16,
        ),
        hintText: widget.hintText,
        hintStyle: AppStyles.body16.copyWith(color: AppColors.kDark3),
        prefixIcon: GestureDetector(
          onTap: () {
            widget.searchController.text = '';
            widget.onSearchSubmitted(widget.searchController.text.trim());
            onUpdateShowClearSearchKey();
          },
          child: isShowClearSearchKey
              ? const Icon(
                  CupertinoIcons.clear_circled_solid,
                  size: 20,
                  color: AppColors.kDark3,
                )
              : ImageViewWidget(
                  padding: const EdgeInsets.all(6),
                  Assets.icons.icSearch,
                  width: 12,
                  height: 12,
                  fit: BoxFit.contain,
                ),
        ),
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusColor: AppColors.kPrimary,
        fillColor: AppColors.kWhite,
        filled: true,
      );
}
