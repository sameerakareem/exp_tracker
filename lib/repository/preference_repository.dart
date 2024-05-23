import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

export '../repository/preference_repository.dart';

class PreferencesRepository {
  static final PreferencesRepository _instance =
      PreferencesRepository._internal();

  factory PreferencesRepository() {
    return _instance;
  }

  PreferencesRepository._internal();

  late SharedPreferences _preferences;

  Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Example methods for reading and writing data to SharedPreferences
  String getString(String key, {String defaultValue = ''}) {
    return _preferences.getString(key) ?? defaultValue;
  }

  Future<void> setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  int getInt(String key, {int defaultValue = 0}) {
    return _preferences.getInt(key) ?? defaultValue;
  }

  Future<void> setInt(String key, int value) async {
    await _preferences.setInt(key, value);
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return _preferences.getBool(key) ?? defaultValue;
  }

  Future<void> setBool(String key, bool value) async {
    await _preferences.setBool(key, value);
  }

  // Add more methods as needed
  Future<void> remove(String key) async {
    await _preferences.remove(key);
  }

  // Example method for clearing all SharedPreferences
  Future<void> clear() async {
    await _preferences.clear();
  }

  static const String _themeKey = 'selected_theme';
  static const String _languageKey = 'selected_language';
  static const String _selectedProfileKey = '_selectedProfileKey';
  static const profileKey = '_profileKey';


  /// App theme
  Future<void> saveSelectedTheme(bool isDarkTheme) async {
    final themeName = isDarkTheme ? 'dark' : 'light';
    await setString(_themeKey, themeName);
  }

  /// Load the selected theme from Preferences
  String getSelectedTheme() {
    return getString(_themeKey, defaultValue: 'light');
  }

  /// App Language
  Future<void> saveSelectedLanguage(String lang) async {
    await setString(_languageKey, lang);
  }

  /// Load the selected lang from Preferences
  String getSelectedLanguage() {
    return getString(_languageKey, defaultValue: 'en');
  }

  /// save ref UuId
  Future<void> saveRefUuid(String uuid) async {
    await setString('_refUuid', uuid);
  }

  /// Load the selected ref Uuid
  String getRefUuid() {
    return getString('_refUuid');
  }
}
