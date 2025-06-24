import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_getx_base/app/core/service/hive.helper.dart';
//
import 'package:flutter_getx_base/app/core/settings/app_key.dart';
import 'package:flutter_getx_base/app/core/theme/app_size.dart';
import 'package:flutter_getx_base/app/core/widgets/image_view.widget.dart';
import 'package:flutter_getx_base/app/data/enum/language.enum.dart';
import 'package:flutter_getx_base/gen/assets.gen.dart';
import 'package:get/get.dart';

class LanguageOptionsWidget extends StatefulWidget {
  final Function(String value)? onChanged;
  const LanguageOptionsWidget({super.key, this.onChanged});

  @override
  State<LanguageOptionsWidget> createState() => _LanguageOptionsWidgetState();
}

class _LanguageOptionsWidgetState extends State<LanguageOptionsWidget> {
  String currentValue = LanguageEnum.en;

  Future<void> initLocalTranslation() async {
    final currentLocal = await HiveHelper.get(
      boxName: AppKey.box,
      keyValue: AppKey.language,
    );
    if (currentLocal != null) {
      setState(() {
        Get.updateLocale(currentLocal == LanguageEnum.vi
            ? LanguageEnum.localeVi
            : LanguageEnum.localeEn);
        currentValue = currentLocal;
      });
    }
  }

  Future<void> updateLocalTranslation(String value) async {
    setState(() {
      currentValue = value;
      Get.updateLocale(
        value == LanguageEnum.vi
            ? LanguageEnum.localeVi
            : LanguageEnum.localeEn,
      );
    });
    await HiveHelper.put(
      boxName: AppKey.box,
      keyValue: AppKey.language,
      value: value,
    );
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }

  @override
  void initState() {
    initLocalTranslation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        updateLocalTranslation(
          currentValue == LanguageEnum.vi ? LanguageEnum.en : LanguageEnum.vi,
        );
      },
      child: Container(
        margin: const EdgeInsets.all(AppSize.kSpacing20),
        child: AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: ImageViewWidget(
            key: ValueKey<String>(currentValue), // Thêm key duy nhất
            currentValue == 'vi'
                ? Assets.icons.icEn.path
                : Assets.icons.icVi.path,
            width: 32,
            height: 24,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(AppSize.kRadius8),
          ),
        ),
      ),
    );
  }
}
