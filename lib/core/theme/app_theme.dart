import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color orange = Color(0xffff691f);
  static const Color orange2 = Color.fromARGB(255, 255, 195, 31);
  static const Color backgroundColor = Color.fromARGB(255, 255, 250, 248);
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  static ThemeData appThemeData() => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: backgroundColor,
        textTheme: TextTheme(
          titleLarge: GoogleFonts.poppins(
              fontSize: 20, color: Colors.black87, fontWeight: FontWeight.w600),
          titleMedium: GoogleFonts.poppins(
              fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w500),
          bodyLarge: GoogleFonts.poppins(
            fontSize: 20,
            color: Colors.black54,
          ),
          bodyMedium: GoogleFonts.poppins(
            fontSize: 18,
            color: Colors.black54,
          ),
          bodySmall: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: orange,
          titleTextStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: const IconThemeData(color: white),
        ),
      );
}
