// ignore_for_file: unused_import, library_private_types_in_public_api, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:praticare/models/schoolModel.dart';
import 'package:praticare/theme/theme.dart' as theme;
import 'package:intl/intl.dart';

class CardPraticien extends StatefulWidget {
  bool? isInRow;
  final String urlImage;
  School school;

  CardPraticien({
    super.key,
    required this.school,
    required this.urlImage,
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
        ? card = SizedBox(
            width: 150,
            child: Card(
              semanticContainer: true,
              surfaceTintColor: Colors.white,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 3,
              child: InkWell(
                splashColor: theme.violet.withOpacity(0.2),
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                onTap: () {
                  debugPrint(widget.school.id);
                  GoRouter.of(context).push('/school/${widget.school.id}');
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(widget.urlImage),
                        ),
                      ),
                      Text(
                        widget.school.nom,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : card = Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Card(
                semanticContainer: true,
                surfaceTintColor: Colors.white,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 3,
                child: InkWell(
                  splashColor: theme.violet.withOpacity(0.2),
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  onTap: () {
                    debugPrint(widget.school.id);
                    GoRouter.of(context).push('/school/${widget.school.id}');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 13),
                          child: CircleAvatar(
                            radius: 28.0,
                            backgroundImage: NetworkImage(widget.urlImage),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        SizedBox(
                          width: 198,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.school.nom,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                widget.school.secteur,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        widget.school.rendezVousDate != null
                            ? Text(
                                DateFormat('dd/MM/yy')
                                    .format(widget.school.rendezVousDate!),
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                )),
          );
    return card;
  }
}
