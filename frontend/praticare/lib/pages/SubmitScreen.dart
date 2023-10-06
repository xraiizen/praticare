// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:praticare/components/BtnValidator.dart';
import 'package:praticare/components/Text_field_sign.dart';
import 'package:praticare/theme/theme.dart' as theme;

class SubmitScreen extends StatefulWidget {
  const SubmitScreen({Key? key}) : super(key: key);

  @override
  State<SubmitScreen> createState() {
    return _SubmitScreenState();
  }
}

class _SubmitScreenState extends State<SubmitScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController bornDateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 64),
              child:
                  SvgPicture.asset("assets/icons/Logo_unique.svg", width: 64),
            ),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Inscription',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            const SizedBox(height: 32.0),
            TextFieldSign(
                title: 'Email ou numéro de téléphone',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                hintText: 'Saisissez votre email ou numéro de téléphone'),
            const SizedBox(height: 20.0),
            TextFieldSign(
                title: 'Mot de passe',
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                hintText: 'Saisissez votre mot de passe'),
            const SizedBox(height: 20.0),
            TextFieldSign(
                title: 'Date de naissance',
                controller: bornDateController,
                keyboardType: TextInputType.datetime,
                hintText: 'Saisissez votre date de naissance'),
            const SizedBox(height: 20.0),
            TextFieldSign(
                title: 'Lieu de naissance',
                controller: cityController,
                keyboardType: TextInputType.streetAddress,
                hintText: 'Saisissez votre lieu de naissance'),
            const SizedBox(height: 32.0),
            BtnValidator(
              text: "Créer un compte",
              activePrimaryTheme: true,
            ),
            TextButton(
              onPressed: () {
                GoRouter.of(context).pushNamed("Login");
              },
              child: Text(
                "J'ai déja un compte",
                style: TextStyle(color: theme.grey100),
              ),
            )
          ],
        ),
      ),
    );
  }
}
