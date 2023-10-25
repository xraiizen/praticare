import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:praticare/models/userModel.dart';

class School {
  final String? imageUrl;
  final String name;
  final String metier;
  final String dateRdvPasser;
  final String address;

  School({
    this.imageUrl,
    required this.name,
    required this.metier,
    required this.dateRdvPasser,
    required this.address,
  });

  factory School.fromDocument(DocumentSnapshot doc) {
    return School(
      imageUrl: doc['imageUrl'],
      name: doc['firstname'],
      metier: doc['metier'],
      dateRdvPasser: doc['dateRdvPasser'],
      address: doc['address'],
    );
  }

  // Convertir une Ecole en Map pour Firestore
  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl ?? 'assets/images/ecole_de_medecine.png',
      'name': name,
      'metier': metier,
      'dateRdvPasser': dateRdvPasser,
      'address': address,
      'role': UserType.Ecole,
    };
  }
}
