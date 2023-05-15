import 'dart:math';

import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';

extension RandomExtension on Random {
  int nextRandomNumberRangeInt({required int min, required int max}) {
    return min + nextInt(max - min);
  }

  double nextRandomNumberRangeDouble({required int min, required int max}) => nextRandomNumberRangeInt(min: min, max: max).toDouble();
}

extension AssetGenImageExtension on AssetGenImage {
  AssetImage get assetImage => AssetImage(path);
}
