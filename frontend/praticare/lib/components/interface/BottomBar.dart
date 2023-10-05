// ignore_for_file: unused_import, library_private_types_in_public_api, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:praticare/components/interface/BtnBottomBar.dart';
import 'package:praticare/theme/theme.dart' as theme;

class BottomBar extends StatefulWidget {
  int selectedIndex;
  BottomBar({super.key, required this.selectedIndex});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  void goRoute(int index) {
    switch (index) {
      case 0:
        GoRouter.of(context).goNamed("Home");
        break;
      case 1:
        GoRouter.of(context).goNamed("Favorite");
        break;
      case 2:
        GoRouter.of(context).goNamed("Account");
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      animationDuration: const Duration(seconds: 1),
      selectedIndex: widget.selectedIndex,
      onDestinationSelected: (index) {
        setState(() {
          widget.selectedIndex = index;
        });
        goRoute(index);
      },
      destinations: _navBarItems,
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
    label: 'Favories',
  ),
  NavigationDestination(
    icon: Icon(Icons.person_outline_rounded),
    selectedIcon: Icon(Icons.person_rounded),
    label: 'Compte',
  ),
];
  //   return Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 10),
  //       child: Container(
  //         width: MediaQuery.of(context).size.width,
  //         height: 50,
  //         color: Colors.white,
  //         child: const Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               BtnBottomBar(
  //                 title: "Accueil",
  //                 icon: Icons.home,
  //                 routeName: "Home",
  //               ),
  //               BtnBottomBar(
  //                   title: "Favories",
  //                   icon: Icons.star_outline_rounded,
  //                   routeName: "Favorite"),
  //               BtnBottomBar(
  //                   title: "Compte",
  //                   icon: Icons.person_outlined,
  //                   routeName: "Account")
  //             ]),
  //       ));
  // }
// }
