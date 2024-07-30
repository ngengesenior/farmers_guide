import 'package:farmers_guide/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginUi extends StatefulWidget {
  const LoginUi({super.key});

  @override
  State<LoginUi> createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

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
        child: Container(
          padding: EdgeInsets.all(deviceSize.width * 0.06),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  width: deviceSize.width,
                  child: Text(
                    "Welcome back.\nGlad to see you, again",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.outfit(
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.w600)),
                  ),
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
                SizedBox(
                  width: deviceSize.width,
                  child: const Text(
                    "Forgot password?",
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: deviceSize.width * 0.65,
                  child: FilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Attempt logging in
                        }
                      },
                      child: const Text(
                        "Log In",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
                const Spacer(),
                const Text("Don't have an account? Sign-up"),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
