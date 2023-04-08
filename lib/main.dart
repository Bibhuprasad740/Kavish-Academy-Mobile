import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kavish_academy/constants/variables.dart';
import 'package:kavish_academy/initial_bindings.dart';
import 'package:kavish_academy/views/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      title: 'Kavish Academy',
      theme: Variables.lightTheme,
      darkTheme: Variables.darkTheme,
      home: const SplashScreen(),
    );
  }
}
