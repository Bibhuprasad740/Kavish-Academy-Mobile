import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          child: CupertinoSwitch(
            applyTheme: true,
            value: ThemeController.currentTheme.value == Variables.darkTheme,
            onChanged: (val) {
              ThemeController.changeTheme();
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}
