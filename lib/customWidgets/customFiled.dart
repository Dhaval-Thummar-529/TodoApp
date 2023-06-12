import 'package:flutter/material.dart';

class CustomImputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String label;
  final TextInputAction textInputAction;
  final int maxLines;

  const CustomImputField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.label,
    required this.textInputAction,
    required this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: textInputAction,
      maxLines: maxLines,
      style: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        alignLabelWithHint: true,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w400,
        ),
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
