import 'package:flutter/cupertino.dart';

class Utils {
  static bool isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  static Widget heightSpacer40 = const SizedBox(
    height: 40,
  );
}
