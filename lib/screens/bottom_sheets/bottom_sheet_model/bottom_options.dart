import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';

class BottomOptions {
  BottomOptions({
    required this.title,
    required this.icon,
    required this.onTap,
    this.color,
    this.suffix,
  });

  final String title;
  final AssetGenImage icon;
  final VoidCallback onTap;
  final Color? color;
  final Widget? suffix;
}
