import 'package:flutter/material.dart';
import 'package:shakti/common/windgets/circular_button.dart';

class LoginScreenPhone extends StatefulWidget {
  const LoginScreenPhone({super.key});

  @override
  State<LoginScreenPhone> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LoginScreenPhone> {
  @override
  Widget build(BuildContext context) {
    return RoundImage(imageAssetPath: "assets/images/phone.png");
  }
}