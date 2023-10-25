// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:praticare/components/BtnValidator.dart';

class BottomBar extends StatefulWidget {
  final int selectedIndex;
  const BottomBar({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late int _selectedIndex;
  late Widget? searchBtn;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    _updateSearchBtn();
  }

  void _goRoute(int index) {
    switch (index) {
      case 0:
        GoRouter.of(context).pushNamed("Home");
        break;
      case 1:
        GoRouter.of(context).pushNamed("Favorite");
        break;
      case 2:
        GoRouter.of(context).pushNamed("Account");
        break;
      default:
    }
  }

  void _updateSearchBtn() {
    setState(() {
      if (_selectedIndex == 0) {
        searchBtn = SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BtnValidator(
              icon: Icons.search_sharp,
              text: "Rechercher un praticien",
              activePrimaryTheme: true,
              routeName: "SearchPage",
            ),
          ),
        );
      } else {
        searchBtn = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Wrap(
        children: [
          searchBtn ?? const SizedBox.shrink(),
          // Assuming NavigationBar is a custom widget you've created
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: NavigationBar(
              shadowColor: Colors.black,
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
          ),
        ],
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
    icon: Icon(Icons.favorite_border_outlined),
    selectedIcon: Icon(Icons.favorite_rounded),
    label: 'Favoris',
  ),
  NavigationDestination(
    icon: Icon(Icons.person_outline_rounded),
    selectedIcon: Icon(Icons.person_rounded),
    label: 'Compte',
  ),
];
