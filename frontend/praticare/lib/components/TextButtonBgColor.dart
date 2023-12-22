// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:praticare/theme/theme.dart' as theme;

class TextButtonBgColor extends StatelessWidget {
  Color? backgroundColor;
  String text;
  VoidCallback? onPressed;
  EdgeInsetsGeometry? padding;
  TextButtonBgColor(
      {super.key,
      required this.text,
      this.backgroundColor,
      this.onPressed,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 20),
      child: TextButton(
        style: TextButton.styleFrom(
          fixedSize: const Size(200, 50),
          backgroundColor: backgroundColor ?? theme.violetText,
        ),
        onPressed: onPressed ?? () => debugPrint(text),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 2,
            horizontal: 35,
          ),
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
