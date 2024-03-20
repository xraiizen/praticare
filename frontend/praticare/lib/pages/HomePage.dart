// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
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
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  bool hasFutureAppointment = false; // Indique si un rendez-vous futur existe
  DateTime? nextAppointmentDateTime; // Date et heure du prochain rendez-vous
  School? nextAppointmentSchool; // École du prochain rendez-vous
  double spacerAppBar = 0;
  Timer? timer;
  @override
  void initState() {
    super.initState();

    fetchAppointments();
  }

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

  void fetchAppointments() async {
    String userId = FirebaseUtils.getCurrentUserId()!;
    var userDoc = FirebaseFirestore.instance.collection('users').doc(userId);
    var userData = await userDoc.get();
    var userRendezvous = userData.data()?['rendez-vous'] as List<dynamic>;
    DateTime now = DateTime.now();

    // Convertit et filtre les rendez-vous pour ceux dans le futur
    var futureAppointments = userRendezvous.where((rdv) {
      Timestamp timestamp =
          rdv.values.first; // Ici, on obtient directement le Timestamp
      DateTime rdvDateTime = timestamp.toDate();
      return rdvDateTime.isAfter(now);
    }).toList();

    // Trie les rendez-vous par date/heure
    futureAppointments.sort((a, b) {
      Timestamp timestampA = a.values.first as Timestamp;
      DateTime aDateTime = timestampA.toDate();

      Timestamp timestampB = b.values.first as Timestamp;
      DateTime bDateTime = timestampB.toDate();

      return aDateTime.compareTo(bDateTime);
    });

    // Vérifie s'il existe des rendez-vous à venir et met à jour l'état en conséquence
    if (futureAppointments.isNotEmpty) {
      var nextAppointment = futureAppointments.first;
      var schoolId = nextAppointment.keys.first; // ID de l'école

      // Ici, vous extrayez le Timestamp et le convertissez en DateTime
      Timestamp timestamp = nextAppointment.values.first as Timestamp;

      DateTime nextAppointmentDateTime = timestamp.toDate();

      var schoolDoc = await FirebaseFirestore.instance
          .collection('ecole')
          .doc(schoolId)
          .get();
      if (schoolDoc.exists) {
        setState(() {
          hasFutureAppointment = true;
          this.nextAppointmentDateTime =
              nextAppointmentDateTime; // Ici, c'est déjà un DateTime
          nextAppointmentSchool = School.fromMap(
              schoolDoc.data()!, schoolDoc.id); // Les infos de l'école
          spacerAppBar = 130;
        });
      }
    } else {
      setState(() {
        hasFutureAppointment = false;
        nextAppointmentDateTime = null;
        nextAppointmentSchool = null;
        spacerAppBar = 0;
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appBar;
    print("$nextAppointmentDateTime, $nextAppointmentSchool");
    if (nextAppointmentDateTime != null && nextAppointmentSchool != null) {
      // Ici, vous créez votre AppBar personnalisée avec les informations du prochain rendez-vous
      appBar = MyAppBar().appBar(AppBar().preferredSize.height, context,
          nextAppointmentDateTime!, nextAppointmentSchool!);
    } else {
      // AppBar standard avec le titre "Praticare"
      appBar = AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
                height: 40,
                width: 40,
                child: SvgPicture.asset("assets/icons/logo_violet.svg",
                    fit: BoxFit.cover)),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Praticare',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
          ],
        ),
      );
    }
    return Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: appBar,
        bottomNavigationBar: CircularBottomBar(
          key: GlobalKey(),
          indexNav: 0,
        ),
        body: Padding(
          padding: EdgeInsets.only(
              top: AppBar().preferredSize.height + spacerAppBar),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: RefreshIndicator(
              key: refreshKey,
              onRefresh: refresh,
              child: Padding(
                padding:
                    EdgeInsets.only(bottom: 81 + spacerAppBar != 0 ? 0 : 0),
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
                                              "https://www.magazine-cerise.com/wp-content/uploads/2021/07/ecole-medecine-1080x675.jpg", // Remplacez par l'image réelle de l'école si disponible
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
                                              "https://www.magazine-cerise.com/wp-content/uploads/2021/07/ecole-medecine-1080x675.jpg",
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
