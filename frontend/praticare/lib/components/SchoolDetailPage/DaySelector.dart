// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages, file_names, must_be_immutable
import 'package:flutter/material.dart';
import 'package:praticare/models/schoolModel.dart';
import 'package:praticare/theme/theme.dart' as theme;
import 'package:intl/intl.dart' as intl;

class DaySelector extends StatefulWidget {
  final School school;
  const DaySelector({super.key, required this.school});

  @override
  _DaySelectorState createState() => _DaySelectorState();
}

class _DaySelectorState extends State<DaySelector> {
  late School school;
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

  bool isClosed(DateTime day) {
    // Convertit le DateTime en nom de jour
    String dayName = intl.DateFormat('EEEE', "fr_FR").format(day).toLowerCase();
    // Vérifie si le jour est dans la liste des jours de fermeture
    bool result = widget.school.horairesDeFermeture
        .map((e) => e?.toLowerCase())
        .contains(dayName);
    debugPrint("Day: $dayName, isClosed: $result");
    return result;
  }

  Color getColorsText(DateTime date) {
    // Ajout de la vérification pour les jours de fermeture
    if (isClosed(date)) {
      return const Color(0xFFBDBDBD); // Gris pour les jours fermés
    } else if (date.compareTo(DateTime.now()) < 0) {
      return const Color(0xFFBDBDBD); // Gris pour les jours passés
    } else if (date.day == selectedDate.day) {
      return Colors.white; // Blanc pour le jour sélectionné
    } else {
      return Colors.black; // Noir pour les autres jours
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
    school = widget.school;
    debugPrint(school.toString());
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
              print("Day: $day");
              return InkWell(
                onTap: (!isClosed(day) && day.compareTo(DateTime.now()) >= 0)
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
