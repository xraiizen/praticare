// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  final passwordController = TextEditingController();
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
        passwordController.text = userData!['password'] ?? '';
        print(firstnameController.text);
        print(lastnameController.text);
        print(bornDateController.text);
        print(passwordController.text);
        print(adressController.text);
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
              'adress': adressController.text,
              'password': passwordController.text,
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
              'password': passwordController.text,
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
                width: MediaQuery.of(context).size.height * (618 / 812),
                height: MediaQuery.of(context).size.height * (618 / 812),
                padding: EdgeInsets.only(top: height - (height * (718 / 812))),
                child: SingleChildScrollView(
                  child: Column(children: [
                    TextFieldSign(
                      title: 'Prénom',
                      controller: firstnameController,
                      keyboardType: TextInputType.name,
                      hintText: 'Saisissez votre prénom',
                    ),
                    TextFieldSign(
                      title: 'Nom',
                      controller: lastnameController,
                      keyboardType: TextInputType.name,
                      hintText: 'Saisissez votre nom',
                    ),
                    TextFieldSign(
                      isDate: true,
                      title: 'Date de naissance',
                      controller: bornDateController,
                      keyboardType: TextInputType.datetime,
                      hintText: 'Saisissez votre date de naissance',
                    ),
                    TextFieldSign(
                      title: 'Adresse',
                      controller: adressController,
                      keyboardType: TextInputType.datetime,
                      hintText: 'Saisissez votre adresse',
                    ),
                    TextFieldSign(
                      title: 'Mot de passe',
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      hintText: 'Saisissez votre mot de passe',
                    ),
                    SizedBox(
                      height: height / 7,
                    )
                  ]),
                ),
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
                  onPressed: () {},
                  icon: const Icon(Icons.logout_outlined),
                ),
              ),
            ),
          ],
        ));
  }
}
