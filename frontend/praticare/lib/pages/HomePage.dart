// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:praticare/components/cardPraticiens/CardPraticien.dart';
import 'package:praticare/components/interface/AppBar.dart';
import 'package:praticare/models/schoolModel.dart';
import 'package:praticare/utils/firebase_utils.dart';
import '../components/interface/BottomBar.dart';
import '../components/sections/SectionHome.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool sectionRdvPasser = false;
  bool sectionFavoris = true;
  final int _selectedIndex = 0;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<void> refresh() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(const Duration(seconds: 2));
    setState(() {});
    return;
  }

  Future<List<String>> fetchFavoriteSchoolIds() async {
    List<String> favoriteSchoolIds = [];
    String userId = FirebaseUtils.getCurrentUserId()!;
    var favoritesSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .get();

    for (var doc in favoritesSnapshot.docs) {
      favoriteSchoolIds
          .add(doc.id); // Supposons que l'ID du document soit l'ID de l'école
    }

    return favoriteSchoolIds;
  }

  Future<List<School>> fetchFavoriteSchools(List<String> schoolIds) async {
    List<School> schools = [];

    for (String id in schoolIds) {
      var schoolDoc =
          await FirebaseFirestore.instance.collection('ecole').doc(id).get();
      if (schoolDoc.exists) {
        schools.add(School.fromMap(schoolDoc.data()!, schoolDoc.id));
      }
    }

    return schools;
  }

  Future<List<Map<String, DateTime>>> fetchPastAppointments() async {
    List<Map<String, DateTime>> pastAppointments = [];
    String userId = FirebaseUtils.getCurrentUserId()!;
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    Map<String, dynamic> userDocData = userDoc.data() as Map<String, dynamic>;
    if (userDoc.exists && userDocData.containsKey('rendez-vous')) {
      List<dynamic> rendezVousList = userDoc.get('rendez-vous') as List;
      DateTime now = DateTime.now();
      for (var rendezVous in rendezVousList) {
        Map<String, dynamic> rendezVousData =
            Map<String, dynamic>.from(rendezVous);
        Timestamp timestamp = rendezVousData.values.first as Timestamp;
        DateTime dateRdv = timestamp.toDate();
        String idSchool = rendezVousData.keys.first;

        if (dateRdv.isBefore(now)) {
          // Vérifier si la date du rendez-vous est passée
          pastAppointments.add({idSchool: dateRdv});
        }
      }
    }

    return pastAppointments;
  }

  Future<List<School>> fetchSchoolsDetails(
      List<Map<String, DateTime>> pastAppointments) async {
    List<School> schools = [];
    for (var appointment in pastAppointments) {
      var schoolId = appointment.keys.first;
      var rendezVousDate = appointment.values.first;
      DocumentSnapshot schoolDoc = await FirebaseFirestore.instance
          .collection('ecole')
          .doc(schoolId)
          .get();

      if (schoolDoc.exists) {
        var data = schoolDoc.data() as Map<String, dynamic>;
        School school = School.fromMap(data, schoolDoc.id);
        school.rendezVousDate = rendezVousDate;
        schools.add(school);
      }
    }

    return schools;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: MyAppBar().appBar(AppBar().preferredSize.height, context),
        bottomNavigationBar: CircularBottomBar(
          selectedIndex: _selectedIndex,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: AppBar().preferredSize.height + 130),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: RefreshIndicator(
              key: refreshKey,
              onRefresh: refresh,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 81),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FutureBuilder<List<School>>(
                            future: fetchFavoriteSchoolIds()
                                .then((ids) => fetchFavoriteSchools(ids)),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Text(
                                    "Aucune école favorite trouvée");
                              }

                              List<School> schools = snapshot.data!;

                              return SectionHome(
                                isRow: sectionFavoris,
                                showMore: true,
                                title: 'Favoris',
                                children: schools
                                    .map((school) => CardPraticien(
                                          isInRow: sectionFavoris,
                                          urlImage:
                                              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1", // Remplacez par l'image réelle de l'école si disponible
                                          school: school,
                                        ))
                                    .toList(),
                              );
                            },
                          ),
                          FutureBuilder<List<School>>(
                            future: fetchPastAppointments().then(
                                (appointments) =>
                                    fetchSchoolsDetails(appointments)),
                            builder: (context, snapshot) {
                              if (snapshot.hasError ||
                                  !snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return SectionHome(
                                    isRow: sectionRdvPasser,
                                    showMore: true,
                                    title: 'Rendez-vous passés',
                                    children: const [
                                      Text("Aucun rendez-vous passé trouvé")
                                    ]);
                              }

                              List<School> schools = snapshot.data!;

                              return SectionHome(
                                isRow: sectionRdvPasser,
                                showMore: true,
                                title: 'Rendez-vous passés',
                                children: schools
                                    .map((school) => CardPraticien(
                                          isInRow: sectionRdvPasser,
                                          urlImage:
                                              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                                          school: school,
                                        ))
                                    .toList(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
