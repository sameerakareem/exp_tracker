import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class AppController {


  static void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            MaterialButton(
                elevation: 5,
                color: Colors.blueGrey,
                onPressed: () async {
                  Navigator.of(context).pop(); // Close the dialog
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: const Text("Ok",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          ],
        );
      },
    );
  }



  ///  saveIBRRegistrationID
  static Future<void> saveIBRRegistrationID(int IBRRegistrationID) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('IBRRegistrationID', IBRRegistrationID ?? 0);
  }

 /// getIBRRegistrationID
  static Future<int> getIBRRegistrationID() async {
    final prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt('IBRRegistrationID');
    return id ?? 0;
  }

  /// saveIBRRegistrationPhone
  static Future<void> saveIBRRegistrationPhone(String phone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('IBRRegistrationPhone', phone );
  }

  /// getIBRRegistrationPhone
  static Future<String> getIBRRegistrationPhone() async {
    final prefs = await SharedPreferences.getInstance();
    final String? id = prefs.getString('IBRRegistrationPhone');
    return id ?? ""; // Return an empty string if id is null
  }

  /// saveUserBpId
  static Future<void> saveUserBpId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userBpId', userId ?? 0);
  }

  ///  getuserBpId
  static Future<int> getuserBpId() async {
    final prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt('userBpId');
    return id ?? 0;
  }

  ///  saveUserId
  static Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId ?? 0);
  }

  /// getuserId
  static Future<int> getuserId() async {
    final prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt('userId');
    return id ?? 0;
  }

  /// saveIsLogged
  static Future<void> saveIsLogged(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogged', value);
  }

  /// getisLogged
  static Future<bool> getisLogged() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLogged = prefs.getBool('isLogged') ?? false;
    return isLogged;
  }
}

