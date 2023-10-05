// ignore_for_file: unused_import, library_private_types_in_public_api, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:praticare/components/BtnValidator.dart';
import 'package:praticare/components/interface/BtnBottomBar.dart';
import 'package:praticare/theme/theme.dart' as theme;

class BottomBar extends StatefulWidget {
  int selectedIndex;
  BottomBar({super.key, required this.selectedIndex});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  Widget? searchBtn;
  void goRoute(int index) {
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

  void showBtnSearch() {
    if (widget.selectedIndex == 0) {
      searchBtn = Container(
        width: double.infinity,
        alignment: Alignment.bottomCenter,
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
    }
  }

  @override
  Widget build(BuildContext context) {
    showBtnSearch();
    return Wrap(
      children: [
        // Bouton fixe au-dessus de la barre de navigation
        searchBtn ?? const SizedBox.shrink(),
        // Barre de navigation avec les trois boutons principaux
        NavigationBar(
          animationDuration: const Duration(seconds: 1),
          selectedIndex: widget.selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              widget.selectedIndex = index;
            });
            goRoute(index);
          },
          destinations: _navBarItems,
        ),
      ],
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
