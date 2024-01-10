// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:praticare/components/cardPraticiens/CardPageRendezVous.dart';
import 'package:praticare/components/sections/SectionFavorie.dart';
import '../components/interface/BottomBar.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key, required this.title});
  final String title;

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  final int _selectedIndex = 1;

  String name = 'Pleasant Hill High';
  String specialite = 'Cardiologie';
  String heure = '10:30';
  String date = '12/12/2023';
  String adresse = '66 rue Michel Ange';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CircularBottomBar(
        selectedIndex: _selectedIndex,
      ),
      body: Center(
        child: SingleChildScrollView(
            child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SectionHome(isRow: false, title: 'Rendez-vous', children: [
            CardPageRendezVous(
              name: name,
              specialite: specialite,
              adresse: adresse,
              heure: heure,
              date: date,
            ),
          ]),
        )),
      ),
    );
  }
}
