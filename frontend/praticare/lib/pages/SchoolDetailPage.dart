// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:booking_calendar/booking_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:praticare/models/schoolModel.dart';
import 'package:praticare/theme/theme.dart' as theme;
import 'package:praticare/utils/firebase_utils.dart';

class SchoolDetailPage extends StatefulWidget {
  final String schoolId;
  const SchoolDetailPage({Key? key, required this.schoolId}) : super(key: key);

  @override
  _SchoolDetailPageState createState() => _SchoolDetailPageState();
}

class _SchoolDetailPageState extends State<SchoolDetailPage> {
  final double iconSize = 30;
  School school = School(
      numeroTel: '',
      id: '',
      adresse: '',
      codePostal: '',
      nom: '',
      secteur: '',
      ville: '',
      latitude: 0.0,
      longitude: 0.0,
      isFavorite: false);
  bool isFavorite = false;
  // BOOKING CALENDAR
  final now = DateTime.now();
  late BookingService mockBookingService;

  @override
  void initState() {
    super.initState();
    getSchoolInfo(widget.schoolId);
    getFavoriteStatus();
    mockBookingService = BookingService(
        serviceName: 'Praticare',
        serviceDuration: 30,
        bookingEnd: DateTime(now.year, now.month, now.day, 18, 0),
        bookingStart: DateTime(now.year, now.month, now.day, 8, 0));
  }

  Future<void> getSchoolInfo(String schoolId) async {
    try {
      // Accéder à la collection où sont stockées les écoles
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('ecole')
          .doc(schoolId)
          .get();
      if (docSnapshot.exists) {
        School currschool = School.fromMap(
            docSnapshot.data() as Map<String, dynamic>, docSnapshot.id);
        school = currschool;
      }
    } catch (e) {
      // Gérer les erreurs éventuelles
      debugPrint("Erreur lors de la récupération de l'école: $e");
    }
  }

  void getFavoriteStatus() async {
    isFavorite = await FirebaseUtils.isFavorite(widget.schoolId);
    setState(() {});
  }

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }

  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));
    converted.add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));
    print('${newBooking.toJson()} has been uploaded');
  }

  List<DateTimeRange> converted = [];

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    ///take care this is only mock, so if you add today as disabledDays it will still be visible on the first load
    ///disabledDays will properly work with real data
    DateTime first = now;
    DateTime tomorrow = now.add(const Duration(days: 1));
    DateTime second = now.add(const Duration(minutes: 55));
    DateTime third = now.subtract(const Duration(minutes: 240));
    DateTime fourth = now.subtract(const Duration(minutes: 500));
    converted.add(
        DateTimeRange(start: first, end: now.add(const Duration(minutes: 30))));
    converted.add(DateTimeRange(
        start: second, end: second.add(const Duration(minutes: 23))));
    converted.add(DateTimeRange(
        start: third, end: third.add(const Duration(minutes: 15))));
    converted.add(DateTimeRange(
        start: fourth, end: fourth.add(const Duration(minutes: 50))));

    //book whole day example
    converted.add(DateTimeRange(
        start: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 5, 0),
        end: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 23, 0)));
    return converted;
  }

  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(
          start: DateTime(now.year, now.month, now.day, 12, 0),
          end: DateTime(now.year, now.month, now.day, 13, 0))
    ];
  }

  @override
  Widget build(BuildContext context) {
    double heightHeader = MediaQuery.of(context).size.height / 3;
    return Scaffold(
        backgroundColor: theme.violetText,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    width: double.infinity,
                    height: heightHeader,
                    child: Column(
                      children: [
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    size: iconSize,
                                  ),
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            // Utilisez Expanded pour forcer les boutons à prendre l'espace minimal, centrant ainsi l'image
                            const Expanded(
                              flex: 4,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 38,
                                  backgroundImage: AssetImage(
                                      'assets/images/ecole_de_medecine.png'),
                                ),
                              ),
                            ),

                            // Mettez les boutons dans un widget pour les grouper ensemble
                            Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: isFavorite
                                      ? Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                          size: iconSize,
                                        )
                                      : Icon(
                                          Icons.favorite_border,
                                          size: iconSize,
                                          color: Colors.white,
                                        ),
                                  onPressed: () {
                                    FirebaseUtils.toggleFavorite(
                                        widget.schoolId);
                                    setState(() {});
                                  },
                                )),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                onPressed: () {
                                  // Partager l'école
                                },
                                icon: Icon(
                                  Icons.info_outline,
                                  size: iconSize,
                                ),
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(school.nom,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 32,
                                  fontWeight: FontWeight.w400)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              school.adresse,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              school.numeroTel,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                  style: TextButton.styleFrom(
                                      fixedSize: const Size(150, 40),
                                      foregroundColor: theme.violetText,
                                      backgroundColor: Colors.white,
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  onPressed: () {},
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.place_outlined),
                                      Text("Afficher le lieu")
                                    ],
                                  )),
                              TextButton(
                                style: TextButton.styleFrom(
                                    fixedSize: const Size(150, 40),
                                    foregroundColor: theme.violetText,
                                    backgroundColor: Colors.white,
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                                onPressed: () {},
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.phone),
                                    Text("Appeler")
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height - heightHeader,
                    child: BookingCalendar(
                      bookingGridChildAspectRatio: 4 / 3,
                      bookingButtonText: "Réserver",
                      bookingButtonColor: theme.violetText,
                      bookedSlotColor: Colors.red,
                      selectedSlotColor: theme.violet,
                      availableSlotColor: theme.violetText,
                      bookedSlotText: "Réservé",
                      selectedSlotText: "Sélectionné",
                      availableSlotText: "Disponible",
                      availableSlotTextStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                      selectedSlotTextStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                      bookedSlotTextStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                      pauseSlotColor: const Color.fromARGB(255, 230, 164, 10),
                      pauseSlotText: "Repos",
                      bookingService: mockBookingService,
                      convertStreamResultToDateTimeRanges:
                          convertStreamResultMock,
                      getBookingStream: getBookingStreamMock,
                      uploadBooking: uploadBookingMock,
                      pauseSlots: generatePauseSlots(),
                      hideBreakTime: false,
                      loadingWidget: const Text('Chargement...'),
                      uploadingWidget: const CircularProgressIndicator(),
                      locale: 'fr_FR',
                      startingDayOfWeek: StartingDayOfWeek.tuesday,
                      wholeDayIsBookedWidget: const Text(
                          'Désolé, ce jour est déjà réservé. Veuillez choisir un autre jour.'),
                      // disabledDates: [DateTime(2023, 1, 20)],
                      // disabledDays: [6, 7],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
