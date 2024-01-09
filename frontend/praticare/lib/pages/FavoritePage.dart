// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:praticare/components/sections/SectionHome.dart';
import 'package:praticare/components/cardPraticiens/CardPraticien.dart';
import '../components/interface/BottomBar.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key, required this.title});
  final String title;

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final int _selectedIndex = 1;
  bool sectionFavoris = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    name: "Victoire",
                    metier: "Cardiologue",
                    dateRdvPasser: "02/09/23",
                  ),
                  CardPraticien(
                    isInRow: sectionFavoris,
                    urlImage:
                        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                    name: "Victoire",
                    metier: "Podologue",
                    dateRdvPasser: "02/09/23",
                  ),
                  CardPraticien(
                    isInRow: sectionFavoris,
                    urlImage:
                        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                    name: "Victoire",
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
