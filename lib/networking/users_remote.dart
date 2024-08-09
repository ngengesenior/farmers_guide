import 'dart:convert';

import 'package:farmers_guide/constants/app_url.dart';
import 'package:farmers_guide/models/user.dart';
import 'package:farmers_guide/services/token_service.dart';
import 'package:http/http.dart' as http;

abstract class UsersRemote {
  static Future<User> fetchUserMe() async {
    var token = await TokenService.getAccessToken();

    try {
      final http.Response response = await http.get(
        Uri.parse("$baseUrl/users/me"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",
        },
      );

      final user = User.fromMap(jsonDecode(response.body));
      return user;
    } catch (error) {
      rethrow;
    }
  }
}
