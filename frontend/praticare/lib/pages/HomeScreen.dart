// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:praticare/components/cardPratitien/CardPratitien.dart';
import 'package:praticare/components/cardPratitien/CardPratitienRdvPrevus.dart';
import 'package:praticare/components/interface/AppBar.dart';

import '../components/interface/BottomBar.dart';
import '../components/SectionHome.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool sectionRdvPasser = false;
  bool sectionFavoris = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(),
        bottomNavigationBar: const BottomBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SectionHome(
                isRow: false,
                title: 'Rendez-vous prévus',
                children: const [
                  CardPratitienRdvPrevus(
                    dateRdv: "05/10",
                    urlImage:
                        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                    firstname: 'Victoire',
                    lastname: 'DONIN',
                    metier: 'Cardiologue',
                    heureRdv: '11:20',
                  )
                ],
              ),
              SectionHome(
                isRow: sectionFavoris,
                showMore: true,
                title: 'Favoris',
                children: [
                  CardPratitien(
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
              SectionHome(
                isRow: sectionRdvPasser,
                showMore: true,
                title: 'Rendez-vous passés',
                children: [
                  CardPratitien(
                    isInRow: sectionRdvPasser,
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
