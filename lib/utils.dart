import 'package:flutter/material.dart';

class Utils {
  static bool isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  static Widget heightSpacer40 = const SizedBox(
    height: 40,
  );

  static ButtonStyle primaryButtonStyle = FilledButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)));
}
