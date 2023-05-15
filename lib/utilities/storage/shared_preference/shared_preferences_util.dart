import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../theme/theme_utils.dart';

class SharedPreferencesUtil {
  SharedPreferencesUtil._() {
    alSpKeysToRemove = <String>[keyTheme, keySession];
  }

  static SharedPreferencesUtil? _instance;

  static final SharedPreferencesUtil instance = _instance ??= SharedPreferencesUtil._();

  final String keyTheme = 'appTheme';
  final String keySession = 'session';
  final String keyAppMetaData = 'appMetaData';

  late List<String> alSpKeysToRemove;

  static late SharedPreferences _storage;

  static Future<SharedPreferences> initialize() async {
    return _storage = await SharedPreferences.getInstance();
  }

  //sets
  Future<bool> setBool(String key, bool value) async => _storage.setBool(key, value);

  Future<bool> setDouble(String key, double value) async => _storage.setDouble(key, value);

  Future<bool> setInt(String key, int value) async => _storage.setInt(key, value);

  Future<bool> setString(String key, String value) async => _storage.setString(key, value);

  Future<bool> setStringList(String key, List<String> value) async => _storage.setStringList(key, value);

  //gets
  bool? getBool(String key) => _storage.getBool(key);

  bool getBoolOrDefault(String key, bool defaultValue) => _storage.getBool(key) ?? defaultValue;

  double? getDouble(String key) => _storage.getDouble(key);

  int? getInt(String key) => _storage.getInt(key);

  String? getString(String key) => _storage.getString(key);

  List<String>? getStringList(String key) => _storage.getStringList(key);

  //deletes..
  Future<bool> remove(String key) async => _storage.remove(key);

  Future<bool> clear() async => _storage.clear();
}

extension SharedPreferencesUtilExtension on SharedPreferencesUtil {
  Map<String, dynamic> getSharedPreferenceMap(String key) {
    try {
      final spAppMetaData = getString(key);

      if (spAppMetaData != null) {
        final json = jsonDecode(spAppMetaData) as Map<String, dynamic>;
        return json;
      }

      return <String, dynamic>{};
    } catch (e) {
      return <String, dynamic>{};
    }
  }

  Future<bool> saveAppTheme(ThemeMode theme) async => setString(keyTheme, theme.name);

  ThemeMode getAppTheme() => getString(keyTheme) != null ? ThemeUtils.getThemeFromString(getString(keyTheme)!) : ThemeMode.system;

  Future<void> logout() async {
    alSpKeysToRemove.forEach((key) => remove(key));
  }

  Future<bool> removeSession() async => remove(keySession);
}
