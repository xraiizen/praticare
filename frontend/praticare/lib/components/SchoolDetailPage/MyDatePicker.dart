// ignore_for_file: library_private_types_in_public_api, file_names, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:praticare/components/SchoolDetailPage/DaySelector.dart';
import 'package:praticare/components/SchoolDetailPage/HoursSelector.dart';
import 'package:praticare/models/schoolModel.dart';

class MyDatePicker extends StatefulWidget {
  final School school;
  final Function(DateTime?) onDateTimeSelected;
  const MyDatePicker(
      {super.key, required this.school, required this.onDateTimeSelected});

  @override
  _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  DateTime selectedDay = DateTime.now();
  TimeOfDay? selectedTime;
  void onDaySelected(DateTime day) {
    setState(() {
      selectedDay = day;
      selectedTime = null;
      combineDateTime(selectedDay, selectedTime);
    });
  }

  void onTimeSelected(TimeOfDay time) {
    setState(() {
      selectedTime = time;
      combineDateTime(selectedDay, selectedTime!);
    });
  }

  void combineDateTime(DateTime? _selectedDay, TimeOfDay? _selectedTime) {
    try {
      if (_selectedDay == null || _selectedTime == null) {
        widget.onDateTimeSelected(null);
      }

      final DateTime combinedDateTime = DateTime(
        selectedDay.year,
        selectedDay.month,
        selectedDay.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );

      widget.onDateTimeSelected(combinedDateTime);
    } catch (e) {
      debugPrint("Error combining date and time: $e");
    }
  }

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
            selectedDay: selectedDay,
            onDaySelected: onDaySelected,
          ),
          // Créneaux horaires et lignes pointillées
          HoursSelector(
            school: widget.school,
            selectedDay: selectedDay,
            onTimeSelected: onTimeSelected,
          ),
        ],
      ),
    );
  }
}
