import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService? _instance;
  static SharedPreferences? _preferences;
  static Future<LocalStorageService?> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  String? getFromDisk(String key) {
    var value = _preferences?.getString(key);
    return value;
  }

  void saveToDisk(String key, String content) {
    _preferences?.setString(key, content);
  }
}