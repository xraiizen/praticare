// ignore_for_file: library_private_types_in_public_api

import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:praticare/theme/theme.dart' as theme;

class CircularBottomBar extends StatefulWidget {
  final int selectedIndex;
  const CircularBottomBar({Key? key, required this.selectedIndex})
      : super(key: key);

  @override
  _CircularBottomBarState createState() => _CircularBottomBarState();
}

class _CircularBottomBarState extends State<CircularBottomBar> {
  late CircularBottomNavigationController _navigationController;
  late int _selectedIndex;
  List<TabItem> tabItems = List.of([
    TabItem(Icons.home, "Accueil", theme.violetText,
        labelStyle:
            TextStyle(color: theme.violetText, fontWeight: FontWeight.normal)),
    TabItem(Icons.calendar_today, "Rendez-vous", theme.violetText,
        labelStyle:
            TextStyle(color: theme.violetText, fontWeight: FontWeight.normal)),
    TabItem(Icons.person_outline, "Profil", theme.violetText,
        labelStyle:
            TextStyle(color: theme.violetText, fontWeight: FontWeight.normal)),
    TabItem(Icons.search, "Recherche", theme.violetText,
        labelStyle:
            TextStyle(color: theme.violetText, fontWeight: FontWeight.normal)),
  ]);

  @override
  void initState() {
    super.initState();
    _navigationController =
        CircularBottomNavigationController(widget.selectedIndex);
    _selectedIndex = widget.selectedIndex;
  }

  void _updateIndex(int? index) {
    setState(() {
      if (index != null) {
        _selectedIndex = index;
        switch (_selectedIndex) {
          case 0:
            GoRouter.of(context).pushNamed("Home");
            break;
          case 1:
            GoRouter.of(context).pushNamed("Appointment");
            break;
          case 2:
            GoRouter.of(context).pushNamed("Account");
            break;
          case 3:
            GoRouter.of(context).pushNamed("SearchMapPage");
            break;
          default:
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      barHeight: 70,
      circleStrokeWidth: 0,
      normalIconColor: theme.violetText,
      backgroundBoxShadow: [
        BoxShadow(
          color: const Color.fromARGB(0, 196, 196, 196).withOpacity(0.2),
          blurRadius: 10,
        ),
      ],
      selectedCallback: _updateIndex,
    );
  }
}
