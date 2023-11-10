import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shakti/common/classes/singleton.dart';

class Dialogs {
  
  static showConfirmationDialog(BuildContext context, String title, String question) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Center(child: Text(title, style: Theme.of(context).textTheme.displayMedium,)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(question),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(Singleton.yes, style: Theme.of(context).textTheme.displayMedium,),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: Text(Singleton.no, style: Theme.of(context).textTheme.displayMedium,),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }

  static showMessage(BuildContext context, String message) {
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
                    message,
                    textAlign: TextAlign.center,
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
