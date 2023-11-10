import 'package:flutter/material.dart';
import 'package:shakti/widgets/login_screen/windgets/login_screen_email.dart';
import 'package:shakti/common/classes/singleton.dart';
import 'package:shakti/widgets/login_screen/windgets/login_screen_google.dart';
import 'package:shakti/widgets/login_screen/windgets/login_screen_phone.dart';

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
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LoginScreenEmail(),
              const SizedBox(height: 50),
              Text(Singleton.or),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 85, width: 85, child: LoginScreenGoogle()),
                  SizedBox(
                    width: 100,
                  ),
                  SizedBox(height: 85, width: 85, child: LoginScreenPhone()),
                ],
              )
            ],
          )),
    );
  }
}
