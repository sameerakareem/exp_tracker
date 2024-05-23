import 'dart:convert';

import 'package:expence_tracker/pages/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../utils/Toast.dart';
import 'history_screen.dart';
import 'login/login_page.dart';

class Home extends StatefulWidget {
  Home({
    super.key,
  });

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _showExitConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Exit'),
          content: const Text('Are you sure you want to exit?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage(),
                ));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex == 0) {
          // Show exit confirmation dialog only on the Home screen
          await _showExitConfirmationDialog();
          return false;
        } else {
          // Navigate to the previous screen if not on the Home screen
          return true;
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
              ),
            ],
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1.0,
            ),
          ),
          child: getPages(_currentIndex),
        ),
        bottomNavigationBar: _currentIndex != 2
            ? NavigationBar(
                onDestinationSelected: onTabTapped,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                selectedIndex: _currentIndex,
                destinations: const <Widget>[
                  NavigationDestination(
                    selectedIcon: Icon(Icons.home, color: Colors.blue),
                    icon: Icon(Icons.home_outlined),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    selectedIcon: Icon(Icons.history_edu, color: Colors.blue),
                    icon: Icon(Icons.hide_image_outlined),
                    label: 'History',
                  ),
                ],
                height: 60,
                backgroundColor: Colors.white,
              )
            : null,
      ),
    );
  }

  Widget getPages(int currentIndex) {
    Widget page;
    if (currentIndex == 0) {
      page = HomePage();
    } else {
      page = ExpenseHistory();
    }
    return page;
  }

  Future<void> onTabTapped(int index) async {
    setState(() {
      _currentIndex = index;
    });
  }
}
