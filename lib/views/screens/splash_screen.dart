import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kavish_academy/constants/variables.dart';
import 'package:kavish_academy/controllers/auth_controller.dart';
import 'package:kavish_academy/views/screens/bottom_bar_screen.dart';
import 'package:kavish_academy/views/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _controller.forward();
    _controller.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          Get.off(
            () => Variables.auth.currentUser == null
                ? const LoginScreen()
                : const BottomBarScreen(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          Get.isDarkMode
              ? 'assets/images/dark_kavish_logo.png'
              : 'assets/images/light_kavish_logo.png',
          scale: Variables.imageScale,
        ),
      ),
    );
  }
}
