// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:praticare/components/sections/SectionHome.dart';
import 'package:praticare/components/cardPraticiens/CardPraticien.dart';
import 'package:praticare/components/interface/AppBar.dart';
import '../components/interface/BottomBar.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key, required this.title});
  final String title;

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final int _selectedIndex = 1;
  bool sectionFavoris = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(),
        bottomNavigationBar: BottomBar(
          selectedIndex: _selectedIndex,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SectionHome(
                isRow: sectionFavoris,
                title: 'Vos favoris',
                children: [
                  CardPraticien(
                    isInRow: sectionFavoris,
                    urlImage:
                        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                    firstname: "Victoire",
                    lastname: "DONIN",
                    metier: "Cardiologue",
                    dateRdvPasser: "02/09/23",
                  ),
                  CardPraticien(
                    isInRow: sectionFavoris,
                    urlImage:
                        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                    firstname: "Victoire",
                    lastname: "DONIN",
                    metier: "Podologue",
                    dateRdvPasser: "02/09/23",
                  ),
                  CardPraticien(
                    isInRow: sectionFavoris,
                    urlImage:
                        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                    firstname: "Victoire",
                    lastname: "DONIN",
                    metier: "Cardiologue",
                    dateRdvPasser: "02/09/23",
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
