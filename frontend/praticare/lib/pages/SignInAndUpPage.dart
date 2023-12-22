// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:praticare/components/TextButtonBgColor.dart';
import 'package:praticare/components/TextButtonBorderColor.dart';
import 'package:praticare/theme/theme.dart' as theme;

class SignInAndUpPage extends StatefulWidget {
  @override
  _SignInAndUpPageState createState() => _SignInAndUpPageState();
}

class _SignInAndUpPageState extends State<SignInAndUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/icons/home.png",
                width: MediaQuery.of(context).size.width),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'La',
                style: const TextStyle(color: Colors.black, fontSize: 30),
                children: <TextSpan>[
                  TextSpan(
                      text: ' médecine',
                      style: TextStyle(color: theme.violetText, fontSize: 30)),
                  const TextSpan(text: ' à portée \n de'),
                  TextSpan(
                      text: ' tous',
                      style: TextStyle(color: theme.violetText, fontSize: 30)),
                ],
              ),
            ),
            TextButtonBgColor(
                text: "Se connecter",
                onPressed: () => GoRouter.of(context).pushNamed("Login"),
                backgroundColor: theme.violetText),
            TextButtonBorderColor(
                text: "S'inscrire",
                onPressed: () => GoRouter.of(context).pushNamed("Submit"),
                borderColor: theme.violetText),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
