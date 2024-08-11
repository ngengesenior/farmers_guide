import 'package:farmers_guide/models/crop.dart';
import 'package:farmers_guide/models/crop_advice.dart';
import 'package:farmers_guide/models/crop_desease.dart';
import 'package:farmers_guide/models/farm.dart';
import 'package:farmers_guide/models/weather.dart';
import 'package:farmers_guide/networking/crop_remote.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'providers.g.dart';

final expandProvider = StateProvider((ref) => false);
final selectedFarm = StateProvider<Farm?>((ref) => null);
final selectedForcast = StateProvider<Weather?>((ref) => null);
final selectedCrop = StateProvider<Crop?>((ref) => null);
final selectedImage = StateProvider<String>((ref) => '');

@Riverpod(keepAlive: true)
Future<(String?, List<Crop>?)> getCrops(GetCropsRef ref) async {
  final response = await CropRemote.fetchCrops();
  return response;
}

@Riverpod(keepAlive: true)
Future<(String?, CropAdvice?)> getCropAdvice(
    GetCropAdviceRef ref, int cropId, String date) async {
  final response = await CropRemote.fetchCropAdvice(cropId: cropId, date: date);
  return response;
}

@riverpod
Future<(String?, CropDisease?)> getCropDiseaseDiagnosis(
    GetCropDiseaseDiagnosisRef ref, int cropId, String imagePath) async {
  final response = await CropRemote.fetchCropDisease(
    cropId: cropId,
    imagePath: imagePath,
    userPrompt: 'What disease is this',
  );
  return response;
}
