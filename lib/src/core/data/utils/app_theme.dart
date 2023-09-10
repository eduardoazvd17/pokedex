import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Colors.red;
  static ThemeData get lightTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          surfaceTint: Colors.white,
          brightness: Brightness.light,
        ),
        fontFamily: !kIsWeb && Platform.isMacOS
            ? null
            : GoogleFonts.roboto().fontFamily,
        useMaterial3: true,
      );
}
