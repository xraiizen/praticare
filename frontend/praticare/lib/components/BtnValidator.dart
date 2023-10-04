// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:praticare/theme/theme.dart' as theme;

class BtnValidator extends StatelessWidget {
  late String text;
  late String? routeName;
  bool activePrimaryTheme;
  BtnValidator(
      {super.key,
      required this.text,
      this.routeName,
      required this.activePrimaryTheme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: TextButton(
        onPressed: () {
          if (routeName != null) {
            GoRouter.of(context).goNamed(routeName!);
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return activePrimaryTheme ? theme.grey950 : theme.primary400;
              } else {
                return activePrimaryTheme ? theme.primary400 : theme.grey950;
              }
            },
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            return const Color.fromARGB(0, 0, 0, 0);
          }),
          padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
              (Set<MaterialState> states) {
            return const EdgeInsets.all(0);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: theme.primary400))),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: activePrimaryTheme ? Colors.white : theme.primary400,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
