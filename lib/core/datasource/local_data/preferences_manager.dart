import 'package:shared_preferences/shared_preferences.dart';

// in this class I use Singleton Design Patterns.
class PreferencesManager {
  static final PreferencesManager _instance = PreferencesManager._internal();
  late final SharedPreferences _preferences;

  // Factory constructor to return the singleton instance.
  // imp : The Important part of factory constructor in this constructor can return instance.
  factory PreferencesManager() {
    return _instance;
  }

  // Named Constructor The object of create instance from this class.
  PreferencesManager._internal();

  // This init refers to the initialization.
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    // _preferences.setInt(key, value)
  }

  // Set
  // imp think this method return true when Data was successfully saved, and the method return false when Saving failed (rare, usually due to disk issues).
  Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    return await _preferences.setStringList(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    return await _preferences.setInt(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    return await _preferences.setDouble(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _preferences.setBool(key, value);
  }

  // Get
  String? getString(String key) {
    return _preferences.getString(key);
  }

  List<String>? getStringList(String key) {
    return _preferences.getStringList(key);
  }

  int? getInt(String key) {
    return _preferences.getInt(key);
  }

  double? getDouble(String key) {
    return _preferences.getDouble(key);
  }

  bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  Future<bool> remove(String key) async {
    return await _preferences.remove(key);
  }

  Future<bool> clear(String key) async {
    return await _preferences.clear();
  }
}
