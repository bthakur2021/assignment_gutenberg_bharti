import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'toast_util.dart';

class AppUtils {
  AppUtils._();

  static AppUtils? _instance;

  static final AppUtils instance = _instance ??= AppUtils._();
  static const defaultPaymentErrorCode = -1;

  static Future<void> initializeAppUtils() async {}

  void refreshCurrentState(State state) {
    if (state.mounted) {
      state.setState(() {});
    }
  }

  Future<bool> configApp() async {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      timer.cancel();
    });
    return true;
  }

  Future<void> openUrl(String urlToOpen) async {
    if (urlToOpen.isEmpty) {
      return;
    }

    final url = Uri.parse(urlToOpen);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ToastUtil.showToastRelease('Could not launch $urlToOpen');
    }
  }
}
