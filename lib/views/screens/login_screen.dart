import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kavish_academy/views/screens/signup_screen.dart';

import '../../constants/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void navigateToSignUpScreen() {
    Get.to(() => SignupScreen());
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/kavish_logo.png', scale: 1.5),
              Text(
                'Welcome Back!',
                style: GoogleFonts.lato(
                  color: GlobalColors.accent2.withOpacity(0.5),
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                textEditingController: _emailController,
                onChanged: () {},
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.name,
                hintText: 'Email',
              ),
              const SizedBox(height: 20),
              CustomTextField(
                textEditingController: _passwordController,
                onChanged: () {},
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.name,
                isPassword: true,
                hintText: 'Password',
              ),
              const SizedBox(height: 20),
              CustomButton(
                onTap: () {},
                isLoading: false,
                text: 'Login!',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 1,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 7),
                    child: const Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 1,
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 7),
                      child: InkWell(
                        onTap: navigateToSignUpScreen,
                        child: const Text(
                          ' Sign Up!',
                          style: TextStyle(
                            fontSize: 18,
                            color: GlobalColors.accent1,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      )),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
