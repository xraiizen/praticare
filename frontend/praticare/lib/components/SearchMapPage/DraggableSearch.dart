// ignore_for_file: file_names, library_private_types_in_public_api, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:praticare/models/schoolModel.dart';
import 'package:praticare/theme/theme.dart' as theme;

class DraggableSearch extends StatefulWidget {
  List<School> schools;
  final Function(School) onSchoolSelected;
  final DraggableScrollableController draggableScrollableController;
  DraggableSearch(
      {super.key,
      required this.schools,
      required this.onSchoolSelected,
      required this.draggableScrollableController});

  @override
  _DraggableSearchState createState() => _DraggableSearchState();
}

class _DraggableSearchState extends State<DraggableSearch> {
  List<School> filteredSchools = [];
  TextEditingController searchController = TextEditingController();
  late String userId;
  @override
  void initState() {
    super.initState();
    userId = getCurrentUserId()!;
  }

  @override
  void didUpdateWidget(covariant DraggableSearch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.schools != oldWidget.schools) {
      setState(() {
        filteredSchools = widget.schools;
      });
    }
    loadFavorites(); // Chargez les favoris après avoir obtenu l'ID de l'utilisateur
  }

  String? getCurrentUserId() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  // *** Chargez les écoles favorites de l'utilisateur actuel
  Future<void> loadFavorites() async {
    final userId = getCurrentUserId();
    if (userId == null) return; // Assurez-vous que l'utilisateur est connecté

    final favoritesSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .get();
    // Créez un Set des IDs des écoles favorites pour une recherche rapide
    final favoriteIds = Set.from(favoritesSnapshot.docs.map((doc) => doc.id));
    // Mettez à jour l'état de isFavorite pour chaque école
    setState(() {
      for (var school in filteredSchools) {
        school.isFavorite = favoriteIds.contains(school.id);
      }
    });
  }

  // *** Basculez l'état de favori pour une école
  void toggleFavoriteStatus(School school, String userId) async {
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(school.id); // Assurez-vous que votre modèle School a un champ id

    DocumentSnapshot doc = await docRef.get();

    if (doc.exists) {
      // Si le document existe, supprimez-le pour "défavoriser" l'école
      await docRef.delete();
      setState(() {
        school.isFavorite = false;
      });
    } else {
      // Sinon, créez le document pour "favoriser" l'école
      await docRef.set({'isFavorite': true});
      setState(() {
        school.isFavorite = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        // Ferme le clavier si la taille du DraggableScrollableSheet change
        FocusScope.of(context).unfocus();
        return true; // Retourne true pour indiquer que la notification est gérée
      },
      child: DraggableScrollableSheet(
        controller: widget.draggableScrollableController,
        initialChildSize: 0.5,
        minChildSize: 0.24,
        maxChildSize: 1,
        snapSizes: const [0.5, 1],
        snap: true,
        builder: (BuildContext context, scrollSheetController) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            child: Container(
              color: Colors.white,
              child: CustomScrollView(
                controller: scrollSheetController,
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Center(
                          //   child: Container(
                          //     margin: const EdgeInsets.symmetric(vertical: 5),
                          //     width: 50,
                          //     height: 5,
                          //     decoration: BoxDecoration(
                          //       color: Colors.black,
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SizedBox(
                              height: 50,
                              child: SearchBar(
                                controller: searchController,
                                overlayColor: const MaterialStatePropertyAll(
                                    Colors.transparent),
                                surfaceTintColor:
                                    const MaterialStatePropertyAll(
                                        Colors.transparent),
                                backgroundColor:
                                    MaterialStatePropertyAll(theme.violetText),
                                leading: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                textStyle: const MaterialStatePropertyAll(
                                    TextStyle(
                                        fontFamily: "Popins",
                                        color: Colors.white,
                                        fontSize: 16)),
                                hintText: "Chercher une école, une pratique...",
                                hintStyle: const MaterialStatePropertyAll(
                                    TextStyle(
                                        fontFamily: "Popins",
                                        color: Colors.white,
                                        fontSize: 16)),
                                onChanged: (value) {
                                  setState(() {
                                    if (value.isEmpty) {
                                      filteredSchools = widget
                                          .schools; // Affiche toutes les écoles si la barre de recherche est vide
                                    } else {
                                      filteredSchools = widget.schools
                                          .where((school) => school.nom
                                              .toLowerCase()
                                              .contains(value.toLowerCase()))
                                          .toList();
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Text("École à proximité",
                                style: TextStyle(
                                    fontFamily: "Popins",
                                    color: theme.violetText,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        var school = filteredSchools[index];
                        var schoolName = school.nom;
                        var adresse = school.adresse;
                        return Card(
                          margin: EdgeInsets.zero,
                          elevation: 0,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            onTap: () {
                              GoRouter.of(context).push('/school/${school.id}');
                            },
                            leading: CircleAvatar(
                                radius: 25,
                                backgroundColor: theme.violetText,
                                child: const Icon(
                                  Icons.school,
                                  size: 30,
                                  color: Colors.white,
                                )),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  schoolName,
                                  style: const TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  adresse,
                                  style: const TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      widget.onSchoolSelected(school);
                                    },
                                    icon: Icon(
                                      Icons.directions,
                                      size: 32,
                                      color: theme.violetText,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        toggleFavoriteStatus(school, userId);
                                      });
                                    },
                                    icon: Icon(
                                      school.isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: 32,
                                      color: theme.violetText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            selectedTileColor: Colors.grey[200],
                          ),
                        );
                      },
                      childCount: filteredSchools.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
