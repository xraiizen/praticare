// ignore_for_file: library_private_types_in_public_api, file_names
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:praticare/components/SchoolDetailPage/DaySelector.dart';
import 'package:praticare/components/SchoolDetailPage/HoursSelector.dart';
import 'package:praticare/models/schoolModel.dart';

class MyDatePicker extends StatefulWidget {
  final School school;
  const MyDatePicker({super.key, required this.school});

  @override
  _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Jours de la semaine
          DaySelector(
            school: widget.school,
          ),
          // Créneaux horaires et lignes pointillées
          HoursSelector(
            school: widget.school,
          ),
        ],
      ),
    );
  }
}
