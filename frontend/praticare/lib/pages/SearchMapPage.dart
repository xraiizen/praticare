// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:praticare/theme/theme.dart' as theme;
import 'package:praticare/components/interface/BottomBar.dart';

class SearchMapPage extends StatefulWidget {
  const SearchMapPage({super.key, required this.title});
  final String title;

  @override
  State<SearchMapPage> createState() => _SearchMapPageState();
}

class _SearchMapPageState extends State<SearchMapPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final int _selectedIndex = 3;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(48.113759033957265, -1.6780924051285282),
    zoom: 13,
  );
  // Définissez les coordonnées de votre marqueur
  LatLng markerLatLng = const LatLng(48.0900368054287, -1.6751246024528512);
  // Liste pour stocker les marqueurs
  List<Marker> markers = [];
  late BitmapDescriptor myIcon;
  int selectedCarId = 1;
  // liste des ecoles
  List schools = [
    {'id': 0},
    {'id': 1, 'name': 'school 1'},
    {'id': 2, 'name': 'school 2'},
    {'id': 3, 'name': 'school 3'},
  ];

  @override
  void initState() {
    super.initState();
    _loadSchoolData();
    _createTargetIcon();
  }

// fonction asynchrone qui récupère les données de l'école à partir de la base de données Firestore
  Future<List<Map<String, dynamic>>> _loadSchoolData() async {
    List<Map<String, dynamic>> allSchoolData = [];

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('ecole').get();

      setState(() {
        if (querySnapshot.docs.isNotEmpty) {
          for (QueryDocumentSnapshot doc in querySnapshot.docs) {
            var schoolData = doc.data() as Map<String, dynamic>;
            allSchoolData.add(schoolData);
          }

          // Affichez les données dans la console
          for (var schoolData in allSchoolData) {
            print('Adresse: ${schoolData['adresse']}');
            print('Code Postal: ${schoolData['code_postal']}');
            print('Nom: ${schoolData['nom']}');
            print('Secteur: ${schoolData['secteur']}');
            print('Ville: ${schoolData['ville']}');
            print('---');
          }
        } else {
          print('Aucun document trouvé dans la collection "ecole".');
        }
      });
    } catch (error) {
      print('Erreur lors de la récupération des données : $error');
    }

    return allSchoolData;
  }

// Créez l'icône du marqueur
  _createTargetIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(
              size: Size(25, 40),
            ),
            'assets/icons/pink_marker.png')
        .then((value) => myIcon = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: CircularBottomBar(
        selectedIndex: _selectedIndex,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                controller.setMapStyle(customMapStyle);

                // Ajoutez le marqueur à la liste
                setState(() {
                  markers.add(
                    Marker(
                      markerId: const MarkerId('mydigitalschool'),
                      position: markerLatLng,
                      infoWindow: const InfoWindow(title: 'MyDigitalSchool'),
                      icon: myIcon,
                    ),
                  );
                });
              },
              markers: Set<Marker>.of(markers),
            ),
            DraggableScrollableSheet(
                initialChildSize: 0.5,
                minChildSize: 0.24,
                maxChildSize: 1,
                snapSizes: const [0.5, 1],
                snap: true,
                builder: (BuildContext context, scrollSheetController) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                        color: Colors.white,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const ClampingScrollPhysics(),
                          controller: scrollSheetController,
                          itemCount: schools.length,
                          itemBuilder: (BuildContext context, int index) {
                            final school = schools[index];
                            if (index == 0) {
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          width: 50,
                                          height: 5,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: SearchBar(
                                          overlayColor:
                                              const MaterialStatePropertyAll(
                                                  Colors.transparent),
                                          surfaceTintColor:
                                              const MaterialStatePropertyAll(
                                                  Colors.transparent),
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  theme.violetText),
                                          leading: const Icon(
                                            Icons.search,
                                            color: Colors.white,
                                          ),
                                          textStyle:
                                              const MaterialStatePropertyAll(
                                                  TextStyle(
                                                      fontFamily: "Popins",
                                                      color: Colors.white,
                                                      fontSize: 16)),
                                          hintText: "Chercher une école",
                                          hintStyle:
                                              const MaterialStatePropertyAll(
                                                  TextStyle(
                                                      fontFamily: "Popins",
                                                      color: Colors.white,
                                                      fontSize: 16)),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 10),
                                        child: Text("Vos Favoris",
                                            style: TextStyle(
                                                fontFamily: "Popins",
                                                color: theme.violetText,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ],
                                  ));
                            }

                            return Card(
                              margin: EdgeInsets.zero,
                              elevation: 0,
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(10),
                                onTap: () {
                                  setState(() {
                                    selectedCarId = school['id'];
                                  });
                                },
                                leading: const Icon(Icons.school),
                                title: Text(school['name']),
                                selected: selectedCarId == school['id'],
                                selectedTileColor: Colors.grey[200],
                              ),
                            );
                          },
                        )),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

const String customMapStyle = '''
    [
      {
        "featureType": "all",
        "elementType": "geometry.fill",
        "stylers": [
          {"weight": "2.00"}
        ]
      },
      {
        "featureType": "all",
        "elementType": "geometry.stroke",
        "stylers": [
          {"color": "#9c9c9c"}
        ]
      },
      {
        "featureType": "all",
        "elementType": "labels.text",
        "stylers": [
          {"visibility": "on"}
        ]
      },
      {
        "featureType": "landscape",
        "elementType": "all",
        "stylers": [
          {"color": "#f2f2f2"}
        ]
      },
      {
        "featureType": "landscape",
        "elementType": "geometry.fill",
        "stylers": [
          {"color": "#ffffff"}
        ]
      },
      {
        "featureType": "landscape.man_made",
        "elementType": "geometry.fill",
        "stylers": [
          {"color": "#ffffff"}
        ]
      },
      {
        "featureType": "poi",
        "elementType": "all",
        "stylers": [
          {"visibility": "off"}
        ]
      },
      {
        "featureType": "road",
        "elementType": "all",
        "stylers": [
          {"saturation": -100},
          {"lightness": 45}
        ]
      },
      {
        "featureType": "road",
        "elementType": "geometry.fill",
        "stylers": [
          {"color": "#eeeeee"}
        ]
      },
      {
        "featureType": "road",
        "elementType": "labels.text.fill",
        "stylers": [
          {"color": "#7b7b7b"}
        ]
      },
      {
        "featureType": "road",
        "elementType": "labels.text.stroke",
        "stylers": [
          {"color": "#ffffff"}
        ]
      },
      {
        "featureType": "road.highway",
        "elementType": "all",
        "stylers": [
          {"visibility": "simplified"}
        ]
      },
      {
        "featureType": "road.arterial",
        "elementType": "labels.icon",
        "stylers": [
          {"visibility": "off"}
        ]
      },
      {
        "featureType": "transit",
        "elementType": "all",
        "stylers": [
          {"visibility": "off"}
        ]
      },
      {
        "featureType": "water",
        "elementType": "all",
        "stylers": [
          {"color": "#46bcec"},
          {"visibility": "on"}
        ]
      },
      {
        "featureType": "water",
        "elementType": "geometry.fill",
        "stylers": [
          {"color": "#c8d7d4"}
        ]
      },
      {
        "featureType": "water",
        "elementType": "labels.text.fill",
        "stylers": [
          {"color": "#070707"}
        ]
      },
      {
        "featureType": "water",
        "elementType": "labels.text.stroke",
        "stylers": [
          {"color": "#ffffff"}
        ]
      }
    ]
    ''';
