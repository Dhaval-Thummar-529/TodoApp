import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  showSnackBar(BuildContext context, String label) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      margin: const EdgeInsets.all(8),
      content: Text(label),
      duration: const Duration(seconds: 3),
    ));
  }
}
