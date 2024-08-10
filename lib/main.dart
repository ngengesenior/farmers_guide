import 'package:camera/camera.dart';
import 'package:farmers_guide/app_theme.dart';
import 'package:farmers_guide/constants/app_url.dart';
import 'package:farmers_guide/ui/camera_diagnosis_ui.dart';
import 'package:farmers_guide/ui/farm_create_ui.dart';
import 'package:farmers_guide/ui/login_ui.dart';
import 'package:farmers_guide/services/user_state.dart';
import 'package:farmers_guide/ui/signup_ui.dart';
import 'package:farmers_guide/ui/weather_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(const ProviderScope(child: MyApp()));
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
        CameraDiagnosisUi.routeName: (_) => const CameraDiagnosisUi(),
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
