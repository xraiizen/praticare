// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:praticare/theme/theme.dart' as theme;

class TextButtonBgColor extends StatelessWidget {
  Color? backgroundColor;
  String text;
  double? fontSize;
  VoidCallback? onPressed;
  EdgeInsetsGeometry? padding;
  Size? size;
  EdgeInsetsGeometry? margin;

  TextButtonBgColor(
      {super.key,
      required this.text,
      this.fontSize,
      this.backgroundColor,
      this.size,
      this.margin,
      this.onPressed,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 20),
      child: TextButton(
        style: TextButton.styleFrom(
          fixedSize: size ?? const Size(220, 50),
          backgroundColor: backgroundColor ?? theme.violetText,
        ),
        onPressed: onPressed ?? () => debugPrint(text),
        child: Padding(
          padding: margin ??
              const EdgeInsets.symmetric(
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
