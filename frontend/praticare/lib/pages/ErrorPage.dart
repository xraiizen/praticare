// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Erreur lors du chargement"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go("/"),
          child: const Text("retour a L'ecran d'accueil "),
        ),
      ),
    );
  }
}
