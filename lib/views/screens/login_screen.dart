import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kavish_academy/constants/variables.dart';
import 'package:kavish_academy/controllers/theme_controller.dart';
import 'package:kavish_academy/views/screens/signup_screen.dart';
import 'package:kavish_academy/views/widgets/custom_icon_button.dart';

import '../../constants/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // ThemeController themeController = ThemeController();
  void navigateToSignUpScreen() {
    Get.to(() => const SignupScreen());
  }

  void loginUser() {
    Get.offAll(() => const HomeScreen());
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) => Scaffold(
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
                scale: 2,
              ),
              const SizedBox(height: 20),
              Text(
                'Welcome Back!',
                style: GoogleFonts.lato(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  fontSize: 25,
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
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot password ? ',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: GlobalColors.accent1,
                    ),
                  )
                ],
              ),
              CustomButton(
                onTap: loginUser,
                isLoading: false,
                text: 'Login!',
              ),
              const SizedBox(height: 20),
              CustomIconButton(
                onTap: () {},
                color: Colors.red,
                text: 'Sign in with Google',
                icon: FontAwesomeIcons.google,
              ),
              const SizedBox(height: 20),
              CustomIconButton(
                onTap: () {},
                color: Colors.blue,
                text: 'Sign in with Facebook',
                icon: FontAwesomeIcons.facebook,
              ),
              const SizedBox(height: 20),
              const Spacer(),
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
                          color: GlobalColors.accent1,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
