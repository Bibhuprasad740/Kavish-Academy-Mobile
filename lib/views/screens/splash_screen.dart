import 'package:flutter/material.dart';
import 'package:kavish_academy/constants/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/kavish_logo.png',
          scale: 1.5,
        ),
      ),
    );
  }
}
