import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("start_screen"),
          ElevatedButton(onPressed:() => FirebaseAuth.instance.signOut(), child: Text("SignOut"))
        ],
      )),
    );
  }
}
