// ignore_for_file: must_be_immutable, file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';

class TextFieldSign extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String? hintText;
  final TextInputType keyboardType;

  const TextFieldSign({
    super.key,
    required this.title,
    required this.controller,
    required this.hintText,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 44,
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              hintText: hintText,
            ),
          ),
        ),
      ],
    );
  }
}
