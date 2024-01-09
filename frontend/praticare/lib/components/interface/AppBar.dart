// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:praticare/theme/theme.dart' as theme;

class MyAppBar {
  appBar(height, context) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 130),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              ),
              child: Container(
                // Background
                color: theme.violetText,
                height: height + 125,
                width: MediaQuery.of(context).size.width,
                // Background
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Prochain rendez-vous",
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "08/12/2023",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ]),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 27,
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(
                                  "assets/images/ecole_de_medecine.png"),
                            ),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Stonewall Middle School",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Médecine Généraliste",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Spacer(
                            flex: 2,
                          ),
                          Text(
                            "11:30",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Container(), // Required some widget in between to float AppBar

            Positioned(
              // To take AppBar Size only
              top: 150.0,
              left: 60.0,
              right: 60.0,
              child: AppBar(
                automaticallyImplyLeading: false,
                shadowColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                elevation: 0.0,
                primary: false,
                centerTitle: true,
                title: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      surfaceTintColor: Colors.white,
                    ),
                    onPressed: () {
                      // Add your logic here
                    },
                    icon: Icon(
                      Icons.location_on_outlined,
                      color: theme.violetText,
                      size: 24,
                    ),
                    label: Text(
                      "Afficher le lieu",
                      style: TextStyle(
                          color: theme.violetText,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
}
