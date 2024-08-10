// ignore_for_file: unused_element

import 'package:http/http.dart' as http;

extension on http.Response {
  bool get isSuccessful => (statusCode >= 200 && statusCode <= 299);
  bool get isClientError => (statusCode >= 400 && statusCode <= 499);
  bool get isServerError => (statusCode >= 500 && statusCode <= 599);
  bool get isFailure => isClientError || isServerError;
}

extension DateHelpers on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }

  bool get isTomorrow {
    final yesterday = DateTime.now().add(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }
}
