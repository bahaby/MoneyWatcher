import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:money_watcher/model/user.dart';

class AuthService {
  final String registerUrl = "https://f64671e05fc2.ngrok.io/api/auth/register2";
  final String loginUrl = "https://f64671e05fc2.ngrok.io/api/auth/login";

  Future<String> login(User user) async {
    final headers = {
      "Content-Type": "application/json",
    };
    final data = jsonEncode(user.toJson());
    http.Response response = await http.post(
      Uri.parse(loginUrl),
      headers: headers,
      body: data,
    );
    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return responseData['token'];
    } else {
      throw ErrorDescription("login error");
    }
  }

  Future<User> register(User user) async {
    final headers = {
      "Content-Type": "application/json",
    };
    final data = jsonEncode(user.toJson());
    http.Response response = await http.post(
      Uri.parse(registerUrl),
      headers: headers,
      body: data,
    );
    final responseData = jsonDecode(response.body);
    if (response.statusCode == 201) {
      return User.fromJson(responseData);
    } else {
      throw ErrorDescription("register error");
    }
  }
}
