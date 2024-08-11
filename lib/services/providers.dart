import 'package:farmers_guide/models/crop.dart';
import 'package:farmers_guide/models/crop_advice.dart';
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
  // await Future.delayed(const Duration(seconds: 5));
  // return (
  //   null,
  //   CropAdvice.fromJson(
  //     {
  //       "advice_type": "TEST ADVICE",
  //       "advice":
  //           "Given the moderate rain forecasted and the current stage of your mango plants, ensure adequate drainage to prevent waterlogging. Young mango trees are susceptible to root rot in overly wet conditions. Consider a light application of nitrogen-rich fertilizer after the rain to support leafy growth, but avoid over-fertilizing as it can make the plants more susceptible to pests.",
  //       "other_things_to_note":
  //           "Monitor the plants closely for any signs of pests or diseases, especially after the rain.",
  //       "duration": "Next few days",
  //       "confidence_level": 0.8
  //     },
  //   ),
  // );
}
