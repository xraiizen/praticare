// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:praticare/theme/theme.dart' as theme;

class BtnAccountPage extends StatelessWidget {
  double width;
  double height;
  IconData icon;
  String title;
  String? subtitle;
  void Function()? onTap;

  BtnAccountPage(
      {super.key,
      required this.width,
      required this.height,
      required this.icon,
      required this.title,
      this.subtitle,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: height * (618 / 812) / 7,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(0, 196, 196, 196).withOpacity(0.2),
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 10,
              ),
              Icon(
                icon,
                size: 32,
                color: theme.violetText,
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: width - (width * (100 / 375)) - 55,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      softWrap: false,
                      style: TextStyle(
                        color: theme.violetText,
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle == null
                        ? const SizedBox()
                        : Text(
                            subtitle!,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: theme.vert,
                              fontFamily: "Poppins",
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
