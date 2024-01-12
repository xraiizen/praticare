// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  late String fullName = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    Map<String, dynamic>? userData;
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
                    Text(fullName,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400)),
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
