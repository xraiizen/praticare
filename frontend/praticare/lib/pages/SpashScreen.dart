// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 1));

    // Vérifiez si un utilisateur est déjà connecté
    GoRouter.of(context).pushReplacementNamed("AllComponents");
    // if (FirebaseAuth.instance.currentUser != null) {
    //   GoRouter.of(context).pushReplacementNamed(
    //       "Home"); // Redirigez vers la page d'accueil si l'utilisateur est déjà connecté
    // } else {
    //   GoRouter.of(context).pushReplacementNamed(
    //       "SignInAndUpPage"); // Sinon, redirigez vers la page de connexion
    // }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
        body: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
              height: 128,
              child: SvgPicture.asset("assets/icons/logo_violet.svg")),
        ],
      ),
    ));
  }
}
