// ignore_for_file: must_be_immutable, file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';

class TextFieldSign extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  TextFieldSign({required this.title, required this.controller});

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
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Saisissez votre texte ici',
          ),
        ),
      ],
    );
  }
}
