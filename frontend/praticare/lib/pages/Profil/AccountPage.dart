// ignore_for_file: file_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:praticare/components/AccountPage/BtnAccountPage.dart';
import 'package:unicons/unicons.dart';
import '../../components/interface/BottomBar.dart';
import 'package:praticare/theme/theme.dart' as theme;

class AccountPage extends StatefulWidget {
  const AccountPage({super.key, required this.title});
  final String title;

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final int _selectedIndex = 2;
  User? currentUser;
  Map<String, dynamic>? userData;
  late String fullName = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);
      final DocumentSnapshot userSnapshot = await userDoc.get();
      setState(() {
        userData = userSnapshot.data() as Map<String, dynamic>?;
        print(userData);
        fullName =
            "${capitalizeFirstLetter(userData!['firstname'])} ${capitalizeFirstLetter(userData!['lastname'])}";
        print(fullName);
      });
    }
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Rediriger l'utilisateur vers l'écran de connexion ou la page d'accueil après la déconnexion
      GoRouter.of(context).goNamed("Login");
    } catch (e) {
      print("Erreur lors de la déconnexion : $e");
      // Traitez les erreurs ici, par exemple en affichant une Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors de la déconnexion : $e")),
      );
    }
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
                padding: EdgeInsets.only(top: height - (height * (755 / 812))),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Text(fullName,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400)),
                    // * Informations personnelles *
                    BtnAccountPage(
                      width: width,
                      height: height,
                      icon: UniconsLine.user,
                      title: "Informations personnelles",
                      subtitle:
                          "Apporter des modifications à vos informations personnelles",
                      onTap: () => GoRouter.of(context)
                          .goNamed("PersonalInformationsPage"),
                    ),
                    // * Informations de connexion *
                    BtnAccountPage(
                      width: width,
                      height: height,
                      icon: UniconsLine.keyhole_circle,
                      title: "Informations de connexion",
                      subtitle: "Gérer vos informations de connexion",
                    ),
                    // * Besoin d'aide *
                    BtnAccountPage(
                      width: width,
                      height: height,
                      icon: UniconsLine.question_circle,
                      title: "Besoin d'aide",
                    ),
                    // * Traitement des données personnelles *
                    BtnAccountPage(
                      width: width,
                      height: height,
                      icon: UniconsLine.exclamation_circle,
                      title: "Traitement des données \n personnelles",
                    ),
                    SizedBox(
                      height: height / 7,
                    )
                  ]),
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
                  onPressed: () {
                    signOut();
                  },
                  icon: const Icon(Icons.logout_outlined),
                ),
              ),
            ),
          ],
        ));
  }
}
