import 'dart:convert';

import 'package:farmers_guide/constants/app_url.dart';
import 'package:farmers_guide/models/farm.dart';
import 'package:farmers_guide/models/weather.dart';
import 'package:farmers_guide/networking/http_client.dart';
import 'package:farmers_guide/services/user_state.dart';
import 'package:http/http.dart';

abstract class FarmRemote {
  static Future<(String? error, String success)> registerFarm(Farm farm) async {
    // Convert Register object to JSON
    final Map<String, dynamic> registerJson = farm.toJson();

    // Make the POST request
    final Response response = await httpClient.post(
      Uri.parse("$baseUrl/farms"),
      body: jsonEncode(registerJson),
    );

    // Check if the request was successful
    if (response.isSuccessful) {
      // Parse the response body into a RegisterResponse object
      final Map<String, dynamic> _ = jsonDecode(response.body);
      await userMeState.fetch();
      return (null, 'Farm successfully created');
    } else {
      final responseBody = jsonDecode(response.body);
      final String? detail = responseBody['detail'];
      return (detail ?? 'Server error', '');
    }
  }

  static Future<(String? error, List<Farm>? farms)> fetchFarms() async {
    // Convert Register object to JSON

    // Make the POST request
    final Response response = await httpClient.get(
      Uri.parse("$baseUrl/farms"),
    );

    // Check if the request was successful
    if (response.isSuccessful) {
      // Parse the response body into a RegisterResponse object
      final List<dynamic> farmsListJson = jsonDecode(response.body);
      final List<Farm> farms =
          farmsListJson.map((element) => Farm.fromJson(element)).toList();
      return (null, farms);
    } else {
      final responseBody = jsonDecode(response.body);
      final String? detail = responseBody['detail'];
      return (detail ?? 'Server error', null);
    }
  }

  static Future<(String? error, List<Weather>? forcasts)>
      fetchFarmWeatherForcast(
          {required int farmId, required int numberOfDays}) async {
    // Convert Register object to JSON
    // Make the POST request
    final Response response = await httpClient.get(
      Uri.parse(
          "$baseUrl/farm-weather-forecast?farm_id=$farmId&days=$numberOfDays"),
    );

    // Check if the request was successful
    if (response.isSuccessful) {
      // Parse the response body into a RegisterResponse object
      final Map<String, dynamic> forcastsJson = jsonDecode(response.body);
      final List<dynamic> forcastList = forcastsJson['forecast'];
      final List<Weather> farms =
          forcastList.map((element) => Weather.fromJson(element)).toList();
      return (null, farms);
    } else {
      final responseBody = jsonDecode(response.body);
      final String? detail = responseBody['detail'];
      return (detail ?? 'Server error', null);
    }
  }
}

extension on Response {
  bool get isSuccessful => (statusCode >= 200 && statusCode <= 299);
  bool get isClientError => (statusCode >= 400 && statusCode <= 499);
  bool get isServerError => (statusCode >= 500 && statusCode <= 599);
  // ignore: unused_element
  bool get isFailure => isClientError || isServerError;
}
