import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kavish_academy/constants/colors.dart';

import '../../constants/variables.dart';
import '../../controllers/theme_controller.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLoading;
  final String text;
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.isLoading,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: GlobalColors.accent1,
        ),
        child: isLoading
            ? const CircularProgressIndicator(
                color: GlobalColors.accent2,
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color:
                      ThemeController.currentTheme.value == Variables.darkTheme
                          ? GlobalColors.lightSecondaryColor
                          : GlobalColors.darkSecondaryColor,
                ),
              ),
      ),
    );
  }
}
