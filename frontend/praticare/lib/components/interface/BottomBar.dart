// ignore_for_file: unused_import, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:praticare/components/interface/BtnBottomBar.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:praticare/theme/theme.dart' as theme;

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          color: Colors.white,
          child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BtnBottomBar(
                  title: "Accueil",
                  icon: Icons.home,
                  routeName: "Home",
                ),
                BtnBottomBar(
                    title: "Favories",
                    icon: Icons.star_outline_rounded,
                    routeName: "Favorite"),
                BtnBottomBar(
                    title: "Compte",
                    icon: Icons.person_outlined,
                    routeName: "Account")
              ]),
        ));
  }
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 10),
  //     child: SalomonBottomBar(
  //       backgroundColor: Colors.white,
  //       currentIndex: _currentIndex,
  //       onTap: (i) => setState(() => _currentIndex = i),
  //       items: [
  //         /// Home
  //         SalomonBottomBarItem(
  //           icon: const Icon(
  //             Icons.home,
  //             size: 32,
  //           ),
  //           title: const Text("Accueil"),
  //           selectedColor: theme.primary400,
  //         ),

  //         /// Likes
  //         SalomonBottomBarItem(
  //           icon: const Icon(
  //             Icons.star_outline_rounded,
  //             size: 32,
  //           ),
  //           title: const Text("Favoris"),
  //           selectedColor: theme.primary400,
  //         ),

  //         /// Profile
  //         SalomonBottomBarItem(
  //           icon: const Icon(
  //             Icons.person_outlined,
  //             size: 32,
  //           ),
  //           title: const Text("Compte"),
  //           selectedColor: theme.primary400,
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
