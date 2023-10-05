// ignore_for_file: unused_import, library_private_types_in_public_api, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:praticare/theme/theme.dart' as theme;

class CardPraticienResultat extends StatefulWidget {
  final String urlImage;
  final String firstname;
  final String lastname;
  final String metier;
  final String dateRdvPasser;
  CardPraticienResultat({
    super.key,
    required this.urlImage,
    required this.firstname,
    required this.lastname,
    required this.metier,
    required this.dateRdvPasser,
  });

  @override
  _CardPraticienResultatState createState() => _CardPraticienResultatState();
}

class _CardPraticienResultatState extends State<CardPraticienResultat> {
  late Widget card;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
          child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
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
                  const SizedBox(
                    width: 50,
                  ),
                ],
              ),
              const Divider(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.timer),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      "Prochain créneau Demain",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
