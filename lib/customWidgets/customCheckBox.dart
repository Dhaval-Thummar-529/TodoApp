import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {

  final ValueChanged<bool?> onChange;

  const CustomCheckBox({super.key, required this.onChange});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBox();
}

class _CustomCheckBox extends State<CustomCheckBox> {

  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(value: checkBoxValue, onChanged: (val) {
      setState(() {
        checkBoxValue = val!;
        widget.onChange(checkBoxValue);
      });
    },activeColor: Colors.blue,);
  }

}