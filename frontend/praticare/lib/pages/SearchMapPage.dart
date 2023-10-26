// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:praticare/components/cardPraticiens/CardPraticienResultat.dart';
import 'package:praticare/components/interface/AppBarWithTitle.dart';
import 'package:praticare/models/userModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';


class SearchMapPage extends StatefulWidget {
  const SearchMapPage({super.key, required this.title});
  final String title;

  @override
  State<SearchMapPage> createState() => _SearchMapPageState();
}

class _SearchMapPageState extends State<SearchMapPage>{
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static double latitude = 0.0;
  static double longitude = 0.0;
   CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(latitude, longitude),
    zoom: 14.4746,
  );
  @override
  void initState() {
    super.initState();
initValue();
  }
void initValue()async{
  _kGooglePlex;
    _kGooglePlex = await  _determinePosition();
    setState(() {
      
    });
}
  Future<CameraPosition> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the 
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale 
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. 
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    Position position = await Geolocator.getCurrentPosition();

    latitude = position.latitude.toDouble();
    longitude = position.longitude.toDouble();
    return  CameraPosition(
    target: LatLng(latitude, longitude),
    zoom: 14.4746,
  );
  }
  
  static const String customMapStyle = '''
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ma Carte Google'),
      ),
       body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          controller.setMapStyle(customMapStyle);
        },
      ),
    );
  }
}
