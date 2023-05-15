import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../gen/assets.gen.dart';
import '../../navigation/navigation_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() {
    const animationTimeInSeconds = kDebugMode ? 1 : 8;
    Timer.periodic(const Duration(seconds: animationTimeInSeconds), (timer) {
      timer.cancel();
      NavigationUtils.moveToHome(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        child: Lottie.asset(
          Assets.animations.astronautIllustration.path,
          fit: BoxFit.fill,
        ),
      ),
    ));
  }
}
