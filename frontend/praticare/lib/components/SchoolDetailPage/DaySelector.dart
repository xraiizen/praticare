// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages, file_names, must_be_immutable
import 'package:flutter/material.dart';
import 'package:praticare/models/schoolModel.dart';
import 'package:praticare/theme/theme.dart' as theme;
import 'package:intl/intl.dart' as intl;

class DaySelector extends StatefulWidget {
  final School school;
  final Function(DateTime) onDaySelected;
  final DateTime selectedDay;
  const DaySelector(
      {super.key,
      required this.school,
      required this.onDaySelected,
      required this.selectedDay});

  @override
  _DaySelectorState createState() => _DaySelectorState();
}

class _DaySelectorState extends State<DaySelector> {
  late School school;
  late DateTime selectedDate;
  ScrollController _scrollController = ScrollController();
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
    selectedDate = widget.selectedDay;
    school = widget.school;
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollToCurrentDay());
  }

  Color getColorsText(DateTime date) {
    // Obtenez la date actuelle sans l'heure
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime selectedDay =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
    date = DateTime(date.year, date.month,
        date.day); // Assurez-vous que date n'a pas d'heure

    // Conversion du jour de la semaine en nom complet
    String dayName =
        intl.DateFormat('EEEE', 'fr_FR').format(date).toLowerCase();

    // Vérification si le jour est passé ou est un jour de fermeture
    if (date.isBefore(today) || school.horairesDeFermeture.contains(dayName)) {
      return const Color(
          0xFFBDBDBD); // Gris pour les jours passés et les jours de fermeture
    } else if (date.isAtSameMomentAs(selectedDay)) {
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
                      widget.onDaySelected(selectedDate);
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

  void scrollToCurrentDay() {
    // Calculez la position à laquelle vous souhaitez faire défiler
    int dayIndex = DateTime.now().day - 1; // Index du jour actuel dans le mois
    double scrollPosition =
        dayIndex * 55.0; // Remplacez 55.0 par la largeur de votre item + margin
    _scrollController.animateTo(
      scrollPosition,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose(); // N'oubliez pas de disposer le contrôleur
    super.dispose();
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
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: daysInMonth(selectedDate),
            itemBuilder: (context, index) {
              DateTime day =
                  DateTime(selectedDate.year, selectedDate.month, index + 1);
              String dayName =
                  intl.DateFormat('EEEE', 'fr_FR').format(day).toLowerCase();

// Obtenez la date actuelle sans l'heure pour une comparaison juste des dates
              DateTime now = DateTime.now();
              DateTime today = DateTime(now.year, now.month, now.day);
              day = DateTime(day.year, day.month, day.day);
              return InkWell(
                onTap: () {
                  // Activez le onTap seulement si le jour n'est pas passé et n'est pas un jour de fermeture
                  if (!day.isBefore(today) &&
                      !school.horairesDeFermeture.contains(dayName)) {
                    setState(() {
                      selectedDate = day;
                    });
                    widget.onDaySelected(day);
                  }
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
