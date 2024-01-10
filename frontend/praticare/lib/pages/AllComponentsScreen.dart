// ignore_for_file: file_names, unused_import

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:praticare/components/BtnValidator.dart';
import 'package:praticare/components/Text_field_sign.dart';

class AllComponentsScreen extends StatelessWidget {
  const AllComponentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController bornController = TextEditingController();
    final TextEditingController textController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Erreur lors du chargement"),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          TextFieldSign(
            isDate: true,
            title: 'Date de naissance',
            controller: bornController,
            keyboardType: TextInputType.name,
            hintText: 'Saisissez votre date de naissance',
          ),
          TextFieldSign(
            title: 'text',
            controller: textController,
            keyboardType: TextInputType.name,
            hintText: 'Saisissez votre text',
          ),
        ],
      )),
    );
  }
}
