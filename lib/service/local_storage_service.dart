import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

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

  String getJwtToken() {
    return getFromDisk('token') ?? '';
  }

  removeUserTokens() {
    removeFromDisk('token');
    removeFromDisk('userId');
    removeFromDisk('userEmail');
  }

  bool isJwtTokenValid() {
    if (isJwtTokenExpired()) {
      removeUserTokens();
      return false;
    } else {
      var jwtMap = JwtDecoder.decode(getJwtToken());
      var userIdKey = jwtMap.keys
          .firstWhere((element) => element.endsWith('nameidentifier'));
      var userEmailKey =
          jwtMap.keys.firstWhere((element) => element.endsWith('emailaddress'));
      saveToDisk('userId', jwtMap[userIdKey]);
      saveToDisk('userEmail', jwtMap[userEmailKey]);
      return true;
    }
  }

  bool isJwtTokenExpired() {
    var value = getJwtToken();
    if (value == '') {
      return true;
    } else {
      if (JwtDecoder.isExpired(value)) {
        return true;
      } else {
        return false;
      }
    }
  }

  void removeFromDisk(String key) {
    _preferences?.remove(key);
  }

  void saveToDisk(String key, String content) {
    _preferences?.setString(key, content);
  }
}
