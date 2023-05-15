import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../gen/assets.gen.dart';

class WaitingScreenWidget extends StatefulWidget {
  const WaitingScreenWidget({Key? key}) : super(key: key);

  @override
  State<WaitingScreenWidget> createState() => _WaitingScreenWidgetState();

  @override
  String get screenName => 'waiting_screen';
}

class _WaitingScreenWidgetState extends State<WaitingScreenWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          Assets.animations.loader.path,
          height: 48,
          width: 48,
        ),
      ),
    );
  }
}
