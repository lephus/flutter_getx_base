import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';

import 'package:flutter_getx_base/gen/assets.gen.dart';
import 'package:flutter_getx_base/app/core/widgets/image_view.widget.dart';
import 'package:flutter_getx_base/app/core/widgets/image_picker.widget.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({
    super.key,
    this.image,
    this.onChoosedImage,
    this.height,
    this.width, 
    this.borderRadius,
  });
  final String? image;
  final Function(String? imagePath)? onChoosedImage;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  String? avartarPath;

  FutureOr<void> onChooseAvatar(BuildContext context) async {
    File? imagePicked = await updateImage(context);
    setState(() {
      if (imagePicked == null) {
        avartarPath = widget.image??Assets.icons.icPictureIos;
      }else{
    widget.onChoosedImage?.call(imagePicked.path);
      }
    });
  }

  Future<File?> updateImage(BuildContext context) async {
    try {
      return await CustomImagePicker.appBottomSheet(context);
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    avartarPath = widget.image ?? Assets.icons.icPictureIos;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChooseAvatar(context),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ImageViewWidget(
            avartarPath??Assets.images.placeholder.path,
            width: widget.width ?? 180,
            height: widget.height ?? 180,
            borderRadius: widget.borderRadius ?? BorderRadius.circular(18),
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
