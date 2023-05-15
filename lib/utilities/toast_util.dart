import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static const bool _isDebug = kDebugMode;

  static void showToastDebug(String msg) {
    if (_isDebug) {
      _showToast(msg);
    }
  }

  static void showToastRelease(String msg) => _showToast(msg);

  static void _showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white70,
      fontSize: 16.0,
    );
  }
}
