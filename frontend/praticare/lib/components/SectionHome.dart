// ignore_for_file: must_be_immutable, file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:praticare/theme/theme.dart' as theme;

class SectionHome extends StatelessWidget {
  final String title;
  bool? isRow;
  final List<Widget> children;
  bool? showMore;

  SectionHome({
    super.key,
    required this.title,
    required this.children,
    this.isRow,
    this.showMore,
  });

  @override
  Widget build(BuildContext context) {
    isRow == null || isRow == false ? isRow = false : isRow;
    showMore == null || showMore == false ? showMore = false : showMore;
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
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
              child: SingleChildScrollView(
                scrollDirection: isRow! ? Axis.horizontal : Axis.vertical,
                child: isRow!
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: children)
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: children),
              )),
        ],
      ),
    );
  }
}
