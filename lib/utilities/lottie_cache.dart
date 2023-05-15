import 'package:lottie/lottie.dart';

import '../gen/assets.gen.dart';

class LottieCache {
  LottieCache._();

  static LottieCache? _instance;

  static final LottieCache instance = _instance ??= LottieCache._();

  final _lottieAssetList = {
    Assets.animations.loader,
  };

  Future<void> initialize() async{
    for (final element in _lottieAssetList) {
      await AssetLottie(element.path).load();
    }
  }
}
