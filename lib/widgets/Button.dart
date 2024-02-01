// ignore_for_file: must_be_immutable

import 'package:expenso/main.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      required this.height,
      required this.width,
      required this.color,
      required this.bgColor});
  String buttonText;
  VoidCallback onPressed;
  double height;
  double width;
  Color color;
  Color bgColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: device.height * height,
      width: device.width * width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 15, color: color),
        ),
      ),
    );
  }
}
