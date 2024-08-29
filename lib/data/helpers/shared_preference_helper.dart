import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  final SharedPreferences prefs;

  SharedPreferenceHelper(this.prefs);

  Future<void> saveString(String key, String value) async {
    await prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    return prefs.getString(key);
  }

  Future<void> saveInt(String key, int value) async {
    await prefs.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    return prefs.getInt(key);
  }

  Future<void> saveBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    return prefs.getBool(key);
  }

  Future<void> saveDouble(String key, double value) async {
    await prefs.setDouble(key, value);
  }

  Future<double?> getDouble(String key) async {
    return prefs.getDouble(key);
  }

  Future<void> remove(String key) async {
    await prefs.remove(key);
  }

  Future<void> clear() async {
    await prefs.clear();
  }
}
