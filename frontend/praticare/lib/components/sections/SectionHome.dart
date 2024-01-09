// ignore_for_file: must_be_immutable, file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:praticare/theme/theme.dart' as theme;

class SectionHome extends StatelessWidget {
  final String title;
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
    String titleIsRowIsEmplty = title;
    if (titleIsRowIsEmplty.isNotEmpty &&
        titleIsRowIsEmplty.toLowerCase().endsWith('s')) {
      titleIsRowIsEmplty =
          titleIsRowIsEmplty.substring(0, titleIsRowIsEmplty.length - 1);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w400,
                    color: theme.violetText,
                  ),
                ),
                showMore!
                    ? TextButton(
                        onPressed: () {},
                        child: Text(
                          "Voir tous",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.transparent,
                            shadows: [
                              Shadow(
                                  color: theme.violetText,
                                  offset: const Offset(0, -3))
                            ],
                            decoration: TextDecoration.underline,
                            decorationColor: theme.violetText,

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
                  : Center(
                      child: Text(
                        "vous n'avez aucun ${titleIsRowIsEmplty.toLowerCase()}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    )),
        ],
      ),
    );
  }
}
