import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

String getMessage(dynamic error) {
  String errorMsg;
  int statusCode = 0;

  if (error is Exception) {
    if (error is FormatException) {
      errorMsg = "Invalid data format";
    } else {
      try {
        if (error is http.ClientException) {
          errorMsg = "Client exception: ${error.message}";
        } else {
          String responseString = error.toString();
          Map<String, dynamic>? responseMap;
          responseMap = json.decode(responseString);
          if (responseMap != null) {
            errorMsg = responseMap["detailedMessage"] ?? responseMap["title"];
            if (errorMsg.isEmpty) {
              if (error is http.ClientException) {
                errorMsg = "Request Failed on Server.\n${error.message}";
              } else if (error is TimeoutException) {
                errorMsg =
                    "Request timeout. Check your Data/Wifi Connection \nOR\n Server may be busy. Please retry after some time";
              } else if (error is http.ClientException) {
                errorMsg = "Server Login Error. Try Logout and Login again";
              } else if (error is http.ClientException) {
                errorMsg = "Network Error. Check your Data/Wifi Connection";
              } else {
                errorMsg = error.toString();
              }
            }
          } else {
            errorMsg = "Unknown Error";
          }
        }
      } catch (_) {
        errorMsg = "Unknown Error";
      }
    }
  } else {
    errorMsg = "Unknown Error";
  }

  if (kDebugMode && statusCode != 0) {
    errorMsg = "$errorMsg\nStatus Code : $statusCode";
  }

  return errorMsg;
}
