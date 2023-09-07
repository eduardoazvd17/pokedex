import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static Color get primaryColor => Colors.red;
  static Color get backgroundColor => Colors.white;
  static Color get foregroundColor => Colors.black;

  static TextStyle get title25w600 => const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w600,
      );

  static ThemeData get lightTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          surfaceTint: backgroundColor,
        ),
        fontFamily: GoogleFonts.roboto().fontFamily,
        useMaterial3: true,
      );
}
