// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:praticare/models/schoolModel.dart';
import 'package:intl/intl.dart';
import 'package:praticare/theme/theme.dart' as theme;
import 'package:url_launcher/url_launcher.dart';

Future<void> openMap(String adresse) async {
  // Encodez l'adresse pour l'URL
  String query = Uri.encodeComponent(adresse);
  // Construisez l'URL pour Google Maps
  Uri googleUrl =
      Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');

  // Pour iOS, vous pouvez utiliser une URL Apple Maps si vous préférez
  // String appleUrl = 'https://maps.apple.com/?q=$query';
  debugPrint(googleUrl.toString());
  if (!await launchUrl(
    googleUrl,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not open the map $googleUrl');
  }
}

class MyAppBar {
  appBar(height, context, dateTime, School school) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    String formattedTime = DateFormat('HH:mm').format(dateTime);
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      child: GestureDetector(
        onTap: () {
          GoRouter.of(context).push('/school/${school.id}');
        },
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
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Prochain rendez-vous",
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              formattedDate,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ]),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 27,
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                  "https://www.magazine-cerise.com/wp-content/uploads/2021/07/ecole-medecine-1080x675.jpg"),
                            ),
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Text(
                                  school.nom,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                school.secteur,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(
                            flex: 2,
                          ),
                          Text(
                            formattedTime,
                            style: const TextStyle(
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
                      openMap(
                          school.adresse + school.codePostal + school.ville);
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
      ),
    );
  }
}
