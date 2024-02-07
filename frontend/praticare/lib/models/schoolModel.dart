// ignore_for_file: file_names

class School {
  final String id;
  final String adresse;
  final String codePostal;
  final String nom;
  final String secteur;
  final String ville;
  final String numeroTel;
  List<String?> horairesDeFermeture;
  List<Map<String, dynamic>> rendezVous;
  DateTime? rendezVousDate;
  double latitude;
  double longitude;
  bool isFavorite;
  School({
    required this.numeroTel,
    required this.id,
    required this.adresse,
    required this.codePostal,
    required this.nom,
    required this.secteur,
    required this.ville,
    required this.latitude,
    required this.longitude,
    required this.horairesDeFermeture,
    required this.rendezVous,
    this.isFavorite = false,
  });

  factory School.fromMap(Map<String, dynamic> map, String documentId) {
    var rawRendezVous = map['rendez-vous'] as List<dynamic>? ?? [];
    List<Map<String, dynamic>> rendezVous = [];

    for (var element in rawRendezVous) {
      if (element is Map<String, dynamic>) {
        rendezVous.add(element);
      } else {
        print("Warning: encountered a non-map element in rendez-vous list");
      }
    }
    // Handling horairesDeFermeture casting
    var rawHorairesDeFermeture =
        map['horaire de fermeture'] as List<dynamic>? ?? [];
    List<String?> horairesDeFermeture =
        rawHorairesDeFermeture.map((e) => e as String?).toList();
    return School(
      id: documentId,
      adresse: map['adresse'],
      codePostal: map['code_postal'],
      nom: map['nom'],
      secteur: map['secteur'],
      ville: map['ville'],
      numeroTel: map['numero_tel'],
      latitude: map['latitude'] ?? 0.0,
      longitude: map['longitude'] ?? 0.0,
      isFavorite: map['isFavorite'] ?? false,
      horairesDeFermeture: horairesDeFermeture,
      rendezVous: rendezVous,
    );
  }
  @override
  toString() {
    return 'School{id: $id, adresse: $adresse, codePostal: $codePostal, nom: $nom, secteur: $secteur, ville: $ville, latitude: $latitude, longitude: $longitude, numeroTel: $numeroTel , isFavorite: $isFavorite, horairesDeFermeture: $horairesDeFermeture, rendezVous: $rendezVous}';
  }
}
