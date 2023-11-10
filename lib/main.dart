import 'package:connectivity/connectivity.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'package:firebase_app_check/firebase_app_check.dart';

import 'package:provider/provider.dart';
import 'package:shakti/common/classes/dialogs.dart';
import 'package:shakti/common/classes/singleton.dart';
import 'package:shakti/common/entities/session_settings.dart';
import 'package:shakti/widgets/login_screen/login_screen.dart';
import 'package:shakti/widgets/start_screen/start_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance
      .activate(
        // webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
        androidProvider: AndroidProvider.playIntegrity
        // appleProvider: AppleProvider.appAttest,
        );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SessionSettings>(
          create: (context) => SessionSettings(),
        ),
        // Другие провайдеры, если необходимо
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shakti',
      theme: Singleton.themeData,
      home: const MyHomePage(),
      builder: EasyLoading.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return FutureBuilder(
        future: _checkConnectivity(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SpinKitSpinningLines(
              color: Theme.of(context).dividerColor,
            );
          } else if (snapshot.hasError) {
            return Dialogs.showMessage(context, Singleton.connectionError);
          } else {
            return _buildContent(context, snapshot.data);
          }
        },
      );
    });
  }

  Widget _buildContent(BuildContext context, bool? isConnected) {
    if (isConnected == null || !isConnected) {
      return Dialogs.showMessage(context, Singleton.noInternetConnectionText);
    }

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Dialogs.showMessage(context, Singleton.connectionError);
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SpinKitSpinningLines(
            color: Theme.of(context).dividerColor,
          );
        }
        if (snapshot.data != null && snapshot.data!.emailVerified) {
          _navigateToScreen(context, const StartScreen());
        } else {
          _navigateToScreen(context, const LoginScreen());
        }
        return Container(); // Заглушка, так как _navigateToScreen осуществляет навигацию
      },
    );
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
    });
  }

  Future<bool> _checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
