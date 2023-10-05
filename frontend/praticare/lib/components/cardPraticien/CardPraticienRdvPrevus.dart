// ignore_for_file: unused_import, library_private_types_in_public_api, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:praticare/components/BtnValidator.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:praticare/theme/theme.dart' as theme;

class CardPraticienRdvPrevus extends StatefulWidget {
  final String urlImage;
  final String firstname;
  final String lastname;
  final String metier;
  final String dateRdv;
  final String heureRdv;
  const CardPraticienRdvPrevus({
    super.key,
    required this.urlImage,
    required this.firstname,
    required this.lastname,
    required this.metier,
    required this.dateRdv,
    required this.heureRdv,
  });

  @override
  _CardPraticienRdvPrevusState createState() => _CardPraticienRdvPrevusState();
}

class _CardPraticienRdvPrevusState extends State<CardPraticienRdvPrevus> {
  late Widget card;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onTap: () {
          // RENDEZ VOUS PREVU
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 28.0,
                      backgroundImage: NetworkImage(widget.urlImage),
                      backgroundColor: Colors.transparent,
                    ),
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
                  Column(
                    children: [
                      Text(
                        widget.heureRdv,
                        style: TextStyle(
                            fontSize: 32,
                            color: theme.primary400,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.dateRdv,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              BtnValidator(
                text: ("Afficher le lieu"),
                activePrimaryTheme: false,
                icon: Icons.location_on_outlined,
              )
            ],
          ),
        ),
      ),
    );
  }
}
