import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
  });

  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText),
      controller: controller,
      obscureText: isObscureText,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "$hintText is required";
        }
        return null;
      },
    );
  }
}
