// ignore_for_file: file_names, unused_import

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:praticare/components/BtnValidator.dart';

class AllComponentsScreen extends StatelessWidget {
  const AllComponentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Erreur lors du chargement"),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          BtnValidator(
            text: "Se connecter",
          ),
        ],
      )),
    );
  }
}
