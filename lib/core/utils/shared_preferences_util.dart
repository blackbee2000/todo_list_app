import 'package:shared_preferences/shared_preferences.dart';

class _StorageKey {
  _StorageKey._();

  static const String theme = 'isDarkMode';
}

class SharedPreferencesUtil {
  SharedPreferencesUtil._();
  static final SharedPreferencesUtil _instance = SharedPreferencesUtil._();
  static SharedPreferencesUtil get instance => _instance;

  static Future<void> saveThemeMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_StorageKey.theme, isDarkMode);
  }

  static Future<bool?> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_StorageKey.theme);
  }
}
