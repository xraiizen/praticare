// ignore_for_file: file_names
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
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

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
