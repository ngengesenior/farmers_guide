import 'package:camera/camera.dart';
import 'package:farmers_guide/app_theme.dart';
import 'package:farmers_guide/constants/app_url.dart';
import 'package:farmers_guide/ui/camera_diagnosis_ui.dart';
import 'package:farmers_guide/ui/crop_create_ui.dart';
import 'package:farmers_guide/ui/crop_disease_diagnosis_ui.dart';
import 'package:farmers_guide/ui/farm_create_ui.dart';
import 'package:farmers_guide/ui/login_ui.dart';
import 'package:farmers_guide/services/user_state.dart';
import 'package:farmers_guide/ui/signup_ui.dart';
import 'package:farmers_guide/ui/user_account.dart';
import 'package:farmers_guide/ui/weather_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:flutter/foundation.dart';
// core FlutterFire dependency
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// FlutterFire's Firebase Cloud Messaging plugin
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (kDebugMode) {
    print('Permission granted: ${settings.authorizationStatus}');
  }

  String? token = await messaging.getToken();

  if (kDebugMode) {
    print('Registration Token=$token');
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      print('Handling a foreground message: ${message.messageId}');
      print('Message data: ${message.data}');
      print('Message notification: ${message.notification?.title}');
      print('Message notification: ${message.notification?.body}');
    }

    //  _messageStreamController.sink.add(message);
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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
        CropCreateUi.routeName: (_) => const CropCreateUi(),
        CropDiseaseDiagnosisUi.routeName: (_) => const CropDiseaseDiagnosisUi(),
        UserAccountUi.routeName: (_) => const UserAccountUi()
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
