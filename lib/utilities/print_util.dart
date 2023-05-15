import 'package:flutter/foundation.dart';

class PrintUtils {
  static const tagLogVerbose = 'AmcoLog (Verbose)->';
  static const tagLogError = 'AmcoLog (Error)->';

  static void printLog(String message) {
    _print('$tagLogVerbose $message');
  }

  static void printException(Object e) {
    _print('$tagLogError $e');
  }

  static void printError(String message) {
    _print('$tagLogError $message');
  }

  static void _print(String message) {
    if (kDebugMode) {
      debugPrint(message);
    }
  }
}
