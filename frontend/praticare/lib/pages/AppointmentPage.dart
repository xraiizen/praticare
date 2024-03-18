// ignore_for_file: file_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:praticare/components/cardPraticiens/CardPageRendezVous.dart';
import 'package:praticare/components/sections/SectionFavorie.dart';
import 'package:praticare/utils/firebase_utils.dart';
import '../components/interface/BottomBar.dart';
import 'package:intl/intl.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key, required this.title});
  final String title;

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  final int _selectedIndex = 1;
  List<Map<String, dynamic>> appointments = [];
  List<Map<String, dynamic>> filteredAppointments = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  @override
  void dispose() {
    searchController
        .dispose(); // Nettoyer le contrôleur quand le widget est supprimé
    super.dispose();
  }

  void fetchAppointments() async {
    String userId = FirebaseUtils.getCurrentUserId()!;
    var userDoc = FirebaseFirestore.instance.collection('users').doc(userId);
    var userData = await userDoc.get();
    var userRendezvous = userData.data()?['rendez-vous'] as List<dynamic> ?? [];

    for (var rdv in userRendezvous) {
      String ecoleId = rdv.keys.first;
      var rdvDetails = rdv.values.first;
      var ecoleDoc =
          FirebaseFirestore.instance.collection('ecole').doc(ecoleId);
      var ecoleData = await ecoleDoc.get();

      setState(() {
        appointments.add({
          'idecole': ecoleId,
          'dateTimeRdv':
              rdvDetails, // Utilisation directe de rdvDetails pour accéder au dateTimeRdv
          'name': ecoleData.data()?['nom'] ?? 'Nom inconnu',
          'specialite': ecoleData.data()?['secteur'] ?? 'Spécialité inconnue',
          'adresse': ecoleData.data()?['adresse'] ?? 'Adresse inconnue',
        });
        filteredAppointments = List.from(appointments);
      });
      print("userRendezvous $appointments");
    }
  }

  void filterAppointments(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredAppointments = List.from(appointments);
      });
    } else {
      setState(() {
        filteredAppointments = appointments.where((appointment) {
          return appointment['name']
              .toLowerCase()
              .contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CircularBottomBar(
        selectedIndex: _selectedIndex,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  labelText: 'Chercher un rendez-vous',
                  suffixIcon: Icon(Icons.search),
                ),
                onChanged: filterAppointments,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SectionHome(
                    isRow: false,
                    title: '',
                    children: filteredAppointments
                        .map((appointment) => CardPageRendezVous(
                              // Utilisation de filteredAppointments ici
                              name: appointment['name'],
                              specialite: appointment['specialite'],
                              adresse: appointment['adresse'],
                              heure: DateFormat('HH:mm')
                                  .format(appointment['dateTimeRdv'].toDate()),
                              date: DateFormat('dd/MM/yyyy')
                                  .format(appointment['dateTimeRdv'].toDate()),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
