// ignore_for_file: file_names, library_private_types_in_public_api
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:praticare/components/SchoolDetailPage/MyDatePicker.dart';
import 'package:praticare/models/schoolModel.dart';
import 'package:praticare/theme/theme.dart' as theme;
import 'package:praticare/utils/firebase_utils.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

class SchoolDetailPage extends StatefulWidget {
  final String schoolId;
  const SchoolDetailPage({Key? key, required this.schoolId}) : super(key: key);

  @override
  _SchoolDetailPageState createState() => _SchoolDetailPageState();
}

class _SchoolDetailPageState extends State<SchoolDetailPage> {
  final double iconSize = 30;
  School? school;
  bool isLoading = true; // Ajouter un indicateur de chargement
  DateTime? rdvDateTime;

  @override
  void initState() {
    super.initState();
    getSchoolInfo(widget.schoolId);
  }

  Future<void> getSchoolInfo(String schoolId) async {
    setState(() {
      isLoading = true; // Commence le chargement
    });
    try {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('ecole')
          .doc(schoolId)
          .get();
      if (docSnapshot.exists) {
        School currschool = School.fromMap(
            docSnapshot.data() as Map<String, dynamic>, docSnapshot.id);
        setState(() {
          school = currschool;
          isLoading = false; // Fin du chargement
        });
      }
    } catch (e) {
      debugPrint("Erreur lors de la récupération de l'école: $e");
      setState(() {
        isLoading =
            false; // Assurez-vous de mettre fin au chargement même en cas d'erreur
      });
    }
  }

  void onDateTimeSelected(DateTime? dateTime) {
    setState(() {
      rdvDateTime = dateTime;
    });
    debugPrint(dateTime.toString());
  }

  void addReminderToCalendar(DateTime startDateTime) {
    final Event event = Event(
      title: 'Rendez-vous ${school!.nom}',
      description:
          'Rendez-vous avec l\'école ${school!.nom} a l\'adresse : ${school!.adresse}.',
      startDate: startDateTime,
      endDate: startDateTime.add(const Duration(hours: 1)),
      // Assumption: 1 hour duration
      location: school!.adresse,
    );

    Add2Calendar.addEvent2Cal(event);
  }

  Future<void> addAppointmentToArray(DateTime appointmentDateTime) async {
    String userId = FirebaseUtils
        .getCurrentUserId()!; // Assurez-vous d'obtenir l'ID d'utilisateur actuel

    // Préparez le rendez-vous à ajouter
    var newSchoolAppointment = {
      userId: Timestamp.fromDate(appointmentDateTime),
    };
    var newUserAppointment = {
      school!.id: Timestamp.fromDate(appointmentDateTime),
    };

    // Document de l'école
    DocumentReference schoolDocRef =
        FirebaseFirestore.instance.collection('ecole').doc(school!.id);

    // Ajouter le rendez-vous au tableau dans le document de l'école
    await schoolDocRef.update({
      'rendez-vous': FieldValue.arrayUnion([newSchoolAppointment]),
    });

    // Document de l'utilisateur
    DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

    // Ajouter le rendez-vous au tableau dans le document de l'utilisateur

    await userDocRef.set({
      'rendez-vous': FieldValue.arrayUnion([newUserAppointment]),
    }, SetOptions(merge: true)).catchError((error) => debugPrint(
        "Erreur lors de l'ajout du rendez-vous à l'utilisateur: $error"));
  }

  void showThankYouDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Rendez-vous confirmé"),
          content: const Text(
              "Merci d'avoir pris rendez-vous. Voulez-vous ajouter un rappel pour cet événement ?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Non"),
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialogue
              },
            ),
            TextButton(
              child: const Text("Ajouter un rappel"),
              onPressed: () {
                addReminderToCalendar(rdvDateTime!);
                // Ici, ajoutez la logique pour ajouter un rappel
                Navigator.of(context)
                    .pop(); // Optionnellement ferme le dialogue
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> openMap(String adresse) async {
    // Encodez l'adresse pour l'URL
    String query = Uri.encodeComponent(adresse);
    // Construisez l'URL pour Google Maps
    Uri googleUrl =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');

    // Pour iOS, vous pouvez utiliser une URL Apple Maps si vous préférez
    // String appleUrl = 'https://maps.apple.com/?q=$query';
    debugPrint(googleUrl.toString());
    if (!await launchUrl(
      googleUrl,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not open the map $googleUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Afficher un indicateur de chargement pendant le chargement des données
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    // Assurez-vous que `school` n'est pas null ici avant de continuer
    if (school == null) {
      return const Scaffold(
        body: Center(child: Text("L'école n'a pas été trouvée")),
      );
    }
    double heightHeader = MediaQuery.of(context).size.height / 3;
    return Scaffold(
        backgroundColor: theme.violetText,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                width: double.infinity,
                height: heightHeader,
                child: Column(
                  children: [
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                size: iconSize,
                              ),
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // Utilisez Expanded pour forcer les boutons à prendre l'espace minimal, centrant ainsi l'image
                        const Expanded(
                          flex: 4,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 38,
                              backgroundImage: AssetImage(
                                  'assets/images/ecole_de_medecine.png'),
                            ),
                          ),
                        ),

                        // Mettez les boutons dans un widget pour les grouper ensemble
                        Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: school!.isFavorite
                                  ? Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                      size: iconSize,
                                    )
                                  : Icon(
                                      Icons.favorite_border,
                                      size: iconSize,
                                      color: Colors.white,
                                    ),
                              onPressed: () {
                                setState(() {
                                  // TODO GESTION DES FAVORIS
                                });
                              },
                            )),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            onPressed: () {
                              // Partager l'école
                            },
                            icon: Icon(
                              Icons.info_outline,
                              size: iconSize,
                            ),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(school!.nom,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 32,
                              fontWeight: FontWeight.w400)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          school!.adresse,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          school!.numeroTel,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              style: TextButton.styleFrom(
                                  fixedSize: const Size(150, 40),
                                  foregroundColor: theme.violetText,
                                  backgroundColor: Colors.white,
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                              onPressed: () {
                                // Afficher le lieu
                                openMap(school!.adresse +
                                    school!.codePostal +
                                    school!.ville);
                              },
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.place_outlined),
                                  Text("Afficher le lieu")
                                ],
                              )),
                          TextButton(
                            style: TextButton.styleFrom(
                                fixedSize: const Size(150, 40),
                                foregroundColor: theme.violetText,
                                backgroundColor: Colors.white,
                                textStyle: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400)),
                            onPressed: () {
                              Uri phoneUri = Uri(
                                  scheme: 'tel',
                                  path: school!.numeroTel.replaceAll(" ", ""));
                              launchUrl(phoneUri);
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [Icon(Icons.phone), Text("Appeler")],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height:
                        MediaQuery.of(context).size.height - 27 - heightHeader,
                    padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                    child: Stack(
                      children: [
                        MyDatePicker(
                          school: school!,
                          onDateTimeSelected: onDateTimeSelected,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: TextButton(
                                onPressed: () {
                                  if (rdvDateTime != null) {
                                    // Appeler la fonction pour ajouter le rendez-vous
                                    if (rdvDateTime != null) {
                                      addAppointmentToArray(rdvDateTime!)
                                          .then((value) {
                                        debugPrint(
                                            "Rendez-vous ajouté avec succès");
                                        showThankYouDialog(context);
                                        // Peut-être montrer une confirmation à l'utilisateur ici
                                      }).catchError((error) {
                                        // Gérer l'erreur ici
                                        debugPrint(
                                            "Erreur lors de l'ajout du rendez-vous: $error");
                                      });
                                    }
                                  }
                                },
                                style: TextButton.styleFrom(
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width * 0.5,
                                      45),
                                  shadowColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  elevation: rdvDateTime != null ? 5 : 1,
                                  backgroundColor: rdvDateTime != null
                                      ? theme.violetText
                                      : const Color(0xFFBDBDBD),
                                ),
                                child: Text("Réserver",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: rdvDateTime != null
                                            ? Colors.white
                                            : const Color.fromARGB(
                                                207, 87, 87, 87),
                                        fontWeight: FontWeight.w400))),
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }
}
