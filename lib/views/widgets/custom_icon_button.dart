import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/variables.dart';
import '../../controllers/theme_controller.dart';

class CustomIconButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const CustomIconButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Obx(
        () => Container(
          padding: const EdgeInsets.all(15),
          width: double.infinity,
          decoration: BoxDecoration(
            color: ThemeController.currentTheme.value == Variables.darkTheme
                ? const Color.fromARGB(255, 27, 27, 27)
                : const Color.fromARGB(255, 243, 243, 243),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
              ),
              const SizedBox(width: 10),
              Text(
                text,
                style: GoogleFonts.lato(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
