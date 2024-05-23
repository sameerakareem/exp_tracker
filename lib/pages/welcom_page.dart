import 'package:expence_tracker/pages/registation/regisitration_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../config/routes.dart';
import 'login/login_page.dart';

void main() {
  runApp(Welcomepage());
}

class Welcomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SignUpSignInScreen(),
      ),
    );
  }
}

class SignUpSignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top illustration
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: Lottie.asset(
                        'assets/images/home.json', // Replace with the path to your Lottie animation file
                        width: 250.0,
                        height: 100.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Expense Tracker',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Text and buttons
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Best way to save your money',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50), backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    child: Text(
                      'LETS START',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white, // Set the text color

                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom:28.0),
                  //   child: TextButton(
                  //     onPressed: () {
                  //       Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (BuildContext context) => RegistrationScreen(),
                  //       ));
                  //     },
                  //     style: TextButton.styleFrom(
                  //       textStyle: const TextStyle(
                  //         color: Colors.blue, // Set the text color
                  //         fontSize: 16.0, // Set the text size
                  //       ),
                  //     ),
                  //     child: const Text(
                  //       'New User? Create an Account',
                  //     ),
                  //   ),
                  // ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
