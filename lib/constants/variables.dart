import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class Variables {
  static var auth = FirebaseAuth.instance;
  static var firestore = FirebaseFirestore.instance;
  static const imageScale = 6.0;

  // Theme -->
  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: GlobalColors.accent1,
    fontFamily: GoogleFonts.openSans().fontFamily,
    canvasColor: GlobalColors.darkBackgroundColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: GlobalColors.darkPrimaryColor,
      secondary: GlobalColors.accent2,
      brightness: Brightness.dark,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: GlobalColors.accent1,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: GlobalColors.darkPrimaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: GlobalColors.darkPrimaryColor),
      // toolbarTextStyle: Theme.of(context).textTheme.bodyMedium,
    ),
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: GlobalColors.selectedNavBarColor,
    ),
  );

  // light Theme
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: GlobalColors.accent2,
    primaryColor: GlobalColors.accent1,
    fontFamily: GoogleFonts.openSans().fontFamily,
    canvasColor: GlobalColors.lightBackgroundColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: GlobalColors.lightPrimaryColor,
      secondary: GlobalColors.accent4,
      brightness: Brightness.light,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: GlobalColors.accent1,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: GlobalColors.lightPrimaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: GlobalColors.lightPrimaryColor),
      // toolbarTextStyle: Theme.of(context).textTheme.bodyMedium,
    ),
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: GlobalColors.selectedNavBarColor,
    ),
  );
}
