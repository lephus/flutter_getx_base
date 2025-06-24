/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/ic_apple.png
  AssetGenImage get icApple => const AssetGenImage('assets/icons/ic_apple.png');

  /// File path: assets/icons/ic_camera_ios.svg
  String get icCameraIos => 'assets/icons/ic_camera_ios.svg';

  /// File path: assets/icons/ic_en.png
  AssetGenImage get icEn => const AssetGenImage('assets/icons/ic_en.png');

  /// File path: assets/icons/ic_google.png
  AssetGenImage get icGoogle =>
      const AssetGenImage('assets/icons/ic_google.png');

  /// File path: assets/icons/ic_internet.svg
  String get icInternet => 'assets/icons/ic_internet.svg';

  /// File path: assets/icons/ic_picture_ios.svg
  String get icPictureIos => 'assets/icons/ic_picture_ios.svg';

  /// File path: assets/icons/ic_search.svg
  String get icSearch => 'assets/icons/ic_search.svg';

  /// File path: assets/icons/ic_vi.webp
  AssetGenImage get icVi => const AssetGenImage('assets/icons/ic_vi.webp');

  /// Directory path: assets/icons/launcher
  $AssetsIconsLauncherGen get launcher => const $AssetsIconsLauncherGen();

  /// List of all assets
  List<dynamic> get values => [
        icApple,
        icCameraIos,
        icEn,
        icGoogle,
        icInternet,
        icPictureIos,
        icSearch,
        icVi
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/placeholder.png
  AssetGenImage get placeholder =>
      const AssetGenImage('assets/images/placeholder.png');

  /// List of all assets
  List<AssetGenImage> get values => [placeholder];
}

class $AssetsIconsLauncherGen {
  const $AssetsIconsLauncherGen();

  /// File path: assets/icons/launcher/logo.png
  AssetGenImage get logoPng =>
      const AssetGenImage('assets/icons/launcher/logo.png');

  /// File path: assets/icons/launcher/logo.svg
  String get logoSvg => 'assets/icons/launcher/logo.svg';

  /// File path: assets/icons/launcher/logo_no_bg.png
  AssetGenImage get logoNoBg =>
      const AssetGenImage('assets/icons/launcher/logo_no_bg.png');

  /// File path: assets/icons/launcher/logo_radius.png
  AssetGenImage get logoRadius =>
      const AssetGenImage('assets/icons/launcher/logo_radius.png');

  /// List of all assets
  List<dynamic> get values => [logoPng, logoSvg, logoNoBg, logoRadius];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
