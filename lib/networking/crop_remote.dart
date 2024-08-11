import 'dart:convert';

import 'package:dio/dio.dart' as other;
import 'package:farmers_guide/constants/app_url.dart';
import 'package:farmers_guide/models/crop.dart';
import 'package:farmers_guide/models/crop_advice.dart';
import 'package:farmers_guide/models/crop_desease.dart';
import 'package:farmers_guide/networking/http_client.dart';
import 'package:farmers_guide/services/token_service.dart';
import 'package:farmers_guide/services/user_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

abstract class CropRemote {
  static Future<(String? error, String success)> registerCrop(Crop crop) async {
    // Convert Register object to JSON
    final Map<String, dynamic> cropJson = crop.toJson();

    // Make the POST request
    final Response response = await httpClient.post(
      Uri.parse("$baseUrl/crops"),
      body: jsonEncode(cropJson),
    );

    // Check if the request was successful
    if (response.isSuccessful) {
      // Parse the response body into a RegisterResponse object
      final Map<String, dynamic> _ = jsonDecode(response.body);
      await userMeState.fetch();
      return (null, 'Crop successfully created');
    } else {
      final responseBody = jsonDecode(response.body);
      final String? detail = responseBody['detail'];
      return (detail ?? 'Server error', '');
    }
  }

  static Future<(String? error, List<Crop>? crops)> fetchCrops() async {
    // Convert Register object to JSON

    // Make the POST request
    final Response response = await httpClient.get(
      Uri.parse("$baseUrl/crops"),
    );

    // Check if the request was successful
    if (response.isSuccessful) {
      // Parse the response body into a RegisterResponse object
      final List<dynamic> cropsListJson = jsonDecode(response.body);
      final List<Crop> farms =
          cropsListJson.map((element) => Crop.fromJson(element)).toList();
      return (null, farms);
    } else {
      final responseBody = jsonDecode(response.body);
      final String? detail = responseBody['detail'];
      return (detail ?? 'Server error', null);
    }
  }

  static Future<(String? error, CropDisease? cropDisease)> fetchCropDisease(
      {required int cropId,
      required String userPrompt,
      required String imagePath}) async {
    // Convert Register object to JSON
    // Make the POST request
    try {
      final token = await TokenService.getAccessToken();
      final dio = other.Dio();

      var postUri = Uri.parse(
          "$baseUrl/crop-diseases/detect?crop_id=$cropId&user_prompt=$userPrompt");

      other.FormData formData = other.FormData.fromMap(
          {"files": await other.MultipartFile.fromFile(imagePath)});
      final other.Response response = await dio.postUri(
        postUri,
        data: formData,
        options: other.Options(
          headers: {
            'authorization': 'Bearer $token',
          },
        ),
      );

      // Check if the request was successful

      // Parse the response body into a RegisterResponse object
      final Map<String, dynamic> diseaseJson = response.data;
      final CropDisease cropDisease = CropDisease.fromJson(diseaseJson);
      return (null, cropDisease);
    } on other.DioException catch (e) {
      final response = e.response;
      if (response != null) {
        final responseBody = jsonDecode(response.data);
        final String? detail = responseBody['detail'];
        return (detail ?? 'Server error', null);
      }
      return ('Server error', null);
    }
  }

  static Future<(String? error, CropAdvice? cropAdvice)> fetchCropAdvice(
      {required int cropId, required String date}) async {
    // Convert Register object to JSON
    // Make the POST request
    try {
      final Response response = await httpClient.get(
        Uri.parse("$baseUrl/farming_advice/crop/$cropId?date=$date"),
      );

      // Check if the request was successful
      if (response.isSuccessful) {
        // Parse the response body into a RegisterResponse object
        final Map<String, dynamic> adviceJson = jsonDecode(response.body);
        final CropAdvice cropAdvice = CropAdvice.fromJson(adviceJson);
        return (null, cropAdvice);
      } else {
        final responseBody = jsonDecode(response.body);
        final String? detail = responseBody['detail'];
        return (detail ?? 'Server error', null);
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
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
