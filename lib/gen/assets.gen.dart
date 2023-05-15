/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class $AssetsAnimationsGen {
  const $AssetsAnimationsGen();

  /// File path: assets/animations/astronaut-illustration.json
  LottieGenImage get astronautIllustration =>
      const LottieGenImage('assets/animations/astronaut-illustration.json');

  /// File path: assets/animations/loader.json
  LottieGenImage get loader =>
      const LottieGenImage('assets/animations/loader.json');

  /// List of all assets
  List<LottieGenImage> get values => [astronautIllustration, loader];
}

class $AssetsIconGen {
  const $AssetsIconGen();

  /// File path: assets/icon/adventure.svg
  SvgGenImage get adventure => const SvgGenImage('assets/icon/adventure.svg');

  /// File path: assets/icon/back.svg
  SvgGenImage get back => const SvgGenImage('assets/icon/back.svg');

  /// File path: assets/icon/cancel.svg
  SvgGenImage get cancel => const SvgGenImage('assets/icon/cancel.svg');

  /// File path: assets/icon/drama.svg
  SvgGenImage get drama => const SvgGenImage('assets/icon/drama.svg');

  /// File path: assets/icon/fiction.svg
  SvgGenImage get fiction => const SvgGenImage('assets/icon/fiction.svg');

  /// File path: assets/icon/history.svg
  SvgGenImage get history => const SvgGenImage('assets/icon/history.svg');

  /// File path: assets/icon/humour.svg
  SvgGenImage get humour => const SvgGenImage('assets/icon/humour.svg');

  /// File path: assets/icon/icon_language.png
  AssetGenImage get iconLanguage =>
      const AssetGenImage('assets/icon/icon_language.png');

  /// File path: assets/icon/icon_theme.png
  AssetGenImage get iconTheme =>
      const AssetGenImage('assets/icon/icon_theme.png');

  /// File path: assets/icon/next.svg
  SvgGenImage get next => const SvgGenImage('assets/icon/next.svg');

  /// File path: assets/icon/philosophy.svg
  SvgGenImage get philosophy => const SvgGenImage('assets/icon/philosophy.svg');

  /// File path: assets/icon/politics.svg
  SvgGenImage get politics => const SvgGenImage('assets/icon/politics.svg');

  /// File path: assets/icon/search.svg
  SvgGenImage get search => const SvgGenImage('assets/icon/search.svg');

  /// List of all assets
  List<dynamic> get values => [
        adventure,
        back,
        cancel,
        drama,
        fiction,
        history,
        humour,
        iconLanguage,
        iconTheme,
        next,
        philosophy,
        politics,
        search
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/astronaut_nointernet.png
  AssetGenImage get astronautNointernet =>
      const AssetGenImage('assets/images/astronaut_nointernet.png');

  /// File path: assets/images/pattern.svg
  SvgGenImage get pattern => const SvgGenImage('assets/images/pattern.svg');

  /// List of all assets
  List<dynamic> get values => [astronautNointernet, pattern];
}

class Assets {
  Assets._();

  static const $AssetsAnimationsGen animations = $AssetsAnimationsGen();
  static const $AssetsIconGen icon = $AssetsIconGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

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
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
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

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated Clip? clipBehavior,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class LottieGenImage {
  const LottieGenImage(this._assetName);

  final String _assetName;

  LottieBuilder lottie({
    Animation<double>? controller,
    bool? animate,
    FrameRate? frameRate,
    bool? repeat,
    bool? reverse,
    LottieDelegates? delegates,
    LottieOptions? options,
    void Function(LottieComposition)? onLoaded,
    LottieImageProviderFactory? imageProviderFactory,
    Key? key,
    AssetBundle? bundle,
    Widget Function(BuildContext, Widget, LottieComposition?)? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    String? package,
    bool? addRepaintBoundary,
    FilterQuality? filterQuality,
    void Function(String)? onWarning,
  }) {
    return Lottie.asset(
      _assetName,
      controller: controller,
      animate: animate,
      frameRate: frameRate,
      repeat: repeat,
      reverse: reverse,
      delegates: delegates,
      options: options,
      onLoaded: onLoaded,
      imageProviderFactory: imageProviderFactory,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: package,
      addRepaintBoundary: addRepaintBoundary,
      filterQuality: filterQuality,
      onWarning: onWarning,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
