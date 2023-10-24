// ignore_for_file: file_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:praticare/components/BtnValidator.dart';
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
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController bornDateController = TextEditingController();
  final TextEditingController bornCityController = TextEditingController();
  final TextEditingController adressController = TextEditingController();

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
        firstname: firstnameController.text,
        lastname: lastnameController.text,
        email: emailController.text,
        bornDate: bornDateController.text,
        bornCity: bornCityController.text,
        adress: adressController.text,
        userType: selectedRole,
        // Si le type est Ecole et qu'aucune photo n'est fournie, utilisez celle par défaut
        profilePicture: selectedRole == UserType.Ecole
            ? 'assets/images/ecole_de_medecine.png'
            : null,
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
    bornCityController.dispose();
    adressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 75),
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
                        'Inscription',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  const SizedBox(height: 32.0),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Type",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: UserType.values.map((type) {
                      return Expanded(
                        child: ListTile(
                          title: Text(type
                              .toShortString()), // Utilisez votre extension ici
                          leading: Radio<UserType>(
                            value: type,
                            groupValue: selectedRole,
                            onChanged: (UserType? value) {
                              setState(() {
                                selectedRole = value!;
                              });
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  TextFieldSign(
                      title: 'Email',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Saisissez votre email'),
                  const SizedBox(height: 20.0),
                  TextFieldSign(
                      title: 'Mot de passe',
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: 'Saisissez votre mot de passe'),
                  const SizedBox(height: 20.0),
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
                      title: 'Date de naissance',
                      controller: bornDateController,
                      keyboardType: TextInputType.datetime,
                      hintText: 'Saisissez votre date de naissance'),
                  const SizedBox(height: 20.0),
                  TextFieldSign(
                      title: 'Lieu de naissance',
                      controller: bornCityController,
                      keyboardType: TextInputType.streetAddress,
                      hintText: 'Saisissez votre lieu de naissance'),
                  TextFieldSign(
                      title: 'Adresse',
                      controller: adressController,
                      keyboardType: TextInputType.streetAddress,
                      hintText: 'Saisissez votre adresse'),
                  const SizedBox(height: 32.0),
                  BtnValidator(
                    text: "Créer un compte",
                    activePrimaryTheme: true,
                    onPressed: registerAccount,
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
          ),
        ),
      ),
    );
  }
}
