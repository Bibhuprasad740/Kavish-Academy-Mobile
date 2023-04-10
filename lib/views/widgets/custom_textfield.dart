import 'package:flutter/material.dart';
import 'package:kavish_academy/constants/colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool isPassword;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final VoidCallback? onSubmitted;
  const CustomTextField({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    this.isPassword = false,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.onSubmitted,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  IconData icon = Icons.visibility;
  bool isObscured = true;
  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(
        width: 0,
        color: Colors.transparent,
      ),
    );
    return TextFormField(
      textInputAction: widget.textInputAction,
      minLines: 1,
      maxLines: widget.isPassword ? 1 : 8,
      controller: widget.textEditingController,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(icon),
                onPressed: () {
                  if (icon == Icons.visibility) {
                    icon = Icons.visibility_off;
                  } else {
                    icon = Icons.visibility;
                  }
                  setState(() {
                    isObscured = !isObscured;
                  });
                },
              )
            : null,
        fillColor: GlobalColors.accent3.withOpacity(0.2),
        hintStyle: const TextStyle(color: GlobalColors.accent3),
        hintText: widget.hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
      ),
      validator: (value) {
        if (value == null || value == '') {
          return 'Please enter ${widget.hintText}';
        }
        return null;
      },
      onFieldSubmitted: (val) {
        if (widget.onSubmitted != null) {
          widget.onSubmitted!();
        }
      },
      keyboardType: widget.textInputType,
      obscureText: widget.isPassword ? isObscured : false,
    );
  }
}
