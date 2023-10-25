// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:praticare/components/cardPraticiens/CardPraticienResultat.dart';
import 'package:praticare/components/interface/AppBarWithTitle.dart';
import 'package:praticare/models/userModel.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.title});
  final String title;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = ' ';
  List<UserModel> searchResults =
      []; // Supposons que School soit le modèle pour chaque école
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<void> refresh() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(const Duration(seconds: 2));
    setState(() {});
    return;
  }

  // Cette fonction est appelée chaque fois que l'utilisateur modifie sa requête de recherche
  void searchSchools(String query) async {
    List<UserModel> schools = await getSchoolsFromDatabase(query);
    setState(() {
      searchResults = schools;
    });
  }

  Future<List<UserModel>> getSchoolsFromDatabase(String query) async {
    // Récupère une instance de Firestore
    final firestore = FirebaseFirestore.instance;

    try {
      // Formulez votre requête pour obtenir des utilisateurs avec userType = "Ecole" et d'autres critères de recherche (par exemple, sur le nom)
      QuerySnapshot snapshot = await firestore
          .collection('users')
          .where('userType', isEqualTo: 'Ecole')
          .where('firstname', isGreaterThanOrEqualTo: query)
          .get();

      // Transforme les documents obtenus en une liste d'écoles
      List<UserModel> schools =
          snapshot.docs.map((doc) => UserModel.fromDocument(doc)).toList();
      return schools;
    } catch (e) {
      print('Erreur lors de la récupération des écoles : $e');
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    // Recherche toutes les écoles par défaut
    searchSchools('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBarWithTitle(title: "Recherche"),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: refresh,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("A"),
                    TextButton(
                      child: Text("Rennes"),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 55,
                  child: TextField(
                    onChanged: (value) {
                      query = value;
                      searchSchools(query);
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        size: 24,
                      ),
                      labelText: 'Ville, région, adresse, ...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                ),
              ),
              searchResults.isEmpty // Si aucun résultat n'est trouvé
                  ? const Center(child: Text("Aucun résultat"))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        UserModel school = searchResults[index];
                        return CardPraticienResultat(
                          urlImage: school.profilePicture!,
                          firstname: school.firstname,
                          lastname: school.lastname,
                          metier: "Par encore fait",
                          dateRdvPasser: "Par encore fait",
                        );
                      },
                    ),
              CardPraticienResultat(
                urlImage:
                    "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                firstname: "Victoire",
                lastname: "DONIN",
                metier: "Cardiologue",
                dateRdvPasser: "02/09/23",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
