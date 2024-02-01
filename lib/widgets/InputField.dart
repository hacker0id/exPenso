// ignore_for_file: must_be_immutable

import 'package:expenso/constants/constants.dart';
import 'package:expenso/main.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  InputField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.type,
  });

  String hintText;
  TextEditingController controller;
  TextInputType type;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: device.height * 0.075,
      child: TextField(
        keyboardType: type,
        autocorrect: false,
        style: const TextStyle(
          color: Colors.black87,
        ),
        controller: controller,
        cursorColor: Colors.black87,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.lime,
          enabledBorder: kenabledBorder,
          focusedBorder: kfocusedBorder,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black54, fontSize: 16),
        ),
      ),
    );
  }
}
