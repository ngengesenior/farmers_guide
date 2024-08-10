import 'package:farmers_guide/models/weather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum WeatherCondition {
  sunny(icon: Icons.sunny),
  rainy(icon: CupertinoIcons.cloud_rain),
  thunderstorm(icon: Icons.thunderstorm),
  cloudy(icon: Icons.cloud),
  snowy(icon: Icons.ac_unit),
  unknown(icon: Icons.air);

  final IconData icon;

  const WeatherCondition({required this.icon});
}

WeatherCondition getWeatherCondition({required Weather weather}) {
  // Check for thunderstorm
  if (weather.precipitation > 20 && weather.windSpeed > 20) {
    return WeatherCondition.thunderstorm;
  }

  // Check for rainy weather
  if (weather.precipitation > 0 && weather.temperatureLow > 0) {
    return WeatherCondition.rainy;
  }

  // Check for snowy weather
  if (weather.precipitation > 0 && weather.temperatureLow <= 0) {
    return WeatherCondition.snowy;
  }

  // Check for sunny weather
  if (weather.precipitation == 0 && weather.windSpeed <= 10) {
    return WeatherCondition.sunny;
  }

  // Check for cloudy weather
  if (weather.precipitation == 0 && weather.humidity > 60) {
    return WeatherCondition.cloudy;
  }

  // Default case if no specific condition is met
  return WeatherCondition.unknown;
}
