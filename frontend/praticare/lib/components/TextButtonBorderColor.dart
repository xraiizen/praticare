// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:praticare/theme/theme.dart' as theme;

class TextButtonBorderColor extends StatelessWidget {
  String text;
  Color? borderColor;
  VoidCallback? onPressed;
  TextButtonBorderColor({
    super.key,
    required this.text,
    this.borderColor,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          fixedSize: const Size(220, 50),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
              side: BorderSide(color: borderColor ?? theme.violetText))),
      onPressed: onPressed ?? () => debugPrint(text),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 35,
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 18,
              color: theme.violetText,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
