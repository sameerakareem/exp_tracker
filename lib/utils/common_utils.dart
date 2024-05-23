import 'package:flutter/foundation.dart';
// import 'package:intl/intl.dart';
//
// DateFormat defaultDateFormat = DateFormat('dd-MM-yyyy');

/// convert string to a double
double convertStringToDouble(String string) {
  double? value = double.tryParse(string);
  return value ?? 0;
}

/// convert to double
double toDouble(double? value,[double defaultValue = 0]) {
  return value ?? defaultValue;
}

/// convert to int
int toInt(int? value,[int defaultValue = 0]) {
  return value ?? defaultValue;
}

/// convert to bool
bool toBool(bool? value,[bool defaultValue = false]) {
  return value ?? defaultValue;
}

/// convert to String
String toString(String? value,[String defaultValue = '']) {
  return value ?? defaultValue;
}

// /// format double to indian currency
// String formatAmount(double amount, [String symbol = '₹']) {
//   final currencyFormat =
//       NumberFormat.currency(locale: "en_IN", symbol: symbol, decimalDigits: 2);
//   return currencyFormat.format(amount);
// }
//
// String getFormattedDate(DateTime dateTime) {
//   String formattedDate = defaultDateFormat.format(dateTime);
//   return formattedDate;
// }

void printLog(Object? message) {
  if (kDebugMode) {
    print(message);
  }
}
