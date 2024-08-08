import 'dart:convert';

import 'package:farmers_guide/models/account.dart';
import 'package:farmers_guide/models/login_request.dart';
import 'package:farmers_guide/models/token.dart';
import 'package:http/http.dart' as http;

import '../models/register.dart';

class Networking {
  Future<RegisterResponse> registerUser(Register register, String url) async {
    // Convert Register object to JSON
    final Map<String, dynamic> registerJson = register.toJson();

    // Make the POST request
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(registerJson),
    );

    // Check if the request was successful
    if (response.isSuccessful) {
      // Parse the response body into a RegisterResponse object
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return RegisterResponse.fromJson(responseData);
    } else {
      throw Exception('Failed to register user: ${response.statusCode}');
    }
  }

  Future<AuthToken> loginUser(LoginRequest request, String url) async {
    // Convert Register object to JSON
    final Map<String, dynamic> requestJson = request.toJson();

    // Make the POST request
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestJson),
    );

    // Check if the request was successful
    if (response.isSuccessful) {
      // Parse the response body into a RegisterResponse object
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return AuthToken.fromJson(responseData);
    } else {
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }
}

extension on http.Response {
  bool get isSuccessful => (statusCode >= 200 && statusCode <= 299);
  bool get isClientError => (statusCode >= 400 && statusCode <= 499);
  bool get isServerError => (statusCode >= 500 && statusCode <= 599);
  bool get isFailure => isClientError || isServerError;
}
