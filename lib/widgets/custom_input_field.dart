// ignore_for_file: use_super_parameters
import 'package:flutter/material.dart';


class CustomInputField extends StatelessWidget {
  final TextInputType type;
  final int? maxLength;
  final String? hintText;
  final String? text;
  final Widget? icon;
  final TextStyle fontStyle;
  final TextStyle? hintStyle;
  final bool obscureText;
  final TextEditingController? controller;
  final int? maxLines;
  final ValueChanged<String>? onChanged; // Add onChanged callback

  const CustomInputField({
    Key? key,
    required this.type,
    this.hintText,
    this.text,
    this.icon,
    this.maxLength,
    required this.fontStyle,
    this.hintStyle,
    this.obscureText = false,
    this.controller,
    this.maxLines,
    this.onChanged, // Initialize onChanged callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      maxLength: maxLength,
      maxLines: maxLines,
      style: fontStyle,
      onChanged: onChanged, // Set onChanged callback
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        prefixIcon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        filled: true,
        fillColor: const Color(0x52F0F0F0),
        counterText: '',
      ),
    );
  }
}
