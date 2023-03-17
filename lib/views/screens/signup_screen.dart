import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kavish_academy/constants/colors.dart';
import 'package:kavish_academy/views/widgets/custom_button.dart';
import 'package:kavish_academy/views/widgets/custom_textfield.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void navigateToLoginScreen() {
    Get.back();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                'Create an account',
                style: GoogleFonts.lato(
                  color: GlobalColors.accent2.withOpacity(0.5),
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                textEditingController: _nameController,
                onChanged: () {},
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.name,
                hintText: 'Name',
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
              CustomTextField(
                textEditingController: _confirmPasswordController,
                onChanged: () {},
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.name,
                isPassword: true,
                hintText: 'Password',
              ),
              const SizedBox(height: 20),
              CustomButton(
                onTap: () {},
                isLoading: false,
                text: 'Get Started!',
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
                      'Already have an account?',
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
                        onTap: navigateToLoginScreen,
                        child: const Text(
                          ' Login',
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
