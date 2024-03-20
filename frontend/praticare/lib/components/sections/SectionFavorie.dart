// ignore_for_file: must_be_immutable, file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:praticare/theme/theme.dart' as theme;

class SectionHome extends StatelessWidget {
  String? title;
  String? subtitle;
  bool? isRow;
  final List<Widget?> children;
  bool? showMore;

  SectionHome({
    super.key,
    required this.title,
    this.subtitle,
    required this.children,
    this.isRow,
    this.showMore,
  });

  @override
  Widget build(BuildContext context) {
    isRow == null || isRow == false ? isRow = false : isRow;
    showMore == null || showMore == false ? showMore = false : showMore;
    String titleIsRowIsEmplty = title ?? '';
    if (titleIsRowIsEmplty.isNotEmpty &&
        titleIsRowIsEmplty.toLowerCase().endsWith('s')) {
      titleIsRowIsEmplty =
          titleIsRowIsEmplty.substring(0, titleIsRowIsEmplty.length - 1);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title != null && title!.isNotEmpty
                    ? Text(
                        title!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const SizedBox.shrink(),
                showMore!
                    ? TextButton(
                        onPressed: () {},
                        child: Text(
                          "Voir tout",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.transparent,
                            shadows: [
                              Shadow(
                                  color: theme.primary400,
                                  offset: const Offset(0, -3))
                            ],
                            decoration: TextDecoration.underline,
                            decorationColor: theme.primary400,

                            // Ajouter un soulignement
                          ),
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child: children.isNotEmpty
                  ? SingleChildScrollView(
                      scrollDirection: isRow! ? Axis.horizontal : Axis.vertical,
                      child: isRow!
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: children
                                  .where((widget) => widget != null)
                                  .map((widget) => widget!)
                                  .toList())
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: children
                                  .where((widget) => widget != null)
                                  .map((widget) => widget!)
                                  .toList()),
                    )
                  : Align(
                      child: Center(
                        child: Text(
                          titleIsRowIsEmplty != ''
                              ? "vous n'avez aucun ${titleIsRowIsEmplty.toLowerCase()}s"
                              : "vous n'avez aucun rendez-vous",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    )),
        ],
      ),
    );
  }
}
