import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:praticare/components/BtnValidator.dart';
import 'package:praticare/components/Text_field_sign.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

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
                  'Connexion',
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
            const SizedBox(height: 32.0),
            BtnValidator(
              text: "Se connecter",
              activePrimaryTheme: true,
              routeName: "Home",
            ),
            BtnValidator(
              text: "Créer un compte",
              activePrimaryTheme: false,
              routeName: "Submit",
            ),
          ],
        ),
      ),
    );
  }
}
