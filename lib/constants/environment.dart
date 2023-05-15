import 'package:flutter/foundation.dart';

class Environment {
  static const _apiUrlDevelopment = 'http://skunkworks.ignitesol.com:8000';
  static const _apiUrlProduction = 'http://skunkworks.ignitesol.com:8000';

  static String get apiUrl => kDebugMode ? _apiUrlDevelopment : _apiUrlProduction;
}
