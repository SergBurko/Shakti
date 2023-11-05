import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shakti/common/singleton.dart';

class Dialogs {

  static noInternetConnection(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: const Text(''),
            content: SizedBox(
              height: 200,
              width: 300,
              child: SingleChildScrollView(
                child: Center(
                  child: AutoSizeText(
                    Singleton.noInternetConnectionText,
                    minFontSize: 30,
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          );
        });
  }

  static connectionError(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: const Text(''),
            content: SizedBox(
              height: 200,
              width: 300,
              child: SingleChildScrollView(
                child: Center(
                  child: AutoSizeText(
                    Singleton.connectionError,
                    minFontSize: 30,
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          );
        });
  }

}