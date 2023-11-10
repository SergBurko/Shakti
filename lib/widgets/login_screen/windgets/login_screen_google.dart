import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shakti/common/entities/session_settings.dart';
import 'package:shakti/common/services/auth_services.dart';
import 'package:shakti/common/windgets/circular_button.dart';

class LoginScreenGoogle extends StatelessWidget {
  const LoginScreenGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    SessionSettings sessionSettings = Provider.of<SessionSettings>(context);
    AuthServices authServices = AuthServices(sessionSettings);
    return Column(
      children: [
        InkWell(
          onTap: () {
            authServices.signInWithGoogle();
          },
            child: RoundImage(imageAssetPath: "assets/images/google.png")),
        // SizedBox(height: 50, width: 50 , child: Text(FirebaseAuth.instance.currentUser!= null ? FirebaseAuth.instance.currentUser!.email! : "no user", style: TextStyle(fontSize: 10),)),
      ],
    );
  }
}
