// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:praticare/Api/SearchPageApi.dart';
import 'package:praticare/components/SearchMapPage/DraggableSearch.dart';
import 'dart:async';
import 'package:praticare/components/interface/BottomBar.dart';
import 'package:praticare/global/variables.dart' as global;
import 'package:praticare/models/schoolModel.dart';

class SearchMapPage extends StatefulWidget {
  const SearchMapPage({super.key, required this.title});
  final String title;

  @override
  State<SearchMapPage> createState() => _SearchMapPageState();
}

class _SearchMapPageState extends State<SearchMapPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final DraggableScrollableController _draggableScrollableController =
      DraggableScrollableController();
  final int _selectedIndex = 3;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(48.113759033957265, -1.6780924051285282),
    zoom: 13,
  );
  List<Marker> markers = [];
  late BitmapDescriptor myIcon;
  List<School> schools = [];

  @override
  void initState() {
    super.initState();
    _createTargetIcon();
    _getSchools().then((value) {
      _createMarker();
    });
  }

  _getSchools() async {
    schools.clear();
    schools = await SearchPageApi.getSchoolsWithGeo();
  }

  _createMarker() {
    markers.clear();
    for (var school in schools) {
      var marker = Marker(
        markerId: MarkerId(school.nom),
        position: LatLng(school.latitude, school.longitude),
        infoWindow: InfoWindow(title: school.nom),
        icon: myIcon,
      );
      markers.add(marker);
    }
    setState(() {});
  }

  Future<void> _createTargetIcon() async {
    myIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(2.0, 2.0)),
        'assets/icons/Spotlight_Marker.png');
  }

  void _onSchoolSelected(School selectedSchool) {
    const zoomLevel = 17.0;
    const minChildSize = 0.24;

    final selectedLocation =
        LatLng(selectedSchool.latitude, selectedSchool.longitude);

    _controller.future.then((GoogleMapController controller) {
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: selectedLocation, zoom: zoomLevel),
      ));
    });

    // Réduire la taille du DraggableScrollableSheet
    _draggableScrollableController.animateTo(
      minChildSize,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
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
                controller.setMapStyle(global.customMapStyle);
              },
              markers: Set<Marker>.of(markers),
            ),
            DraggableSearch(
              schools: schools,
              onSchoolSelected: _onSchoolSelected,
              draggableScrollableController: _draggableScrollableController,
            ),
          ],
        ),
      ),
    );
  }
}
