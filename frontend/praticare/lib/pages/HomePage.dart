// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:praticare/components/cardPraticiens/CardPraticien.dart';
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
        backgroundColor: Colors.white,
        extendBody: true,
        extendBodyBehindAppBar: true,
        // appBar: const MyAppBar(),
        appBar: MyAppBar().appBar(AppBar().preferredSize.height, context),
        bottomNavigationBar: AnimatedBottomAppBar(
          selectedIndex: _selectedIndex,
        ),
        // bottomNavigationBar: BottomBar(
        //   selectedIndex: _selectedIndex,
        // ),
        body: Padding(
          padding: EdgeInsets.only(top: AppBar().preferredSize.height + 130),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: RefreshIndicator(
              key: refreshKey,
              onRefresh: refresh,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 81),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // SectionHome(
                          //   isRow: false,
                          //   title: 'Rendez-vous prévus',
                          //   children: const [
                          //     CardPraticienRdvPrevus(
                          //       dateRdv: "05/10",
                          //       urlImage:
                          //           "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                          //       firstname: 'Victoire',
                          //       lastname: 'DONIN',
                          //       metier: 'Cardiologue',
                          //       heureRdv: '11:20',
                          //     )
                          //   ],
                          // ),
                          SectionHome(
                            isRow: sectionFavoris,
                            showMore: true,
                            title: 'Favoris',
                            children: [
                              CardPraticien(
                                isInRow: sectionFavoris,
                                urlImage:
                                    "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                                name: "Stonewall Middle School",
                                metier: "Cardiologue",
                                dateRdvPasser: "02/09/23",
                              ),
                              CardPraticien(
                                isInRow: sectionFavoris,
                                urlImage:
                                    "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                                name: "Stonewall Middle School",
                                metier: "Cardiologue",
                                dateRdvPasser: "02/09/23",
                              ),
                              CardPraticien(
                                isInRow: sectionFavoris,
                                urlImage:
                                    "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                                name: "Stonewall Middle School",
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
                                name: "Stonewall Middle Schools",
                                metier: "Cardiologue",
                                dateRdvPasser: "02/09/23",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
