import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kavish_academy/constants/colors.dart';
import 'package:kavish_academy/controllers/auth_controller.dart';
import 'package:kavish_academy/views/screens/bottom_bar_screen.dart';
import 'package:kavish_academy/views/widgets/custom_button.dart';
import 'package:kavish_academy/views/widgets/custom_textfield.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/variables.dart';
import '../../controllers/theme_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

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

  void signUpUser() async {
    setState(() {});
    if (_passwordController.text.isNotEmpty &&
        _passwordController.text.trim() ==
            _confirmPasswordController.text.trim()) {
      await AuthController.instance.signUp(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        context: context,
      );
    } else {
      Get.snackbar('Please enter password!',
          'Password should be at least 6 characters long.');
    }
    setState(() {});
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
      body: Obx(
        () => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CupertinoSwitch(
                    applyTheme: true,
                    value: ThemeController.currentTheme.value ==
                        Variables.darkTheme,
                    onChanged: (val) => ThemeController.changeTheme(),
                  ),
                ],
              ),
              Image.asset(
                ThemeController.currentTheme.value == Variables.darkTheme
                    ? 'assets/images/dark_kavish_logo.png'
                    : 'assets/images/light_kavish_logo.png',
                scale: Variables.imageScale,
                color: GlobalColors.accent1,
              ),
              const Spacer(),
              Text(
                'Create an account',
                style: GoogleFonts.lato(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                textEditingController: _nameController,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.name,
                hintText: 'Name',
              ),
              const SizedBox(height: 20),
              CustomTextField(
                textEditingController: _emailController,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.name,
                hintText: 'Email',
              ),
              const SizedBox(height: 20),
              CustomTextField(
                textEditingController: _passwordController,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.name,
                isPassword: true,
                hintText: 'Password',
              ),
              const SizedBox(height: 20),
              CustomTextField(
                textEditingController: _confirmPasswordController,
                onSubmitted: signUpUser,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.name,
                isPassword: true,
                hintText: 'Password',
              ),
              const SizedBox(height: 20),
              CustomButton(
                isLoading: AuthController.instance.isLoading.value,
                onTap: signUpUser,
                text: 'Get Started!',
              ),
              const Spacer(flex: 10),
              InkWell(
                onTap: navigateToLoginScreen,
                child: Row(
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
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 1,
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 7),
                      child: const Text(
                        ' Login',
                        style: TextStyle(
                          color: GlobalColors.accent1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
