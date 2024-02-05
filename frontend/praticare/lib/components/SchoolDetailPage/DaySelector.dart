// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages, file_names, must_be_immutable
import 'package:flutter/material.dart';
import 'package:praticare/models/schoolModel.dart';
import 'package:praticare/theme/theme.dart' as theme;
import 'package:intl/intl.dart' as intl;

class DaySelector extends StatefulWidget {
  final School school;
  DaySelector({super.key, required this.school});

  @override
  _DaySelectorState createState() => _DaySelectorState();
}

class _DaySelectorState extends State<DaySelector> {
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

  Color getColorsText(DateTime date) {
    if (date.day.compareTo(DateTime.now().day) < 0) {
      return const Color(0xFFBDBDBD);
    } else if (date.day == selectedDate.day) {
      return Colors.white;
    } else {
      return Colors.black;
    }
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                onTap: day.day.compareTo(DateTime.now().day) >= 0
                    ? () {
                        setState(() {
                          // TODO FETCH DISPONIBILITE FOR THIS DAY
                          selectedDate = day;
                        });
                      }
                    : null,
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
                            color: getColorsText(day),
                            fontWeight: FontWeight
                                .bold, // Optionnel pour mettre en évidence
                          ),
                        ),
                        TextSpan(
                          text: intl.DateFormat('EEEE', "fr_FR")
                              .format(day)
                              .substring(0, 3), // Nom du jour
                          style: TextStyle(
                            fontSize:
                                12, // Taille plus petite pour le nom du jour
                            color: getColorsText(day),
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
      ],
    );
  }
}
