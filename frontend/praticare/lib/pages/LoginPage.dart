// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:praticare/components/BtnValidator.dart';
import 'package:praticare/components/Text_field_sign.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginPage({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    void signInWithEmailAndPassword() async {
      try {
        final User? user = (await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        ))
            .user;

        if (user != null) {
          print('Connexion réussie : $user');
          GoRouter.of(context).pushNamed("Home");
        } else {
          print('Échec de la connexion');
        }
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur lors de la connexion au compte : $e")),
        );
      }
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 64),
                  child: SvgPicture.asset("assets/icons/Logo_unique.svg",
                      width: 64),
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
                    title: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Saisissez votre email'),
                const SizedBox(height: 20.0),
                TextFieldSign(
                    title: 'Mot de passe',
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    hintText: 'Saisissez votre mot de passe'),
                const SizedBox(height: 32.0),
                BtnValidator(
                  text: "Se connecter",
                  activePrimaryTheme: true,
                  onPressed: signInWithEmailAndPassword,
                ),
                BtnValidator(
                  text: "Créer un compte",
                  activePrimaryTheme: false,
                  routeName: "Submit",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
