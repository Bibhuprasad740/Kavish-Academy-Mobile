import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/variables.dart';

class ThemeController extends GetxController {
  static ThemeController instance = Get.find();
  static Rx<ThemeData> currentTheme = Variables.lightTheme.obs;

  static void changeTheme() {
    Get.changeTheme(
        Get.isDarkMode ? Variables.lightTheme : Variables.darkTheme);
    currentTheme.value = currentTheme.value == Variables.darkTheme
        ? Variables.lightTheme
        : Variables.darkTheme;
  }
}
