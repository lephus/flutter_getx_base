// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'dart:async';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_getx_base/gen/assets.gen.dart';
import 'package:flutter_getx_base/generated/locales.g.dart';
import 'package:flutter_getx_base/app/core/theme/app_size.dart';
import 'package:flutter_getx_base/app/core/theme/app_colors.dart';
import 'package:flutter_getx_base/app/core/utils/image.utils.dart';
import 'package:flutter_getx_base/app/core/theme/text_styles.dart';
import 'package:flutter_getx_base/app/core/utils/size_config.dart';
import 'package:flutter_getx_base/app/core/widgets/image_view.widget.dart';
import 'package:flutter_getx_base/app/components/unplash_image_picker.component.dart';

enum BottomSheetPicker { camera, gallery, unSplash }

const int maxSize = 2097152 * 2; // 2MB * 2

class CustomImagePicker {
  XFile? image;
  static final ImagePicker _picker = ImagePicker();
  static Future<File?> _getImageFile(String imageUrl) async {
    // Fetch the image bytes from the URL
    try {
      final Dio dio = Dio();
      final response = await dio.get(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );
      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/temp_image.png');
        await file.writeAsBytes(response.data);
        return file;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static Widget _entity({
    required BuildContext context,
    required String text,
    required String icon,
    required Function() onTap,
  }) {
    return CupertinoActionSheetAction(
      isDefaultAction: true,
      onPressed: onTap,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: AppSize.kSpacing16,
              right: AppSize.kSpacing20,
            ),
            child: ImageViewWidget(
              icon,
              height: AppSize.kSpacing24,
              width: AppSize.kSpacing24,
              color: AppColors.kBlue5,
            ),
          ),
          Text(
            text,
            style: AppStyles.body18.copyWith(color: AppColors.kDark8),
          ),
        ],
      ),
    );
  }

  static Future<File?> _pickFromLibrary({
    required BuildContext context,
    double? width,
    double? height,
  }) async {
    try {
      String pickedPath = '';
      try {
        await ImageUtility.handelPermissionLibrary(context);
        final picked = await _picker.pickImage(source: ImageSource.gallery);
        if (picked == null) {
          return null;
        }
        int fileSize = File(picked.path).lengthSync();
        //Second, Reduce image size
        File reduceFile = await ImageUtility.reduceFileSize(
          File(picked.path),
          quality: fileSize > maxSize ? 80 : 100,
        );
        // Finally, Crop image
        File? file = await ImageUtility.cropImage(
          imageFile: File(reduceFile.path),
          width: width,
          height: height,
        );
        return file;
      } catch (_) {
        return File(pickedPath);
      }
    } catch (_) {
      return null;
    }
  }

  static Future<File?> _pickFromCamera({
    required BuildContext context,
    double? width,
    double? height,
  }) async {
    try {
      String pickedPath = '';
      try {
        await ImageUtility.handelPermissionCamera(context);

        //Pick image first
        final picked = await _picker.pickImage(source: ImageSource.camera);
        if (picked == null) {
          return null;
        }
        pickedPath = picked.path;
        int fileSize = File(picked.path).lengthSync();
        // Second, Reduce image size
        File reduceFile = await ImageUtility.reduceFileSize(
          File(picked.path),
          quality: fileSize > maxSize ? 80 : 100,
        );
        // Finally, Crop image
        File? file = await ImageUtility.cropImage(
          imageFile: File(reduceFile.path),
          width: width,
          height: height,
        );
        return file;
      } catch (_) {
        return File(pickedPath);
      }
    } catch (_) {
      return null;
    }
  }

  static Future<File?> _pickFromUnplash({
    required BuildContext context,
    double? width,
    double? height,
  }) async {
    try {
      //Pick image first
      String? picked = '';
      await showUnplashCommonBottomSheet(
        context,
        child: UnPlashImagePickerWidget(
          onChoose: (result) {
            picked = result;
          },
        ),
        whenComplete: () async {
          return picked;
        },
      );
      // Second, Reduce image size
      File? reduceFile = await _getImageFile(picked!);
      // Finally, Crop image
      File? file = await ImageUtility.cropImage(
        imageFile: File(reduceFile!.path),
        width: width,
        height: height,
      );
      return file;
    } catch (_) {
      return null;
    }
  }

  static Future<File?> appBottomSheet<String>(
    BuildContext context, {
    double? width,
    double? height,
  }) async {
    final action = CupertinoActionSheet(
      actions: <Widget>[
        _entity(
          context: context,
          onTap: () async =>
              Navigator.of(context).pop(BottomSheetPicker.unSplash),
          text: LocaleKeys.texts_choose_from_internet.tr,
          icon: Assets.icons.icInternet,
        ),
        _entity(
            context: context,
            onTap: () async =>
                Navigator.of(context).pop(BottomSheetPicker.camera),
            text: LocaleKeys.texts_use_camera.tr,
            icon: Assets.icons.icCameraIos),
        _entity(
          context: context,
          onTap: () async =>
              Navigator.of(context).pop(BottomSheetPicker.gallery),
          text: LocaleKeys.texts_choose_library.tr,
          icon: Assets.icons.icPictureIos,
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          LocaleKeys.button_cancel.tr,
          style: AppStyles.body18.copyWith(color: AppColors.kRed5),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    var sheet = await showCupertinoModalPopup<BottomSheetPicker>(
      context: context,
      builder: (context) => action,
    );

    try {
      switch (sheet) {
        case BottomSheetPicker.camera:
          return await _pickFromCamera(
            context: context,
            width: width,
            height: height,
          );
        case BottomSheetPicker.gallery:
          return await _pickFromLibrary(
            context: context,
            width: width,
            height: height,
          );
        case BottomSheetPicker.unSplash:
          return await _pickFromUnplash(
            context: context,
            width: width,
            height: height,
          );
        default:
          return null;
      }
    } catch (_) {
      return null;
    }
  }
}

Future<String?> showUnplashCommonBottomSheet(
  BuildContext context, {
  required Widget child,
  Widget? trailing,
  double? radius,
  double? maxHeight,
  Color? backgroundColor,
  Function? whenComplete,
}) async {
  return await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useRootNavigator: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(radius ?? AppSize.kRadius16),
        topLeft: Radius.circular(radius ?? AppSize.kRadius16),
      ),
    ),
    constraints: BoxConstraints(
      minHeight: MediaQuery.of(context).size.height * 0.3,
      maxHeight: maxHeight ?? MediaQuery.of(context).size.height * 0.92,
    ),
    backgroundColor: backgroundColor ?? AppColors.kDark1,
    builder: (builder) {
      return Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.kDark1,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(radius ?? AppSize.kRadius16),
            topLeft: Radius.circular(radius ?? AppSize.kRadius16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              child: Container(
                width: SizeConfig.screenWidth / 5,
                height: 6,
                margin: const EdgeInsets.symmetric(
                  vertical: AppSize.kSpacing12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.kDark3,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: backgroundColor ?? AppColors.kDark1,
                child: child,
              ),
            ),
          ],
        ),
      );
    },
  ).whenComplete(() async {
    if (whenComplete != null) {
      return whenComplete();
    }
  });
}
