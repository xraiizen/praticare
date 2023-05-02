// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:praticare/theme/theme.dart' as theme;

class BtnValidator extends StatelessWidget {
  late String text;
  late void Function()? onPressed;
  BtnValidator({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextButton(
        onPressed: () {
          onPressed;
        },
        style: ButtonStyle(overlayColor:
            MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
          return const Color.fromARGB(0, 0, 0, 0);
        })),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: theme.primary400,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 120),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
