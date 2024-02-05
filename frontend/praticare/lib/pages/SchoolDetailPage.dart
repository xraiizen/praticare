// ignore_for_file: file_names, library_private_types_in_public_api
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:praticare/components/SchoolDetailPage/MyDatePicker.dart';
import 'package:praticare/models/schoolModel.dart';
import 'package:praticare/theme/theme.dart' as theme;
import 'package:praticare/utils/firebase_utils.dart';

class SchoolDetailPage extends StatefulWidget {
  final String schoolId;
  const SchoolDetailPage({Key? key, required this.schoolId}) : super(key: key);

  @override
  _SchoolDetailPageState createState() => _SchoolDetailPageState();
}

class _SchoolDetailPageState extends State<SchoolDetailPage> {
  final double iconSize = 30;
  School school = School(
      numeroTel: '',
      id: '',
      adresse: '',
      codePostal: '',
      nom: '',
      secteur: '',
      ville: '',
      latitude: 0.0,
      longitude: 0.0,
      isFavorite: false,
      horairesDeFermeture: [],
      rendezVous: []);
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    getSchoolInfo(widget.schoolId);
    getFavoriteStatus();
  }

  Future<void> getSchoolInfo(String schoolId) async {
    try {
      // Accéder à la collection où sont stockées les écoles
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('ecole')
          .doc(schoolId)
          .get();
      if (docSnapshot.exists) {
        School currschool = School.fromMap(
            docSnapshot.data() as Map<String, dynamic>, docSnapshot.id);
        school = currschool;
      }
    } catch (e) {
      // Gérer les erreurs éventuelles
      debugPrint("Erreur lors de la récupération de l'école: $e");
    }
  }

  void getFavoriteStatus() async {
    isFavorite = await FirebaseUtils.isFavorite(widget.schoolId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double heightHeader = MediaQuery.of(context).size.height / 3;
    return Scaffold(
        backgroundColor: theme.violetText,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  width: double.infinity,
                  height: heightHeader,
                  child: Expanded(
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
                                  icon: isFavorite
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
                                    FirebaseUtils.toggleFavorite(
                                        widget.schoolId);
                                    setState(() {});
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
                          child: Text(school.nom,
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
                              school.adresse,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              school.numeroTel,
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
                                  onPressed: () {},
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                                onPressed: () {},
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.phone),
                                    Text("Appeler")
                                  ],
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
                          schoolID: widget.schoolId,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width * 0.5,
                                      45),
                                  shadowColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  elevation: 5,
                                  backgroundColor: theme.violetText,
                                ),
                                child: const Text("Réserver",
                                    style: TextStyle(
                                        fontSize: 20,
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
