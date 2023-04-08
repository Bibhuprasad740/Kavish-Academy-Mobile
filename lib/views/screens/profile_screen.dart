import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kavish_academy/controllers/auth_controller.dart';

import '../../constants/variables.dart';
import '../../controllers/theme_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CupertinoSwitch(
                applyTheme: true,
                value:
                    ThemeController.currentTheme.value == Variables.darkTheme,
                onChanged: (val) {
                  ThemeController.changeTheme();
                  setState(() {});
                },
              ),
              TextButton(
                onPressed: AuthController.instance.signOut,
                child: const Text('Sign out'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
