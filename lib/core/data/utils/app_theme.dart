import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static Color get primaryColor => Colors.red;

  static ThemeData get lightTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          surfaceTint: Colors.white,
          brightness: Brightness.light,
        ),
        fontFamily: GoogleFonts.roboto().fontFamily,
        useMaterial3: true,
      );

  static ThemeData get darkTheme => ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        surfaceTint: Colors.black,
        brightness: Brightness.dark,
      ),
      fontFamily: GoogleFonts.roboto().fontFamily,
      useMaterial3: true,
      textTheme: const TextTheme(displayLarge: TextStyle()));
}
