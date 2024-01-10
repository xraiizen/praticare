// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:praticare/components/sections/SectionFavorie.dart';
import '../components/interface/BottomBar.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key, required this.title});
  final String title;

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  final int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CircularBottomBar(
        selectedIndex: _selectedIndex,
      ),
      body: Center(
        child: SingleChildScrollView(
            child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SectionHome(isRow: false, title: 'Rendez-vous', children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                child: InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 5,
                    color: const Color.fromARGB(0, 244, 67, 54),
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 11,
                          child: Image.asset(
                              "assets/images/ecole_de_medecine.png",
                              fit: BoxFit.cover),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 9.5,
                          color: const Color.fromARGB(255, 229, 243, 33),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        )),
      ),
    );
  }
}
