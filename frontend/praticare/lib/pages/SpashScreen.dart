// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void redirect(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 4));
    GoRouter.of(context).goNamed('AllComponents');
  }

  @override
  void initState() {
    super.initState();
    redirect(context);
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
            width: MediaQuery.of(context).size.width / 2,
            child: Image.asset("assets/icons/Logo.png"),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 25),
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
        ],
      ),
    ));
  }
}
