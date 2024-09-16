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
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Farmers Guide',
      theme: appTheme,
      routes: {
        WeatherUi.routeName: (_) => const WeatherUi(),
        LoginUi.routeName: (_) => const LoginUi(),
        SignUpUi.routeName: (_) => const SignUpUi(),
        CreateFarmUI.routeName: (_) => const CreateFarmUI(),
        CameraDiagnosisUi.routeName: (_) => const CameraDiagnosisUi(),
        CropCreateUi.routeName: (_) => const CropCreateUi(),
        CropDiseaseDiagnosisUi.routeName: (_) => const CropDiseaseDiagnosisUi(),
        UserAccountUi.routeName: (_) => const UserAccountUi(),
      },
      home: const OnboardingOrHome(),
    );
  }
}

// Widget that decides whether to show onboarding or home
class OnboardingOrHome extends StatefulWidget {
  const OnboardingOrHome({super.key});

  @override
  _OnboardingOrHomeState createState() => _OnboardingOrHomeState();
}

class _OnboardingOrHomeState extends State<OnboardingOrHome> {
  bool _seenOnboarding = false;

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  // Check if onboarding has been seen
  Future<void> _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

    setState(() {
      _seenOnboarding = seenOnboarding;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_seenOnboarding) {
      return const OnboardingScreen(); // Show onboarding if not seen
    }

    return FutureBuilder(
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
    );
  }
}

// Onboarding Screen
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Crops Disease detection",
          body:
              "Upload photos of your crops and get instant AI-driven disease detection and treatment advice.",
          image: buildImage('assets/logos/logo.png'),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: "Farm Weather Forecast",
          body:
              "Receive accurate, localized weather forecasts and alerts to plan your farming activities.",
          image: buildImage('assets/weather.png'),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: "Soil Health Analysis",
          body:
              "Analyze soil health through images and get actionable recommendations for improvement.",
          image: buildImage('assets/logos/logo-gray.png'),
          decoration: getPageDecoration(),
        ),
      ],
      onDone: () =>
          _onOnboardingComplete(context), // Handles "Done" button press
      onSkip: () =>
          _onOnboardingComplete(context), // Handles "Skip" button press
      showSkipButton: true, // Display the Skip button
      skip: const Text("Skip"), // Skip button label
      next: const Icon(Icons.arrow_forward), // Next button icon
      done: const Text("Done",
          style: TextStyle(fontWeight: FontWeight.w600)), // Done button label
      dotsDecorator: getDotsDecorator(), // Controls dots indicator appearance
      showNextButton: true, // Ensures Next button is visible
      showDoneButton: true, // Ensures Done button is visible on the last page
    );
  }

  void _onOnboardingComplete(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (_) => const OnboardingOrHome()), // Go to main screen
    );
  }

  Widget buildImage(String path) {
    return Center(
      child: Image.asset(path, width: 350),
    );
  }

  PageDecoration getPageDecoration() {
    return const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      bodyTextStyle: TextStyle(fontSize: 20),
      imagePadding: EdgeInsets.all(24),
      pageColor: Colors.white,
    );
  }

  DotsDecorator getDotsDecorator() {
    return DotsDecorator(
      size: const Size(10.0, 10.0),
      color: Colors.grey,
      activeSize: const Size(22.0, 10.0),
      activeColor: Colors.deepPurple,
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
    );
  }
}
