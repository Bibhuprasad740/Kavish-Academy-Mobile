import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kavish_academy/controllers/auth_controller.dart';
import 'package:kavish_academy/controllers/firebase_storage_controller.dart';

import '../controllers/map_controller.dart';
import '../controllers/theme_controller.dart';
import 'colors.dart';

class Variables {
  // firebase -->
  static var auth = FirebaseAuth.instance;
  static var firestore = FirebaseFirestore.instance;
  static var firebaseDatabase = FirebaseDatabase.instance;

  // google map -->
  static const imageScale = 6.0;
  static const googleMapApiKey = "AIzaSyABvcmeTugkWECyaqcgbyGJWwJeHNAgu0Q";
  static const initialCam = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 18,
  );
  static var defaultLocation = Position(
    longitude: 83.8832783,
    latitude: 21.4845933,
    timestamp: DateTime.now(),
    accuracy: 5,
    altitude: 12,
    heading: 12,
    speed: 12,
    speedAccuracy: 12,
  );

  // controllers -->
  static AuthController authController = AuthController.instance;
  static FirebaseStorageController fbsController =
      FirebaseStorageController.instance;
  static MapController mapController = MapController.instance;
  static ThemeController themeController = ThemeController.instance;

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
