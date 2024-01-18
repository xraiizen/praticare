// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:praticare/models/schoolModel.dart';

class SearchPageApi {
  static Future<List<School>> getSchoolsWithGeo() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('ecole').get();

    List<School> schools = [];
    for (var doc in querySnapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      List<Location> locations =
          await locationFromAddress(data['adresse'] + ', ' + data['ville']);
      if (locations.isNotEmpty) {
        schools.add(
          School.fromMap(data, doc.id)
            ..latitude = locations.first.latitude
            ..longitude = locations.first.longitude,
        );
      } else {
        schools.add(School.fromMap(data, doc.id));
      }
    }

    return schools;
  }
}
