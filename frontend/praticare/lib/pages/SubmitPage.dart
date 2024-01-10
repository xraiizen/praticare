// ignore_for_file: file_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:praticare/components/TextButtonBgColor.dart';
import 'package:praticare/components/Text_field_sign.dart';
import 'package:praticare/models/userModel.dart';
import 'package:praticare/theme/theme.dart' as theme;

class SubmitPage extends StatefulWidget {
  const SubmitPage({Key? key}) : super(key: key);

  @override
  State<SubmitPage> createState() {
    return _SubmitPageState();
  }
}

class _SubmitPageState extends State<SubmitPage> {
  UserType selectedRole = UserType.Patient; // Valeur par défaut
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController bornDateController = TextEditingController();
  final TextEditingController adressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  Future<void> registerAccount() async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (userCredential.user != null) {
        print("UID de l'utilisateur créé : ${userCredential.user!.uid}");
        await saveAdditionalUserInfo(userCredential.user!.uid);
        GoRouter.of(context).pushNamed("Login");
      } else {
        print("Erreur : L'utilisateur n'a pas été créé.");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors de la création du compte : $e")),
      );
    }
  }

  Future<void> saveAdditionalUserInfo(String userId) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      // Création de l'objet UserModel
      UserModel newUser = UserModel(
        id: userId,
        email: emailController.text,
        firstname: firstnameController.text,
        lastname: lastnameController.text,
        bornDate: bornDateController.text,
        adress: adressController.text,
        userType: selectedRole,
        profilePicture: null,
      );

      // Sauvegarde de l'objet UserModel dans Firestore
      await users.doc(userId).set(newUser.toMap());

      print("Informations utilisateur ajoutées avec succès.");
    } catch (error) {
      print("Erreur lors de l'ajout des informations utilisateur : $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Erreur lors de la creation du compte : $error")),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    bornDateController.dispose();
    adressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            GoRouter.of(context).goNamed("SignInAndUpPage");
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/backgroundSpline.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 8,
                          bottom: 80),
                      child: const Text(
                        'Inscription',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    TextFieldSign(
                        title: 'Email',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Saisissez votre email'),
                    TextFieldSign(
                        title: 'Prénom',
                        controller: firstnameController,
                        keyboardType: TextInputType.name,
                        hintText: 'Saisissez votre prénom'),
                    TextFieldSign(
                        title: 'Nom',
                        controller: lastnameController,
                        keyboardType: TextInputType.name,
                        hintText: 'Saisissez votre nom'),
                    TextFieldSign(
                        isDate: true,
                        title: 'Date de naissance',
                        controller: bornDateController,
                        keyboardType: TextInputType.datetime,
                        hintText: 'Saisissez votre date de naissance'),
                    TextFieldSign(
                        title: 'Adresse',
                        controller: adressController,
                        keyboardType: TextInputType.streetAddress,
                        hintText: 'Saisissez votre adresse'),
                    TextFieldSign(
                        isPassword: true,
                        title: 'Mot de passe',
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: 'Saisissez votre mot de passe'),
                    TextFieldSign(
                        isPassword: true,
                        title: 'Confirmez le mot de passe',
                        controller: passwordConfirmController,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: 'Saisissez votre mot de passe'),
                    TextButtonBgColor(
                        text: "S'inscrire",
                        onPressed: () {
                          if (passwordController.text !=
                              passwordConfirmController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Erreur : Les mots de passe ne correspondent pas. Veuillez réessayer.")),
                            );
                          } else {
                            registerAccount();
                          }
                        }),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Vous avez déjà un compte ?",
                                style: TextStyle(
                                    fontSize: 14, color: theme.violet),
                              ),
                              TextButton(
                                  onPressed: () {
                                    GoRouter.of(context).goNamed("Login");
                                  },
                                  child: Text(
                                    "Se connecter",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: theme.vert),
                                  )),
                            ])),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
