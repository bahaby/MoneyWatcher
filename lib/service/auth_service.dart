import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:money_watcher/model/user.dart';
import 'package:money_watcher/service/local_storage_service.dart';
import 'package:money_watcher/service_locator.dart';

class AuthService {
  final String authUrl = "https://726729cceaa3.ngrok.io/api/auth/";

  Future<String> login(User user) async {
    final headers = {
      "Content-Type": "application/json",
    };
    final data = jsonEncode({
      'Email': user.email,
      'Password': user.password,
    });
    http.Response response = await http.post(
      Uri.parse(authUrl + 'login'),
      headers: headers,
      body: data,
    );
    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      var storageService = getIt<LocalStorageService>();
      storageService.saveToDisk('token', responseData['token']);
      return responseData['token'];
    } else {
      throw Exception("login error");
    }
  }

  Future<User> register(User user) async {
    final headers = {
      "Content-Type": "application/json",
    };
    final data = jsonEncode({
      'FullName': user.fullName,
      'Email': user.email,
      'Password': user.password,
    });
    http.Response response = await http.post(
      Uri.parse(authUrl + 'register'),
      headers: headers,
      body: data,
    );
    final responseData = jsonDecode(response.body);
    if (response.statusCode == 201) {
      var storageService = getIt<LocalStorageService>();
      storageService.saveToDisk('token', responseData['token']);
      return User.fromJson(responseData);
    } else {
      throw Exception("register error");
    }
  }
}
