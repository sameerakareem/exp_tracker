

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


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
}

