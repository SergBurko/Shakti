import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shakti/common/classes/dialogs.dart';
import 'package:shakti/common/classes/singleton.dart';
import 'package:shakti/common/entities/session_settings.dart';
import 'package:shakti/common/enums/login_state_enum.dart';
import 'package:shakti/common/services/auth_services.dart';

class LoginScreenEmail extends StatefulWidget {
  const LoginScreenEmail({super.key});

  @override
  State<LoginScreenEmail> createState() => _LoginScreenEmailState();
}

class _LoginScreenEmailState extends State<LoginScreenEmail> {
  bool obscureText = true;
  TextEditingController emailField = TextEditingController();
  TextEditingController passwordField = TextEditingController();
  TextEditingController passwordSecondTimeField = TextEditingController();


//       void showSnackBarMessage(BuildContext ccontext, String message) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(message),
//       duration: const Duration(seconds: 3),
//     ),
//   );
// }

  @override
  Widget build(BuildContext context) {

    SessionSettings sessionSettings = Provider.of<SessionSettings>(context);
    AuthServices authServices = AuthServices(sessionSettings);

    return 
       SizedBox(
        width: 300,
        child: Column(
          children: [
            // EMAIL
            TextField(
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                controller: emailField,
                decoration: Singleton.textFieldDecoration
                    .copyWith(hintText: Singleton.enterEmail)),
            const SizedBox(
              height: 10,
            ),

            // PASSWORD
            Stack(children: [
              TextField(
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  controller: passwordField,
                  obscureText: obscureText,
                  decoration: Singleton.textFieldDecoration
                      .copyWith(hintText: Singleton.enterPassword)),
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                child: GestureDetector(
                    child: IconButton(
                      icon: const Icon(Icons.remove_red_eye),
                      onPressed: () {},
                    ),
                    onLongPressEnd: (details) => setState(() {
                          obscureText = !obscureText;
                        }),
                    onLongPress: () => setState(() {
                          obscureText = !obscureText;
                        })),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),

            // REPEAT PASSWORD TextEdit
            Visibility(
              visible: sessionSettings.loginScreenSettings.loginState ==
                  LoginStatesEnum.registration,
              child: Stack(children: [
                TextField(
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    controller: passwordSecondTimeField,
                    obscureText: obscureText,
                    decoration: Singleton.textFieldDecoration
                        .copyWith(hintText: Singleton.repeatPassword)),
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                      child: IconButton(
                        icon: const Icon(Icons.remove_red_eye),
                        onPressed: () {},
                      ),
                      onLongPressEnd: (details) => setState(() {
                            obscureText = !obscureText;
                          }),
                      onLongPress: () => setState(() {
                            obscureText = !obscureText;
                          })),
                ),
              ]),
            ),
            const SizedBox(
              height: 10,
            ),

            // LOGIN/REGISTER Button
            ElevatedButton(
                onPressed: () async {
                  try {
                    bool isThereClientByEmail = await sessionSettings.client
                        .isThereClientByEmail(emailField.text);
                    // LOGIN
                    if (sessionSettings.loginScreenSettings.loginState ==
                        LoginStatesEnum.login) {
                      if (FirebaseAuth.instance.currentUser != null) {
                        await FirebaseAuth.instance.signOut();
                      }
                      // trying to authenticate
                      try {
                        await authServices.singByEmailAndPassword(
                            emailField.text, passwordField.text);
                      } catch (e) {
                        // print(e);
                      }

                      if (!isThereClientByEmail) {
                        // If there is no email
                        bool registerClient =
                            await Dialogs.showConfirmationDialog(
                                // making proposition to create user
                                context,
                                Singleton.registerWarning,
                                Singleton.noSuchEmailRegisterQuestion);
                        if (registerClient) {
                          sessionSettings.changeLoginState();
                        }
                      } else if (FirebaseAuth.instance.currentUser == null) {
                        await Dialogs.showMessage(context,
                            Singleton.notCorrectEnteredEmailOrPassword);
                      } else if (FirebaseAuth.instance.currentUser != null &&
                          !FirebaseAuth.instance.currentUser!.emailVerified) {
                        await Dialogs.showMessage(context,
                            Singleton.youShouldGetEmailWithActivationLink);
                      }
                      // if there is a user but not verified then he should
                      // REGISTERING
                    } else {
                      if (isThereClientByEmail) {
                        await Dialogs.showMessage(
                            context, Singleton.thisEmailAlreadyRegistered);
                        // showSnackBarMessage (context, Singleton.thisEmailAlreadyRegistered);

                      } else if (passwordField.text ==
                              passwordSecondTimeField.text &&
                          emailField.text.isNotEmpty &&
                          emailField.text.contains("@")) {
                        try {
                          await authServices.createByEmailAndPassword(
                              emailField.text, passwordField.text);
                          if (!FirebaseAuth
                              .instance.currentUser!.emailVerified) {
                            await Dialogs.showMessage(context,
                                Singleton.youShouldGetEmailWithActivationLink);

                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   SnackBar(
                            //     content: Text(Singleton
                            //         .youShouldGetEmailWithActivationLink),
                            //     duration: const Duration(seconds: 3),
                            //   ),
                            // );
                          }
                        } catch (e) {
                          // print(e);
                        }
                        // sessionSettings.client.addOrUpdateThisInDB();
                        sessionSettings.changeLoginState();
                      }
                    }
                  } catch (e) {
                    // print(e);
                  }
                },
                // Button Label
                child: AutoSizeText(
                  sessionSettings.loginScreenSettings.loginState ==
                          LoginStatesEnum.login
                      ? Singleton.login
                      : Singleton.register,
                  minFontSize: 20,
                  style: Theme.of(context).textTheme.bodyMedium,
                )),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                sessionSettings.changeLoginState();
              },
              
              child: Text(
                "${Singleton.iNeedTo} ${sessionSettings.loginScreenSettings.loginState == LoginStatesEnum.login ? Singleton.register.toString().toLowerCase() : Singleton.login.toString().toLowerCase()}",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(decoration: TextDecoration.underline, fontSize: 16),
              ),
            ),
          ],
        ),
      );
    
  }
}
