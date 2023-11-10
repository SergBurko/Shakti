import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Singleton {
  static ThemeData themeData = ThemeData(
    textTheme: TextTheme(
      displayMedium: GoogleFonts.dancingScript(fontSize: 30),
      bodyMedium: GoogleFonts.pacifico(fontSize: 30),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all(const Color.fromARGB(255, 244, 197, 105)),
    )),
    dividerColor: const Color.fromARGB(255, 66, 7, 20),
    primaryColor: const Color.fromARGB(255, 255, 221, 157),
    cardColor: const Color.fromARGB(255, 247, 205, 120),
    shadowColor: const Color.fromARGB(255, 238, 209, 155),
    highlightColor: const Color.fromARGB(255, 254, 99, 33),
    // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
  );

  static InputDecoration textFieldDecoration = InputDecoration(
    border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30))),
    filled: true,
    fillColor: Singleton.themeData.shadowColor,
    contentPadding: const EdgeInsets.symmetric(vertical: 10),
    enabledBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: Singleton.themeData.dividerColor, width: 1.0),
      borderRadius: const BorderRadius.all(Radius.circular(30)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: Singleton.themeData.dividerColor, width: 2.0),
      borderRadius: const BorderRadius.all(Radius.circular(30)),
    ),
    hintStyle: Singleton.themeData.textTheme.displayMedium,
  );

  static String loadingTXT = "loading";
  static String noInternetConnectionText = "Keine Internetverbindung!";
  static String connectionError = "Connection Error!";
  static String noAccesToDocumentDirectory = "No access to Documents directory";
  static String fileNotFound = "File not found!";
  static String login = "Login";
  static String register = "Register";
  static String enterEmail = "Email";
  static String enterPassword = "Password";
  static String repeatPassword = "Repeat password";
  static String registerWarning = "Wow!";
  static String noSuchEmailRegisterQuestion =
      "No client with such email.\nMaybe you want to create new one?";
  static String wrongPassword = "Wrong password :(";
  static String yes = "Yes";
  static String no = "No";
  static String thisEmailDoesntExist = "This Email doesn't exist!";
  static String youShouldGetEmailWithActivationLink = "Check you email for letter with activation link!";
  static String tooWeakPassword = "You should set more strong password";
  static String notCorrectEnteredEmailOrPassword = "Not correnct entered email or password";
  static String thisEmailAlreadyRegistered = "This email already registered!";
  static String or = "or";
  static String iNeedTo = "I need to";
}
