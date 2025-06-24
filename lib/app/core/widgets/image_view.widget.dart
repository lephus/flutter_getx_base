import 'dart:io';
import 'dart:core';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_getx_base/app/core/utils/file.utils.dart';
import 'package:flutter_getx_base/gen/assets.gen.dart';

enum ImageType {
  asset,
  file,
  network,
  svg,
  svgNetwork,
}

class ImageViewWidget extends StatefulWidget {
  /// `imagePath` can be a path from project asset, file local, internet, svg.
  ///
  /// with `imagePath` is path from device folder
  final String imagePath;

  /// This setting is define imagePath is ImageType, widget will check what
  /// extension of imagePath you provided.
  ///
  /// If you know what type of image is, you can assign `type` prop for returning
  /// true `ImageType` what you want.
  ///
  /// Example: `ImageType.asset` is image from `assets` folder of project
  ///
  /// See also:
  ///  * `ImageType.file` is image from directory of device
  ///  * `ImageType.network` is image from network
  ///  * `ImageType.svg` is `svg` image from `assets` folder of project
  ///  * `ImageType.svgFile` is `svg` image from `file` folder device
  ///  * `ImageType.svgNetwork` is `svg` image  from network
  final ImageType? type;

  final ImageWidgetBuilder? imageBuilder;

  final double scale;

  final double? width;

  final double? height;

  final Color? color;
  final Color? backgroundColor;
  final LinearGradient? backgroundLinear;

  final BoxFit fit;

  final Alignment alignment;

  final FilterQuality filterQuality;

  final Clip clipBehavior;

  final BorderRadius? borderRadius;
  final EdgeInsets? padding;

  final Duration? fadeInDuration;
  final Duration? fadeOutDuration;

  final Widget? placeholder;
  final String? errorAssetImage;
  final Widget? errorWidget;
  final String? borderRadiusWeb;
  final bool imageWeb;

  const ImageViewWidget(
    this.imagePath, {
    super.key,
    this.type,
    this.imageBuilder,
    this.backgroundLinear,
    this.scale = 1.0,
    this.padding,
    this.width,
    this.height,
    this.color,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.filterQuality = FilterQuality.high,
    this.clipBehavior = Clip.hardEdge,
    this.borderRadius,
    this.errorAssetImage,
    this.fadeInDuration,
    this.fadeOutDuration,
    this.placeholder,
    this.errorWidget,
    this.borderRadiusWeb,
    this.imageWeb = false,
  });

  @override
  State<ImageViewWidget> createState() => _ImageViewWidgetState();
}

class _ImageViewWidgetState extends State<ImageViewWidget> {
  @override
  Widget build(BuildContext context) {
    String imageUrl = widget.imagePath;
    if (imageUrl == '') {
      imageUrl = widget.errorAssetImage != null
          ? widget.errorAssetImage!
          : Assets.images.placeholder.path;
    }

    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.zero,
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: imageWidget(imageUrl),
      ),
    );
  }

  Widget imageWidget(String imagePath) {
    final correctType = widget.type ?? checkImageType();
    const defaultPlaceholder = Image(
      image: BlurHashImage('LGF5?xYk^6#M@-5c,1J5@[or[Q6.'),
      fit: BoxFit.cover,
    );

    final defaultErrorWidget = Image.asset(
      widget.errorAssetImage != null
          ? widget.errorAssetImage!
          : Assets.images.placeholder.path,
    );

    switch (correctType) {
      case ImageType.asset:
        return Image.asset(
          imagePath,
          key: widget.key,
          color: widget.color,
          fit: widget.fit,
          scale: widget.scale,
          errorBuilder: (context, exception, stackTrace) =>
              widget.errorWidget ?? defaultErrorWidget,
          alignment: widget.alignment,
        );
      case ImageType.file:
        return Image.file(
          File(imagePath),
          key: widget.key,
          color: widget.color,
          fit: widget.fit,
          scale: widget.scale,
          errorBuilder: (context, exception, stackTrace) =>
              widget.errorWidget ?? defaultErrorWidget,
          alignment: widget.alignment,
        );
      case ImageType.network:
        return CachedNetworkImage(
          imageUrl: imagePath,
          imageBuilder: widget.imageBuilder ??
              (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: widget.fit,
                        scale: widget.scale,
                        alignment: widget.alignment,
                      ),
                    ),
                  ),
          fit: widget.fit,
          alignment: widget.alignment,
          fadeInDuration: widget.fadeInDuration ?? Duration.zero,
          fadeOutDuration:
              widget.fadeOutDuration ?? const Duration(milliseconds: 100),
          placeholder: (context, url) =>
              widget.placeholder ?? defaultPlaceholder,
          errorWidget: (context, url, error) =>
              widget.errorWidget ?? defaultErrorWidget,
        );

      case ImageType.svg:
        return Container(
          padding: widget.padding,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            gradient: widget.backgroundLinear,
          ),
          child: SvgPicture.asset(
            imagePath,
            width: widget.width,
            height: widget.height,
            key: widget.key,
            fit: widget.fit,
            placeholderBuilder: (_) => widget.placeholder ?? defaultPlaceholder,
            clipBehavior: widget.clipBehavior,
            alignment: widget.alignment,
          ),
        );
      case ImageType.svgNetwork:
        return SvgPicture.network(
          imagePath,
          width: widget.width,
          height: widget.height,
          key: widget.key,
          fit: widget.fit,
          placeholderBuilder: (_) => widget.placeholder ?? defaultPlaceholder,
          clipBehavior: widget.clipBehavior,
          alignment: widget.alignment,
        );
    }
  }

  ImageType checkImageType() {
    switch (FileUtil.getFileExtension(widget.imagePath)) {
      case '.png':
      case '.jpg':
      case '.gif':
      case '.jepg':
        if (FileUtil.applicationDir.isEmpty &&
            widget.imagePath.contains(FileUtil.applicationDir)) {
          return ImageType.file;
        }
        if (widget.imagePath.startsWith('http')) {
          return ImageType.network;
        }
        return ImageType.asset;
      case '.svg':
        if (widget.imagePath.startsWith('http')) {
          return ImageType.svgNetwork;
        }
        return ImageType.svg;
      default:
        if (widget.imagePath.startsWith('http')) {
          return ImageType.network;
        }
        return ImageType.asset;
    }
  }
}
