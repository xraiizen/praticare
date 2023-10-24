// ignore_for_file: file_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:praticare/components/BtnValidator.dart';
import 'package:praticare/components/Text_field_sign.dart';
import 'package:praticare/components/interface/AppBar.dart';
import '../components/interface/BottomBar.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key, required this.title});
  final String title;

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final int _selectedIndex = 2;
  User? currentUser;
  Map<String, dynamic>? userData;
  final bornDateController = TextEditingController();
  final cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);
      final DocumentSnapshot userSnapshot = await userDoc.get();
      setState(() {
        userData = userSnapshot.data() as Map<String, dynamic>?;
        bornDateController.text = userData!['bornDate'] ?? '';
        cityController.text = userData!['city'] ?? '';
        print(bornDateController.text);
        print(cityController.text);
      });
    }
  }

  Future<void> _saveUserData() async {
    if (currentUser != null) {
      final DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);
      return userDoc
          .update({
            'bornDate': bornDateController.text,
            'city': cityController.text,
          })
          .then((value) => print("User Info Updated"))
          .catchError((error) => print("Failed to update user info: $error"));
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Rediriger l'utilisateur vers l'écran de connexion ou la page d'accueil après la déconnexion
      GoRouter.of(context).pushNamed("Login");
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
    return Scaffold(
      appBar: const MyAppBar(),
      bottomNavigationBar: BottomBar(
        selectedIndex: _selectedIndex,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFieldSign(
                  title: 'Date de naissance',
                  controller: bornDateController,
                  keyboardType: TextInputType.datetime,
                  hintText: 'Saisissez votre date de naissance',
                ),
                TextFieldSign(
                  title: 'Lieu de naissance',
                  controller: cityController,
                  keyboardType: TextInputType.streetAddress,
                  hintText: 'Saisissez votre lieu de naissance',
                ),
                BtnValidator(
                  text: "Enregistrer",
                  activePrimaryTheme: true,
                  onPressed: _saveUserData,
                ),
                BtnValidator(
                  text: "Deconnexion",
                  activePrimaryTheme: true,
                  onPressed: signOut,
                ),
                // ... (le reste de votre code)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
