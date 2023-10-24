import 'package:cloud_firestore/cloud_firestore.dart';

enum UserType { Patient, Ecole }

extension UserTypeExtension on UserType {
  // Convertir UserType en chaîne
  String toShortString() {
    switch (this) {
      case UserType.Patient:
        return 'Patient';
      case UserType.Ecole:
        return 'Ecole';
      default:
        throw Exception('Unknown UserType');
    }
  }

  // Convertir une chaîne en UserType
  static UserType fromString(String roleStr) {
    switch (roleStr) {
      case 'Patient':
        return UserType.Patient;
      case 'Ecole':
        return UserType.Ecole;
      default:
        throw Exception('This role does not exist');
    }
  }
}

class UserModel {
  final String id;
  final String firstname;
  final String lastname;
  final String email; // Supposant que chaque utilisateur a un email unique
  final String bornDate;
  final String bornCity;
  final String adress;
  final UserType userType;
  final String?
      profilePicture; // null pour les patients, obligatoire pour les écoles

  UserModel({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.bornDate,
    required this.bornCity,
    required this.adress,
    required this.userType,
    this.profilePicture, // Optionnel pour les patients, mais vérifié pour les écoles
  });

  // Convertir un objet DocumentSnapshot de Firestore en User
  factory UserModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      firstname: data['firstname'],
      lastname: data['lastname'],
      email: data['email'],
      bornDate: data['bornDate'],
      bornCity: data['bornCity'],
      adress: data['adress'],
      userType: UserTypeExtension.fromString(data['role']),
      profilePicture: data['profilePicture'],
    );
  }

// Convertir un User en Map pour Firestore
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'bornDate': bornDate,
      'bornCity': bornCity,
      'adress': adress,
      'role': userType.toShortString(),
      'profilePicture': userType == UserType.Ecole
          ? (profilePicture ?? 'assets/images/ecole_de_medecine.png')
          : null,
    };

    if (profilePicture != null) {
      map['profilePicture'] = profilePicture;
    }

    return map;
  }
}
