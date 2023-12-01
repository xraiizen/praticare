// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});
  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Information'),
          content: const Text('Ceci est une bulle d\'info'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20.0),
        bottomRight: Radius.circular(20.0),
      ),
      child: AppBar(
        backgroundColor: const Color.fromARGB(186, 255, 255, 255),
        automaticallyImplyLeading: false,
        // flexibleSpace: Container(
        //     decoration: const BoxDecoration(
        //   backgroundBlendMode: BlendMode.colorBurn,
        //   gradient: LinearGradient(
        //     begin: Alignment.centerLeft,
        //     end: Alignment.centerRight,
        //     colors: <Color>[
        //       Color.fromARGB(255, 35, 87, 139),
        //       Color.fromARGB(255, 187, 213, 237),
        //       Color.fromARGB(255, 255, 114, 194),
        //     ],
        //   ),
        // )),
        title: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/Logo.svg", width: 200),
                IconButton(
                    onPressed: () {
                      _showInfoDialog(context);
                    },
                    icon: const Icon(
                      Icons.info_outline_rounded,
                      size: 34,
                    ))
              ]),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
