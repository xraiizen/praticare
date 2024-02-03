import 'package:cloud_firestore/cloud_firestore.dart';

class Disponibilite {
  final String id;
  final DateTime date;
  final List<String> heures;

  Disponibilite({required this.id, required this.date, required this.heures});

  factory Disponibilite.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    List<String> heures = List<String>.from(data['Heure']);
    return Disponibilite(
      id: doc.id,
      date: (data['Date'] as Timestamp).toDate(),
      heures: heures,
    );
  }
}
