import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightThemeData = ThemeData(
    useMaterial3: false,
    fontFamily: GoogleFonts.openSans().fontFamily,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.green,
    primarySwatch: Colors.green,
    brightness: Brightness.light,
    inputDecorationTheme: const InputDecorationTheme(
      errorStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.red,
      ),
    ),
  );

  static final ThemeData darkThemeData = ThemeData(
    useMaterial3: false,
    fontFamily: GoogleFonts.openSans().fontFamily,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.green,
    primarySwatch: Colors.green,
    brightness: Brightness.dark,
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      errorStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.red,
      ),
    ),
  );
}
