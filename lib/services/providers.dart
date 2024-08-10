import 'package:farmers_guide/models/weather.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final expandProvider = StateProvider((ref) => false);
final selectedForcast = StateProvider<Weather?>((ref) => null);
