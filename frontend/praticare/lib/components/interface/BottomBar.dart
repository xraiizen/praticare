// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:praticare/theme/theme.dart' as theme;

class BottomBar extends StatefulWidget {
  final int selectedIndex;
  const BottomBar({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late int _selectedIndex;
  late Widget searchBtn;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _goRoute(int index) {
    switch (index) {
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

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: NavigationBar(
        shadowColor: theme.violet,
        surfaceTintColor: theme.violet,
        indicatorColor: theme.violet,
        animationDuration: const Duration(seconds: 1),
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _goRoute(index);
        },
        destinations: _navBarItems,
      ),
    );
  }
}

const _navBarItems = [
  NavigationDestination(
    icon: Icon(Icons.home_outlined),
    selectedIcon: Icon(Icons.home_rounded),
    label: 'Accueil',
  ),
  NavigationDestination(
    icon: Icon(Icons.calendar_today_outlined),
    selectedIcon: Icon(Icons.calendar_today_rounded),
    label: 'Rendez-vous',
  ),
  NavigationDestination(
    icon: Icon(Icons.person_outline_rounded),
    selectedIcon: Icon(Icons.person_rounded),
    label: 'Profil',
  ),
  NavigationDestination(
    icon: Icon(Icons.search_outlined),
    selectedIcon: Icon(Icons.search_rounded),
    label: 'Recherche',
  ),
];

class AnimatedBottomAppBar extends StatefulWidget {
  final int selectedIndex;
  const AnimatedBottomAppBar({
    super.key,
    required this.selectedIndex,
  });
  @override
  _AnimatedBottomAppBarState createState() => _AnimatedBottomAppBarState();
}

class _AnimatedBottomAppBarState extends State<AnimatedBottomAppBar>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  final List<IconData> _selectedIcons = [
    Icons.home, // Selected icon for first tab
    Icons.calendar_today, // Selected icon for first tab
    Icons.person, // Selected icon for second tab
    Icons.search, // Selected icon for third tab
  ];
  final List<IconData> _unselectedIcons = [
    Icons.home_outlined, // Unselected icon for first tab
    Icons.calendar_today_outlined, // Unselected icon for second tab
    Icons.person_outline, // Unselected icon for second tab
    Icons.search_outlined, // Unselected icon for third tab
  ];

  final List<String> _labels = [
    "Accueil",
    "Rendez-vous",
    "Profil",
    "Recherche",
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _updateIndex(int index) {
    setState(() {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    const double iconSize = 32.0; // Taille de l'icône
    const double buttonPadding = 24.0; // Espace autour de l'icône
    const double selecedUpperSize = 3; // Taille de l'icône sélectionnée
    Color violetColor =
        theme.violetText; // Remplacez par la couleur violette de votre thème

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(40.0),
        topRight: Radius.circular(40.0),
      ),
      child: BottomAppBar(
        height: 95,
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(4, (index) {
            bool isSelected = _selectedIndex == index;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: isSelected
                      ? (buttonPadding + selecedUpperSize) * 2
                      : buttonPadding * 2,
                  height: isSelected
                      ? (buttonPadding + selecedUpperSize) * 2
                      : buttonPadding * 2,
                  decoration: BoxDecoration(
                    color: isSelected ? violetColor : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      isSelected
                          ? _selectedIcons[index]
                          : _unselectedIcons[index],
                      color: isSelected ? Colors.white : violetColor,
                      size: isSelected ? iconSize + selecedUpperSize : iconSize,
                    ),
                    onPressed: () => _updateIndex(index),
                  ),
                ),
                !isSelected
                    ? Text(
                        _labels[index],
                        style: TextStyle(
                          color: violetColor,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            );
          }),
        ),
      ),
    );
  }
}
