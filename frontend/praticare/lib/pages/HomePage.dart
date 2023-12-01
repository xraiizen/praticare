// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:praticare/components/BtnValidator.dart';
import 'package:praticare/components/cardPraticiens/CardPraticien.dart';
import 'package:praticare/components/cardPraticiens/CardPraticienRdvPrevus.dart';
import 'package:praticare/components/interface/AppBar.dart';

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
  final int _selectedIndex = 0;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<void> refresh() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(const Duration(seconds: 2));
    setState(() {});
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        extendBody: true,
        extendBodyBehindAppBar: false,
        appBar: const MyAppBar(),
        bottomNavigationBar: BottomBar(
          selectedIndex: _selectedIndex,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // decoration: const BoxDecoration(
          //   backgroundBlendMode: BlendMode.colorBurn,
          //   gradient: LinearGradient(
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //     colors: <Color>[
          //       Color.fromARGB(255, 35, 87, 139),
          //       Color.fromARGB(255, 187, 213, 237),
          //       Color.fromARGB(255, 255, 114, 194),
          //     ],
          //   ),
          // ),
          child: RefreshIndicator(
            key: refreshKey,
            onRefresh: refresh,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SectionHome(
                          isRow: false,
                          title: 'Rendez-vous prévus',
                          children: const [
                            CardPraticienRdvPrevus(
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
                        SectionHome(
                          isRow: sectionRdvPasser,
                          showMore: true,
                          title: 'Rendez-vous passés',
                          children: [
                            CardPraticien(
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
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: BtnValidator(
                        icon: Icons.search_sharp,
                        text: "Rechercher un praticien",
                        activePrimaryTheme: true,
                        routeName: "SearchMapPage",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
