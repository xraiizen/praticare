// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:praticare/components/cardPraticiens/CardPraticienResultat.dart';
import 'package:praticare/components/interface/AppBarWithTitle.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.title});
  final String title;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarWithTitle(title: "Recherche"),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
    );
  }
}
