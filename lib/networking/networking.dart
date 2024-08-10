import 'dart:convert';

import 'package:farmers_guide/constants/app_url.dart';
import 'package:farmers_guide/models/login_request.dart';
import 'package:farmers_guide/models/token.dart';
import 'package:farmers_guide/services/token_service.dart';
import 'package:farmers_guide/services/user_state.dart';
import 'package:http/http.dart' as http;

import '../models/register.dart';

class Networking {
  static Future<(String? error, String success)> registerUser(
      Register register) async {
    // Convert Register object to JSON
    final Map<String, dynamic> registerJson = register.toJson();

    // Make the POST request
    final http.Response response = await http.post(
      Uri.parse("$baseUrl/register"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(registerJson),
    );

    // Check if the request was successful
    if (response.isSuccessful) {
      // Parse the response body into a RegisterResponse object
      final Map<String, dynamic> _ = jsonDecode(response.body);
      return (null, 'registration success');
    } else {
      final responseBody = jsonDecode(response.body);
      final String? detail = responseBody['detail'];
      return (detail ?? 'Server error', '');
    }
  }

  static Future<(String? error, String success)> loginUser(
      LoginRequest request) async {
    // Convert Register object to JSON
    final Map<String, dynamic> requestJson = request.toJson()
      ..addAll({'grant_type': 'password'});

    // Make the POST request
    final http.Response response = await http.post(
      Uri.parse("$baseUrl/token"),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: requestJson,
    );

    // Check if the request was successful
    if (response.isSuccessful) {
      // Parse the response body into a RegisterResponse object
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final authToken = AuthToken.fromJson(responseData);
      TokenService.setToken(authToken);
      await userMeState.fetch();
      return (null, 'login success');
    } else {
      final responseBody = jsonDecode(response.body);
      String? detail;
      try {
        detail = responseBody['detail'];
      } catch (e) {
        detail = 'Username or password incorrect';
      }
      return (detail ?? 'Server error', '');
    }
  }
}

extension on http.Response {
  bool get isSuccessful => (statusCode >= 200 && statusCode <= 299);
  bool get isClientError => (statusCode >= 400 && statusCode <= 499);
  bool get isServerError => (statusCode >= 500 && statusCode <= 599);
  // ignore: unused_element
  bool get isFailure => isClientError || isServerError;
}
