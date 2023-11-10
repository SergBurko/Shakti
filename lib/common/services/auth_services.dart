import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shakti/common/classes/singleton.dart';
import 'package:shakti/common/entities/session_settings.dart';

class AuthServices extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  late GoogleSignInAccount? _googleSignInAccount;
  final SessionSettings sessionSettings;

  AuthServices(this.sessionSettings);

  isAutorized() async {
    return await GoogleSignIn(scopes: ['email']).isSignedIn();
  }

  // setCurrentUserByFirebaseUser (User? user){
  //   currentUser = CurrentUser.byFireBaseUserCredential(signInWithGoogle());
  //   notifyListeners();
  // }

  signInWithGoogle() async {
    try {
      var a = FirebaseAuth.instance;
      _googleSignInAccount = await _googleSignIn.signIn();



      GoogleSignInAuthentication? googleAuth =
          await _googleSignInAccount?.authentication;

      AuthCredential authCredentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      // UserCredential userCredential =
      UserCredential userCredential =  await FirebaseAuth.instance.signInWithCredential(authCredentials);

      User? user = userCredential.user;

      if (user != null && user.uid.isNotEmpty) {

        // List<UserInfo> providerData = user.providerData;

        // for (UserInfo userInfo in providerData) {
        //   print('Provider ID: ${userInfo.providerId}');
        //   // google.com - gmail
        //   // password - email  
        //   //        
        // }

        sessionSettings.getClientByFirebaseUserId(user.uid);
        if (sessionSettings.client.id.trim().isEmpty){
          sessionSettings.client.id = user.uid;
          sessionSettings.client.email = user.email!;
          sessionSettings.clientAddOrUpdateThisInDB();
        }
      }
      // return userCredential;
    } catch (e) {
      print("ERROR: $e");
    }
  }

  singByEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user != null && user.uid.isNotEmpty) {
        sessionSettings.getClientByFirebaseUserId(user.uid);
      }
      
    } catch (e) {
      print(e);
    }
  }

  createByEmailAndPassword( String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      user!.sendEmailVerification();

      if (user.uid.isNotEmpty) {
        sessionSettings.client.id = user.uid;
        sessionSettings.client.email = user.email!;

        sessionSettings.clientAddOrUpdateThisInDB();
      }
      FirebaseAuth.instance.signOut();
    } catch (e) {
      String errorMessage = "";

      if (e == FirebaseAuthException(code: "invalid-email")) {
        errorMessage = Singleton.thisEmailDoesntExist;
      } else if (e == FirebaseAuthException(code: "weak-password")) {
        errorMessage = Singleton.tooWeakPassword;
      } else {
        errorMessage = e.toString();
      }
      print(errorMessage);
    }
  }

  // signInAsAnonymous() async {
  //   UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
  //   return userCredential;
  // }

  // clearCurrentUser (){
  //   currentUser = CurrentUser();
  //   notifyListeners();
  // }

  signOutFromGoogle() async {
    try {
      // _googleSignInAccount = await _googleSignIn.signOut();
      await _googleSignInAccount!.clearAuthCache();
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
    } catch (error) {
      print('Error: $error');
    }
  }
}
