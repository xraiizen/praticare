// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:praticare/components/TextButtonBgColor.dart';
import 'package:praticare/components/Text_field_sign.dart';
import 'package:praticare/theme/theme.dart ' as theme;

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.1,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/backgroundSpline.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 8,
                        bottom: 120),
                    child: const Text(
                      'Connexion',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  TextFieldSign(
                      title: 'Adresse email',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Saisissez votre adresse email'),
                  const SizedBox(height: 50.0),
                  TextFieldSign(
                      isPassword: true,
                      title: 'Mot de passe',
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: 'Saisissez votre mot de passe'),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Mot de passe oublié ?",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: theme.vert),
                        )),
                  ),
                  const Spacer(),
                  TextButtonBgColor(
                    text: "Se connecter",
                    onPressed: signInWithEmailAndPassword,
                  ),
                  const Spacer(),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Vous n'avez pas de compte ?",
                              style:
                                  TextStyle(fontSize: 14, color: theme.violet),
                            ),
                            TextButton(
                                onPressed: () {
                                  GoRouter.of(context).pushNamed("Submit");
                                },
                                child: Text(
                                  "S'inscrire",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: theme.vert),
                                )),
                          ]))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
