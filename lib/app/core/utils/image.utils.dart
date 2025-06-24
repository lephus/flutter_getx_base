// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_getx_base/app/core/theme/app_colors.dart';
import 'package:flutter_getx_base/app/core/widgets/message.util.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageUtility {
  static Future<File?> cropImage({
    required File imageFile,
    double? width,
    double? height,
  }) async {
    String type = getFileType(imageFile);
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      compressQuality: 70,
      aspectRatio: CropAspectRatio(ratioX: width ?? 1.0, ratioY: height ?? 1.0),
      compressFormat:
          type == 'png' ? ImageCompressFormat.png : ImageCompressFormat.jpg,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarColor: Colors.black,
          toolbarTitle: '',
          hideBottomControls: true,
          toolbarWidgetColor: AppColors.kPrimary,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: '',
          aspectRatioLockEnabled: true,
          hidesNavigationBar: true,
          rotateButtonsHidden: true,
          rotateClockwiseButtonHidden: true,
          aspectRatioPickerButtonHidden: true,
          resetButtonHidden: true,
        ),
      ],
    );
    return croppedFile != null ? File(croppedFile.path) : null;
  }

  static String getFileType(var file) {
    List<String> pathInList = file!.path.split('.');
    return pathInList[pathInList.length - 1];
  }

  static Future<File> reduceFileSize(
    File file, {
    int quality = 80,
  }) async {
    final tempDir = await getTemporaryDirectory();
    String targetPath = join(tempDir.path, basename(file.path));
    XFile? compressedFile = await FlutterImageCompress.compressAndGetFile(
      file.path,
      targetPath,
      quality: quality,
    );
    return compressedFile != null ? File(compressedFile.path) : file;
  }

  static Future<void> handelPermissionCamera(BuildContext context) async {
    var status = await Permission.camera.request();
    if (status.isGranted || status.isLimited) {
      return;
    } else {
      MessageDialog.showCustomDialog(
        message:
            'To use camera, please give app access to your device camera in your phone’s privacy settings.',
        title: 'Oops!',
        confirmButtonText: 'Settings',
        onConfirm: () {
          openAppSettings();
        },
        cancelButtonText: 'Not Now',
      );
    }
  }

  static Future<void> handelPermissionLibrary(BuildContext context) async {
    PermissionStatus status;
    status = await Permission.photos.request();
    if (status.isGranted || status.isLimited) {
      return;
    } else {
      MessageDialog.showCustomDialog(
        title: 'Oops!',
        confirmButtonText: 'Settings',
        onConfirm: () {
          openAppSettings();
        },
        cancelButtonText: 'Not Now',
        message:
            'To use photos, please give app access to your device library in your phone’s privacy settings.',
      );
    }
  }
}
