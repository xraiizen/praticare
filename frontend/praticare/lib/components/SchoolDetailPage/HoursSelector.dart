// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:praticare/models/schoolModel.dart';
import 'package:praticare/theme/theme.dart' as theme;

class HoursSelector extends StatefulWidget {
  final School school;
  const HoursSelector({super.key, required this.school});

  @override
  _HoursSelectorState createState() => _HoursSelectorState();
}

class _HoursSelectorState extends State<HoursSelector> {
  List<TimeOfDay> timeSlots = [];
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    addTimeSlot();
  }

  void addTimeSlot() {
    for (var i = 9; i < 24; i++) {
      for (var j = 0; j < 60; j += 30) {
        setState(() {
          timeSlots.add(TimeOfDay(hour: i, minute: j));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        semanticChildCount: timeSlots.length,
        children: [
          Expanded(
            child: StaggeredGrid.count(
              crossAxisCount: 3,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              children: [
                for (var i = 0; i < timeSlots.length; i++)
                  i % 7 != 0
                      ? StaggeredGridTile.count(
                          crossAxisCellCount: 1,
                          mainAxisCellCount: 0.5,
                          child: timeSlotWidget(timeSlots[i]),
                        )
                      : StaggeredGridTile.count(
                          crossAxisCellCount: 3,
                          mainAxisCellCount: 0.3,
                          child: Row(
                            children: [
                              Text(
                                "${timeSlots[i].hour}h   ",
                                style: TextStyle(color: theme.violetText),
                              ),
                              MySeparator(
                                color: theme.violetText,
                              ),
                            ],
                          )),
              ],
            ),
          ),
          const SizedBox(height: 100)
        ],
      ),
    );
  }

  Widget timeSlotWidget(TimeOfDay slot) {
    bool isSelected = selectedTime == slot;
    return InkWell(
      onTap: () {
        setState(() {
          selectedTime = slot;
        });
      },
      child: Container(
        height: 25,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isSelected ? theme.violetText : Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            slot.format(context),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.black,
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
