// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class SearchMapPage extends StatefulWidget {
  const SearchMapPage({super.key, required this.title});
  final String title;

  @override
  State<SearchMapPage> createState() => _SearchMapPageState();
}



 

class _SearchMapPageState extends State<SearchMapPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(48.113759033957265, -1.6780924051285282),
    zoom: 13,
  );

  // Définissez les coordonnées de votre marqueur
  LatLng markerLatLng = const LatLng(48.0900368054287, -1.6751246024528512);

  // Liste pour stocker les marqueurs
  List<Marker> markers = [];
  late BitmapDescriptor myIcon;
  @override
  void initState() {
    super.initState();
        _loadSchoolData();
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(
              size: Size(25, 40),
            ),
            'assets/icons/pink_marker.png')
        .then((value) => myIcon = value);
  }
  
  Future<List<Map<String, dynamic>>> _loadSchoolData() async {
    List<Map<String, dynamic>> allSchoolData = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('ecole').get();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: GoogleMap(
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
