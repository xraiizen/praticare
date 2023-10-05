// ignore_for_file: unused_import, library_private_types_in_public_api, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:praticare/theme/theme.dart' as theme;

class CardPraticien extends StatefulWidget {
  bool? isInRow;
  final String urlImage;
  final String firstname;
  final String lastname;
  final String metier;
  final String dateRdvPasser;
  CardPraticien({
    super.key,
    required this.urlImage,
    required this.firstname,
    required this.lastname,
    required this.metier,
    required this.dateRdvPasser,
    this.isInRow,
  });

  @override
  _CardPraticienState createState() => _CardPraticienState();
}

class _CardPraticienState extends State<CardPraticien> {
  late Widget card;
  @override
  Widget build(BuildContext context) {
    widget.isInRow == null || widget.isInRow == false
        ? widget.isInRow = false
        : widget.isInRow;
    widget.isInRow!
        ? card = Card(
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: CircleAvatar(
                        radius: 54.0,
                        backgroundImage: NetworkImage(widget.urlImage),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Text(
                      widget.firstname,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      widget.lastname,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : card = Card(
            child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 28.0,
                    backgroundImage: NetworkImage(widget.urlImage),
                    backgroundColor: Colors.transparent,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.firstname} ${widget.lastname}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.metier,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Text(
                    widget.dateRdvPasser,
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ));
    return card;
  }
}
