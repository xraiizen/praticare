// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:praticare/theme/theme.dart' as theme;

class BtnValidator extends StatelessWidget {
  late String text;
  late String? routeName;
  bool activePrimaryTheme;
  IconData? icon;
  double? sizeIcon;
  BtnValidator(
      {super.key,
      required this.text,
      this.routeName,
      required this.activePrimaryTheme,
      this.icon});

  @override
  Widget build(BuildContext context) {
    final bool areIcon = icon != null;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                (Set<MaterialState> states) {
              return const EdgeInsets.all(0);
            }),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return activePrimaryTheme ? theme.primary400 : theme.grey950;
              },
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: theme.primary400))),
          ),
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: areIcon
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(
                            icon,
                            size: sizeIcon ?? 24,
                            color: activePrimaryTheme
                                ? Colors.white
                                : theme.primary400,
                          ),
                        ),
                        Text(
                          text,
                          style: TextStyle(
                            color: activePrimaryTheme
                                ? Colors.white
                                : theme.primary400,
                            fontSize: 16.0,
                          ),
                        )
                      ],
                    )
                  : Text(
                      text,
                      style: TextStyle(
                        color: activePrimaryTheme
                            ? Colors.white
                            : theme.primary400,
                        fontSize: 16.0,
                      ),
                    )),
          onPressed: () {
            if (routeName != null) {
              GoRouter.of(context).pushNamed(routeName!);
            }
          },
        ),
      ),
    );
  }
}
