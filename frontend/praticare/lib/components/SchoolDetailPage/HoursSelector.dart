// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:praticare/models/schoolModel.dart';
import 'package:praticare/theme/theme.dart' as theme;

class HoursSelector extends StatefulWidget {
  final School school;
  final DateTime selectedDay;
  final Function(TimeOfDay) onTimeSelected;
  const HoursSelector(
      {super.key,
      required this.school,
      required this.selectedDay,
      required this.onTimeSelected});

  @override
  _HoursSelectorState createState() => _HoursSelectorState();
}

class _HoursSelectorState extends State<HoursSelector> {
  late School school;
  List<TimeOfDay> timeSlots = [];
  TimeOfDay? selectedTime;
  List<DateTime> takenTimeSlots = [];
  bool? isLoadingAppointments;
  bool? hasError;

  @override
  void initState() {
    super.initState();
    school = widget.school;
    addTimeSlot();
  }

  @override
  void didUpdateWidget(covariant HoursSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDay != oldWidget.selectedDay) {
      setState(() {
        selectedTime = null;
      });
    }
  }

  void addTimeSlot() {
    for (var i = 9; i <= 18; i++) {
      for (var j = 0; j < 60; j += 30) {
        setState(() {
          timeSlots.add(TimeOfDay(hour: i, minute: j));
        });
      }
    }
  }

  Stream<List<DateTime>> createAppointmentsStream() {
    return FirebaseFirestore.instance
        .collection('ecole')
        .doc(widget.school.id)
        .snapshots()
        .map((DocumentSnapshot document) {
      List<dynamic> rendezVousList = document['rendez-vous'];
      List<DateTime> appointmentDates = [];
      for (var rendezVous in rendezVousList) {
        rendezVous.forEach((userId, timestamp) {
          DateTime appointmentDate = (timestamp as Timestamp).toDate();
          if (appointmentDate.year == widget.selectedDay.year &&
              appointmentDate.month == widget.selectedDay.month &&
              appointmentDate.day == widget.selectedDay.day) {
            appointmentDates.add(appointmentDate);
          }
        });
      }
      return appointmentDates;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DateTime>>(
      stream: createAppointmentsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          hasError = true;
          return SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: Align(
                  alignment: Alignment.center,
                  child: Center(
                      child: Center(
                          child: CircularProgressIndicator(
                    color: theme.violetText,
                  )))));
        }
        if (snapshot.hasError) {
          hasError = true;
          return SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: const Align(
              alignment: Alignment.center,
              child: Center(
                  child: Text(
                'Auncun rendez-vous de disponible\n pour le moment !',
                textAlign: TextAlign.center,
              )),
            ),
          );
        }
        if (snapshot.hasData) {
          hasError = false;
          // Mettre à jour la liste des créneaux pris avec les données du stream
          takenTimeSlots = snapshot.data!;
        }

        // Continuez à construire l'interface utilisateur en utilisant takenTimeSlots
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            semanticChildCount: timeSlots.length,
            children: [
              StaggeredGrid.count(
                crossAxisCount: 3,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                children: [
                  for (var i = 0; i < timeSlots.length; i++)
                    StaggeredGridTile.count(
                      crossAxisCellCount: i % 7 != 0 ? 1 : 3,
                      mainAxisCellCount: i % 7 != 0 ? 0.5 : 0.3,
                      child: i % 7 != 0
                          ? timeSlotWidget(timeSlots[i]) // Créneaux horaires
                          : Row(
                              children: [
                                Text(
                                  "${timeSlots[i].hour}h   ",
                                  style: TextStyle(color: theme.violetText),
                                ),
                                MySeparator(
                                  color: theme.violetText,
                                ),
                              ],
                            ),
                    ),
                ],
              ),
              const SizedBox(height: 100),
            ],
          ),
        );
      },
    );
  }

  Widget timeSlotWidget(TimeOfDay slot) {
    bool isSelected = selectedTime == slot;
    bool isTaken = takenTimeSlots.any((DateTime takenSlot) =>
        takenSlot.year == widget.selectedDay.year &&
        takenSlot.month == widget.selectedDay.month &&
        takenSlot.day == widget.selectedDay.day &&
        takenSlot.hour == slot.hour &&
        takenSlot.minute == slot.minute);
    return InkWell(
      onTap: !isTaken
          ? () {
              setState(() {
                selectedTime = slot;
              });
              widget.onTimeSelected(slot);
            }
          : null,
      child: Container(
        height: 25,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: !isTaken
              ? isSelected
                  ? theme.violetText
                  : Colors.white
              : const Color(0xFFBDBDBD),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            slot.format(context),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: !isTaken
                  ? isSelected
                      ? Colors.white
                      : Colors.black
                  : const Color.fromARGB(207, 87, 87, 87),
            ),
          ),
        ),
      ),
    );
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxWidth = constraints.constrainWidth();
          const dashWidth = 10.0;
          final dashHeight = height;
          final dashCount = (boxWidth / (2 * dashWidth)).floor();
          return Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
