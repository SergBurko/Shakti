import 'package:flutter/material.dart';
import 'package:shakti/widgets/login_screen/windgets/login_screen_email.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          // color: Theme.of(context).primaryColor,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LoginScreenEmail(),
            ],
          )),
    );
  }
}
