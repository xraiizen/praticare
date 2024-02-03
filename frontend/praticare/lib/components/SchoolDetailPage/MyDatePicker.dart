// ignore_for_file: library_private_types_in_public_api
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:praticare/theme/theme.dart' as theme;

class MyDatePicker extends StatefulWidget {
  const MyDatePicker({super.key});

  @override
  _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  List<TimeOfDay> timeSlots = [];
  int crossAxisCount = 3;
  double childAspectRatio = 3 / 1.5;
  TimeOfDay? selectedTime;
  DateTime selectedDate = DateTime.now();
  List<String> months = [
    "Janvier",
    "Février",
    "Mars",
    "Avril",
    "Mai",
    "Juin",
    "Juillet",
    "Août",
    "Septembre",
    "Octobre",
    "Novembre",
    "Décembre"
  ];
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text(
              "${months[selectedDate.month - 1]} ${selectedDate.year}",
              style: TextStyle(
                  color: theme.violetText,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
            onTap: () => _selectMonth(context),
          ),
          SizedBox(
            height: 75,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: daysInMonth(selectedDate),
              itemBuilder: (context, index) {
                DateTime day =
                    DateTime(selectedDate.year, selectedDate.month, index + 1);
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedDate = day;
                    });
                  },
                  child: Container(
                    width: 55,
                    height: 75,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: day.day == selectedDate.day
                          ? theme.violetText
                          : Colors.white54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Center(
                        child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${day.day}\n", // Numéro du jour
                            style: TextStyle(
                              fontSize: 18,
                              color: day.day == selectedDate.day
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight
                                  .bold, // Optionnel pour mettre en évidence
                            ),
                          ),
                          TextSpan(
                            text: DateFormat('EEEE', "fr_FR")
                                .format(day)
                                .substring(0, 3), // Nom du jour
                            style: TextStyle(
                              fontSize:
                                  12, // Taille plus petite pour le nom du jour
                              color: day.day == selectedDate.day
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )),
                  ),
                );
              },
            ),
          ),
          // Créneaux horaires et lignes pointillées
          Container(
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _selectMonth(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          title: Text(
            "Choisir un mois",
            style: TextStyle(color: theme.violetText),
          ),
          content: Container(
            color: Colors.white,
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: months.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(months[index]),
                  onTap: () {
                    setState(() {
                      selectedDate = DateTime(
                          selectedDate.year, index + 1, selectedDate.day);
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  int daysInMonth(DateTime date) {
    var firstDayThisMonth = DateTime(date.year, date.month, 1);
    var firstDayNextMonth = (date.month == 12)
        ? DateTime(date.year + 1, 1, 1)
        : DateTime(date.year, date.month + 1, 1);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
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
