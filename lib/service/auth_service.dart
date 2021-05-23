import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:money_watcher/model/user.dart';
import 'package:money_watcher/service/local_storage_service.dart';
import 'package:money_watcher/service_locator.dart';

class AuthService {
  final String authUrl = "https://cdf7f90d7138.ngrok.io/api/auth/";

  Future<String> login(User user) async {
    final headers = {
      "Content-Type": "application/json",
    };
    final data = jsonEncode(user.toJson());
    http.Response response = await http.post(
      Uri.parse(authUrl),
      headers: headers,
      body: data,
    );
    final responseData = jsonDecode(response.body);
    print(responseData);
    if (response.statusCode == 200) {
      var storageService = getIt<LocalStorageService>();
      storageService.saveToDisk('token', responseData['data']['token']);
      return responseData['data']['token'];
    } else {
      throw Exception("login error");
    }
  }

  Future<bool> register(User user) async {
    final headers = {
      "Content-Type": "application/json",
    };
    final data = jsonEncode(user.toJson());
    http.Response response = await http.post(
      Uri.parse(authUrl + 'register'),
      headers: headers,
      body: data,
    );
    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return responseData['status'];
    } else {
      throw Exception("register error");
    }
  }
}
