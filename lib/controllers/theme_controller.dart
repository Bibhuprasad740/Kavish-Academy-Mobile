import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/variables.dart';

class ThemeController extends GetxController {
  static ThemeController instance = Get.find();
  static Rx<ThemeData> currentTheme =
      Get.isDarkMode ? Variables.darkTheme.obs : Variables.lightTheme.obs;

  static void changeTheme() {
    Get.changeThemeMode(
      Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
    );
    currentTheme =
        Get.isDarkMode ? Variables.lightTheme.obs : Variables.darkTheme.obs;
    debugPrint(currentTheme.value == Variables.darkTheme
        ? "ThemeController: Dark Theme"
        : 'ThemeController: White theme');
  }
}
