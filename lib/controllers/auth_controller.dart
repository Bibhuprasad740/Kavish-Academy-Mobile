import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kavish_academy/views/screens/bottom_bar_screen.dart';

import '../constants/variables.dart';
import '../views/screens/splash_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  Rx<File?>? pickedImage;
  late Rx<User?> _user;
  Rx<bool> isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(Variables.auth.currentUser);
    _user.bindStream(Variables.auth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const SplashScreen());
    } else {
      Get.offAll(() => const BottomBarScreen());
    }
  }

  static Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    Get.offAll(() => const BottomBarScreen());
  }

  static Future<void> logIn({
    required String email,
    required String password,
  }) async {
    Get.offAll(() => const BottomBarScreen());
  }
}
