import 'dart:async';

import 'package:expence_tracker/pages/welcom_page.dart';
import 'package:flutter/material.dart';

import '../config/routes.dart';


class SplashPage extends StatefulWidget {


  const SplashPage( {super.key});

  @override
  State createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  _setupNeeds() async {

    await Future<void>.delayed(const Duration(milliseconds: 2000))
        .then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => Welcomepage(),
      ));
    });
  }

  @override
  void initState() {
    super.initState();
    _setupNeeds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Image(
                image: AssetImage("assets/images/logo.png"),
                fit: BoxFit.fill,
                height: 250,
                width: 256,
              ),
            ),


          ],
        ),

    ),);
  }


}
