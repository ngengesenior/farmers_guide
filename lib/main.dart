import 'package:farmers_guide/app_theme.dart';
import 'package:farmers_guide/farm_create_ui.dart';
import 'package:farmers_guide/signup_ui.dart';
import 'package:farmers_guide/weather_ui.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: appTheme,
      home: const SignUpUi(),
    );
  }
}
