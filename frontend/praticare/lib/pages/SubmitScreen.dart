// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:praticare/components/BtnValidator.dart';

class SubmitScreen extends StatefulWidget {
  const SubmitScreen({Key? key}) : super(key: key);

  @override
  State<SubmitScreen> createState() {
    return _SubmitScreenState();
  }
}

class _SubmitScreenState extends State<SubmitScreen> {
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      body: BtnValidator(
        text: "Se connecter",
      ),
    );
  }
}
