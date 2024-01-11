// ignore_for_file: file_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:praticare/components/BtnValidator.dart';
import 'package:praticare/components/Text_field_sign.dart';
import 'package:praticare/components/sections/SectionFavorie.dart';
import '../components/interface/BottomBar.dart';
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
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final bornDateController = TextEditingController();
  final bornCityController = TextEditingController();
  final adressController = TextEditingController();
  late String fullName = '';

  @override
  void initState() {
    super.initState();
    // _loadUserData();
    // _loadUserName();
  }

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
        bornCityController.text = userData!['bornCity'] ?? '';
        adressController.text = userData!['adress'] ?? '';
        print(firstnameController.text);
        print(lastnameController.text);
        print(bornDateController.text);
        print(bornCityController.text);
        print(adressController.text);
      });
    }
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
        fullName = userData!['firstname'] + " " + userData!['lastname'];
        print(fullName);
      });
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
              'bornCity': bornCityController.text,
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
              'bornCity': bornCityController.text,
              'adress': adressController.text,
            })
            .then((value) => print("User Info Updated"))
            .catchError((error) => print("Failed to update user info: $error"));
      }
    }
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
                padding: EdgeInsets.only(top: height - (height * (718 / 812))),
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * (618 / 812),
                  minHeight: MediaQuery.of(context).size.height * (618 / 812),
                ),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(fullName,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ]),
              ),
            ),
            Positioned(
              top: height - (height * (618 / 812)) - 55,
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
                  onPressed: () => signOut,
                  icon: const Icon(Icons.logout_outlined),
                ),
              ),
            ),
          ],
        ));
  }
}
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: CircularBottomBar(
//         selectedIndex: _selectedIndex,
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: SectionHome(
//             isRow: false,
//             title: 'Votre profil',
//             children: [
//               TextFieldSign(
//                 title: 'Prénom',
//                 controller: firstnameController,
//                 keyboardType: TextInputType.name,
//                 hintText: 'Saisissez votre prénom',
//               ),
//               TextFieldSign(
//                 title: 'Nom',
//                 controller: lastnameController,
//                 keyboardType: TextInputType.name,
//                 hintText: 'Saisissez votre nom',
//               ),
//               TextFieldSign(
//                 title: 'Date de naissance',
//                 controller: bornDateController,
//                 keyboardType: TextInputType.datetime,
//                 hintText: 'Saisissez votre date de naissance',
//               ),
//               TextFieldSign(
//                 title: 'Lieu de naissance',
//                 controller: bornCityController,
//                 keyboardType: TextInputType.streetAddress,
//                 hintText: 'Saisissez votre lieu de naissance',
//               ),
//               TextFieldSign(
//                 title: 'Adresse',
//                 controller: adressController,
//                 keyboardType: TextInputType.streetAddress,
//                 hintText: 'Saisissez votre adresse',
//               ),
//               const SizedBox(
//                 height: 24,
//               ),
//               BtnValidator(
//                 text: "Enregistrer",
//                 activePrimaryTheme: true,
//                 onPressed: _saveUserData,
//               ),
//               BtnValidator(
//                 text: "Deconnexion",
//                 activePrimaryTheme: false,
//                 onPressed: signOut,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
