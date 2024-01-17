// ignore_for_file: library_private_types_in_public_api, must_be_immutable, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:praticare/components/TextButtonBgColor.dart';
import 'package:praticare/components/Text_field_sign.dart';
import 'package:praticare/components/interface/BottomBar.dart';
import 'package:praticare/theme/theme.dart' as theme;

class PersonalInformationsPage extends StatefulWidget {
  const PersonalInformationsPage({Key? key}) : super(key: key);
  @override
  _PersonalInformationsPageState createState() =>
      _PersonalInformationsPageState();
}

class _PersonalInformationsPageState extends State<PersonalInformationsPage> {
  final int _selectedIndex = 2;
  User? currentUser;
  Map<String, dynamic>? userData;

  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final bornDateController = TextEditingController();
  final adressController = TextEditingController();
  Future<void> _loadUserData() async {
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);
      final DocumentSnapshot userSnapshot = await userDoc.get();
      setState(() {
        userData = userSnapshot.data() as Map<String, dynamic>?;
        firstnameController.text = userData!['firstname'] ?? '';
        lastnameController.text = userData!['lastname'] ?? '';
        bornDateController.text = userData!['bornDate'] ?? '';
        adressController.text = userData!['adress'] ?? '';
        print(firstnameController.text);
        print(lastnameController.text);
        print(bornDateController.text);
        print(adressController.text);
      });
    }
  }

  Future<void> sendPasswordResetEmail(
      String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Popup de succès
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("E-mail envoyé"),
            content: Text(
                "Un e-mail de réinitialisation de mot de passe a été envoyé à $email."),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      // Popup d'erreur spécifique à Firebase
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Erreur"),
            content: Text(
                "Une erreur est survenue lors de l'envoi de l'e-mail: ${e.message}"),
            actions: [
              TextButton(
                child: Text("Fermer"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Popup pour d'autres erreurs
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Erreur"),
            content: Text("Une erreur est survenue: $e"),
            actions: [
              TextButton(
                child: Text("Fermer"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _saveUserData() async {
    if (currentUser != null) {
      final DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);
      if (userDoc.id.isNotEmpty) {
        return userDoc
            .update({
              'firstname': firstnameController.text,
              'lastname': lastnameController.text,
              'bornDate': bornDateController.text,
              'adress': adressController.text,
            })
            .then((value) => print("User Info Updated"))
            .catchError((error) => print("Failed to update user info: $error"));
      } else {
        return userDoc
            .set({
              'firstname': firstnameController.text,
              'lastname': lastnameController.text,
              'bornDate': bornDateController.text,
              'adress': adressController.text,
            })
            .then((value) => print("User Info Updated"))
            .catchError((error) => print("Failed to update user info: $error"));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        extendBody: true,
        backgroundColor: theme.violetText,
        bottomNavigationBar: CircularBottomBar(
          selectedIndex: _selectedIndex,
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                width: MediaQuery.of(context).size.height * (655 / 812),
                height: MediaQuery.of(context).size.height * (655 / 812),
                padding: EdgeInsets.only(
                  top: height - (height * (780 / 812)),
                ),
                child: ShaderMask(
                  shaderCallback: (Rect rect) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.purple,
                        Colors.transparent,
                        Colors.transparent,
                        Colors.purple
                      ],
                      stops: [
                        0.0,
                        0.2,
                        0.9,
                        1.0
                      ], // 10% purple, 80% transparent, 10% purple
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.dstOut,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        TextFieldSign(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          title: 'Prénom',
                          controller: firstnameController,
                          keyboardType: TextInputType.name,
                          hintText: 'Saisissez votre prénom',
                          bgColor: theme.violetbgInput,
                        ),
                        TextFieldSign(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          title: 'Nom',
                          controller: lastnameController,
                          keyboardType: TextInputType.name,
                          hintText: 'Saisissez votre nom',
                          bgColor: theme.violetbgInput,
                        ),
                        TextFieldSign(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          isDate: true,
                          title: 'Date de naissance',
                          controller: bornDateController,
                          keyboardType: TextInputType.datetime,
                          hintText: 'Saisissez votre date de naissance',
                          bgColor: theme.violetbgInput,
                        ),
                        TextFieldSign(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          title: 'Adresse',
                          controller: adressController,
                          keyboardType: TextInputType.datetime,
                          hintText: 'Saisissez votre adresse',
                          bgColor: theme.violetbgInput,
                        ),
                        TextButtonBgColor(
                            text: "Réinitialisé le mot de passe",
                            fontSize: 15,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 40),
                            size: Size(width, 50),
                            onPressed: () async {
                              sendPasswordResetEmail(
                                  currentUser!.email!, context);
                            }),
                        SizedBox(
                          width: width,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButtonBgColor(
                                text: "Annuler",
                                fontSize: 15,
                                backgroundColor: Colors.red,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 0),
                                size: Size(width / 2.5, 50),
                                onPressed: _loadUserData,
                              ),
                              TextButtonBgColor(
                                text: "Valider",
                                fontSize: 15,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 0),
                                size: Size(width / 2.5, 50),
                                onPressed: _saveUserData,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height / 7,
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: height - (height * (670 / 812)) - 55,
              right: width / 2 - 55,
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 57,
                child: CircleAvatar(
                  radius: 55,
                  // * IMAGE DE PROFIL *
                  backgroundImage: NetworkImage(
                      "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                ),
              ),
            ),
            // * SignOut *
            Positioned(
              top: height - (height * (755 / 812)),
              right: width / 11,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(57),
                ),
                child: IconButton(
                  color: Colors.red,
                  onPressed: () {},
                  icon: const Icon(Icons.logout_outlined),
                ),
              ),
            ),
          ],
        ));
  }
}
