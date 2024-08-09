import 'package:farmers_guide/alerts.dart';
import 'package:farmers_guide/components.dart';
import 'package:farmers_guide/models/login_request.dart';
import 'package:farmers_guide/networking/networking.dart';
import 'package:farmers_guide/signup_ui.dart';
import 'package:farmers_guide/utils.dart';
import 'package:farmers_guide/weather_ui.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoginUi extends StatefulWidget {
  const LoginUi({super.key});
  static const routeName = '/signin';
  @override
  State<LoginUi> createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  bool showErrors = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: LoaderOverlay(
          useDefaultLoading: false,
          overlayColor: Colors.white.withOpacity(0.6),
          overlayWidgetBuilder: (_) {
            return const Center(
              child: SizedBox.square(
                dimension: 60,
                child: LoadingIndicator(
                  indicatorType: Indicator.lineScale,
                  colors: [Colors.black],
                ),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(deviceSize.width * 0.06),
            child: Form(
              key: _formKey,
              autovalidateMode: showErrors ? AutovalidateMode.always : null,
              child: Column(
                children: [
                  SizedBox(
                    width: deviceSize.width,
                    child: const BigTitleText(
                        text: "Welcome back.\nGlad to see you, again"),
                  ),
                  Utils.heightSpacer40,
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: "Email"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!Utils.isValidEmail(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                        labelText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(_isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off_outlined),
                          onPressed: _toggleVisibility,
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // SizedBox(
                  //   width: deviceSize.width,
                  //   child: const Text(
                  //     "Forgot password?",
                  //     textAlign: TextAlign.end,
                  //   ),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: deviceSize.width * 0.65,
                      child: PrimaryButton(
                        onPressed: () async {
                          final email = _emailController.text;
                          final password = _passwordController.text;
                          if (email.isEmpty || password.isEmpty) {
                            setState(() {
                              showErrors = true;
                            });
                            return;
                          }
                          final String? error;
                          final String success;
                          context.loaderOverlay.show();
                          (error, success) = await Networking.loginUser(
                            LoginRequest(
                              username: email,
                              password: password,
                            ),
                          );
                          context.loaderOverlay.hide();
                          if (error != null) {
                            MyAlert.showWarning(context, error);
                          } else {
                            MyAlert.showSuccess(context, success);
                            Navigator.pushReplacementNamed(
                                context, WeatherUi.routeName);
                          }
                        },
                        labelText: "Log In",
                      )),
                  const Spacer(),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, SignUpUi.routeName);
                      },
                      child: const Text("Don't have an account? Sign-up")),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
