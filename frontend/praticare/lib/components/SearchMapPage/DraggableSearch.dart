// ignore_for_file: file_names, library_private_types_in_public_api, must_be_immutable

import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DraggableSearch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.schools != oldWidget.schools) {
      setState(() {
        filteredSchools = widget.schools;
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
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
                          Center(
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              width: 50,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: SearchBar(
                              controller: searchController,
                              overlayColor: const MaterialStatePropertyAll(
                                  Colors.transparent),
                              surfaceTintColor: const MaterialStatePropertyAll(
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
                              hintText: "Chercher une école",
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
                        return Card(
                          margin: EdgeInsets.zero,
                          elevation: 0,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            onTap: () {
                              widget.onSchoolSelected(school);
                            },
                            leading: const Icon(Icons.school),
                            title: Text(schoolName),
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
