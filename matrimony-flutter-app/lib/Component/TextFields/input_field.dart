import 'package:bright_weddings/Helper/colors.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final Widget? suffixIcon;
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  InputField({super.key, required this.labelText, required this.controller, required this.keyboardType, this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(
            color: borderColor,
            style: BorderStyle.solid
          )
        )
      ),
    );
  }
}
