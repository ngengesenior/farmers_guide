import 'package:farmers_guide/services/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static bool isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  static Widget heightSpacer40 = const SizedBox(
    height: 40,
  );

  static ButtonStyle primaryButtonStyle = FilledButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)));

  static String getFormattedDate(DateTime date) {
    return date.isToday
        ? "Today"
        : date.isTomorrow
            ? "Tomorrow"
            : DateFormat("dd MMM").format(date);
  }
}
