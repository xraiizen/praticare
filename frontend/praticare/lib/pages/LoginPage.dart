import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:praticare/components/BtnValidator.dart';
import 'package:praticare/components/Text_field_sign.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset("assets/icons/Logo_unique.svg"),
            const SizedBox(height: 20.0),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Connexion',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            const SizedBox(height: 20.0),
            TextFieldSign(
              title: 'Email ou numéro de téléphone',
              controller: emailController,
            ),
            const SizedBox(height: 20.0),
            TextFieldSign(
              title: 'Mot de passe',
              controller: passwordController,
            ),
            const SizedBox(height: 20.0),
            BtnValidator(
              text: "Se connecter",
            ),
          ],
        ),
      ),
    );
  }
}
