import 'package:farmers_guide/app_theme.dart';
import 'package:farmers_guide/farm_create_ui.dart';
import 'package:farmers_guide/login_ui.dart';
import 'package:farmers_guide/services/user_state.dart';
import 'package:farmers_guide/signup_ui.dart';
import 'package:farmers_guide/weather_ui.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

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
      routes: {
        WeatherUi.routeName: (_) => const WeatherUi(),
        LoginUi.routeName: (_) => const LoginUi(),
        SignUpUi.routeName: (_) => const SignUpUi(),
        CreateFarmUI.routeName: (_) => const CreateFarmUI(),
      },
      home: FutureBuilder(
        future: userMeState.initialise(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox.square(
                dimension: 60,
                child: LoadingIndicator(
                  indicatorType: Indicator.lineScale,
                  colors: [Colors.black],
                ),
              ),
            );
          }
          final user = userMeState.value;
          if (user == null) {
            return const LoginUi();
          } else {
            if (user.farms.isEmpty) return const CreateFarmUI();
            return const WeatherUi();
          }
        },
      ),
    );
  }
}
