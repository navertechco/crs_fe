/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering

import 'package:flutter/widgets.dart';

class $LibGen {
  const $LibGen();

  $LibAssetsGen get assets => const $LibAssetsGen();
}

class $LibAssetsGen {
  const $LibAssetsGen();

  $LibAssetsIconsGen get icons => const $LibAssetsIconsGen();
  $LibAssetsImagesGen get images => const $LibAssetsImagesGen();
}

class $LibAssetsIconsGen {
  const $LibAssetsIconsGen();

  AssetGenImage get icon => const AssetGenImage('lib/assets/icons/icon.png');
}

class $LibAssetsImagesGen {
  const $LibAssetsImagesGen();

  AssetGenImage get img => const AssetGenImage('lib/assets/images/img.png');
}

class Assets {
  Assets._();

  static const $LibGen lib = $LibGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}
