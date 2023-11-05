import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Singleton {
  static String loadingTXT = "loading";
  static String noInternetConnectionText = "Keine Internetverbindung!";
  static String connectionError = "Connection Error!";


  static ThemeData themeData = ThemeData(
        textTheme: TextTheme(
          displayMedium: GoogleFonts.pacifico(fontSize: 30),
          bodyMedium: GoogleFonts.dancingScript(fontSize: 30),
        ),
        dividerColor: const Color.fromARGB(255, 53, 6, 16),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      );
}