import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppThemes {
  static Color get primaryColor => Colors.red;
  static Color get backgroundColor => Colors.white;
  static Color get foregroundColor => Colors.black;

  static TextStyle get menuNormalTextStyle => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get menuSelectedTextStyle => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        color: primaryColor,
      );

  static TextStyle get bodySmallTextStyle => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get headerSmallTextStyle => const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get headerTextStyle => const TextStyle(
        fontSize: 32,
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
