// ignore_for_file: library_private_types_in_public_api

import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:praticare/theme/theme.dart' as theme;
import 'package:unicons/unicons.dart';

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
    TabItem(UniconsLine.home_alt, "Accueil", theme.violetText,
        labelStyle:
            TextStyle(color: theme.violetText, fontWeight: FontWeight.normal)),
    TabItem(UniconsLine.calendar_alt, "Rendez-vous", theme.violetText,
        labelStyle:
            TextStyle(color: theme.violetText, fontWeight: FontWeight.normal)),
    TabItem(UniconsLine.user, "Profil", theme.violetText,
        labelStyle:
            TextStyle(color: theme.violetText, fontWeight: FontWeight.normal)),
    TabItem(UniconsLine.search_alt, "Recherche", theme.violetText,
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
      barHeight: 60,
      circleStrokeWidth: 0,
      circleSize: 55,
      normalIconColor: theme.violetText,
      barBackgroundColor: Colors.white,
      animationDuration: const Duration(milliseconds: 0),
      backgroundBoxShadow: const [
        BoxShadow(
          color: Colors.transparent,
          blurRadius: 10,
        ),
      ],
      selectedCallback: _updateIndex,
    );
  }
}
