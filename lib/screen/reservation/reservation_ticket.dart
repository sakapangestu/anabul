// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/component/button/rectangle/rectangle_orange_disabled.dart';
// import 'package:anabulhotel/component/pet/pet_list.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
// import 'package:anabulhotel/screen/pet/pet_create.dart';
// import 'package:anabulhotel/screen/hotel_pet/hotel_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../api/api_service.dart';
import '../../component/app_bar/app_bar_tittle.dart';
import '../../component/app_bar/app_bar_tittle_menu_bar.dart';
import '../../component/history/reservation/history_ticket.dart';
import '../../component/history/reservation/reservation_ticket/detail_pet.dart';
import '../../helper/global_colors.dart';
import '../../model/data.dart';

class ReservationTicket extends StatefulWidget {
  const ReservationTicket(
      {Key? key,
      required this.hotel,
      required this.historyReservationDetails,
      required this.idReservation,
      required this.startDate,
      required this.endDate,
      required this.user})
      : super(key: key);
  final String idReservation;
  final String startDate;
  final String endDate;
  final Map hotel;
  final Map user;
  final List<dynamic> historyReservationDetails;
  @override
  State<ReservationTicket> createState() => _ReservationTicket();
}

class _ReservationTicket extends State<ReservationTicket> {
  GlobalColors globalColors = GlobalColors();
  String defaultImage = BaseImage.getImageHotel();
  String defaultPet = BaseImage.getImagePet();
  List<Map<String, dynamic>> ratings = [];

  @override
  void initState() {
    super.initState();
    fetchRatings();
  }

  Future<void> fetchRatings() async {
    try {
      List<Map<String, dynamic>> fetchedRatings =
          await Rating.getRatingHotel(widget.hotel['id_hotel']);
      print("aaa: $fetchedRatings");
      setState(() {
        ratings = fetchedRatings;
        print("ratings: $ratings");
      });
    } catch (error) {
      print('Error fetching ratings: $error');
      // Handle appropriate action if there's an error fetching ratings
    }
  }

  double calculateAverageRating(List<Map<String, dynamic>> ratings) {
    if (ratings.isEmpty) return 0.0;

    double sum = 0.0;
    for (var rating in ratings) {
      sum += rating['star'];
    }
    return sum / ratings.length;
  }

  @override
  Widget build(BuildContext context) {
    double averageRating = calculateAverageRating(ratings);
    final id = widget.idReservation;
    final hotel = widget.hotel;
    final user = widget.user;
    final start = widget.startDate;
    final end = widget.endDate;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, '/dashboardPageView');
          },
        ),
        backgroundColor: const Color(0xffDC822A),
        flexibleSpace: const SafeArea(
          child: AppBarTitle(
            title: "Tiket Reservasi",
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          // color: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Container(
            // color: Colors.blue,
            child: Column(
              children: [
                HistoryTicket(
                    title: 'Tiket Reservasi',
                    id: id,
                    hotel: hotel,
                    user: user,
                    start: start,
                    end: end,
                    rating: averageRating.toString()),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Detail Hewan",
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: globalColors.textBlackBold,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: ListView.builder(
                      itemCount: widget.historyReservationDetails.length,
                      itemBuilder: (context, index) {
                        final reservation_details =
                            widget.historyReservationDetails[index];
                        final pet = reservation_details['pet'];
                        final String petName = pet['name'];
                        final String petImage = pet['image'];
                        print("data petku bos: $reservation_details");
                        DateTime birthDate =
                            DateTime.parse(pet['birth_date'].toString());
                        int ageInYears = DateTime.now().year - birthDate.year;
                        int ageInMonths =
                            DateTime.now().month - birthDate.month;

                        if (DateTime.now().day < birthDate.day) {
                          ageInMonths--;
                        }

                        String ageText = '';

                        if (ageInYears < 1) {
                          if (ageInMonths < 1) {
                            // Umur kurang dari 1 bulan
                            ageText =
                                '${birthDate.difference(DateTime.now()).inDays.abs()} hari';
                            ageText = ageText.replaceAll("-", "");
                            ageText = 'Umur $ageText';
                            // print(ageText);
                          } else {
                            // Umur kurang dari 1 tahun
                            ageText = '$ageInMonths bulan';
                            ageText = 'Umur $ageText';
                            // print(ageText);
                          }
                        } else {
                          // Umur lebih dari 1 tahun
                          ageText = '$ageInYears tahun';
                          ageText = 'Umur $ageText';
                          // print(ageText);
                        }
                        print("age: $ageText");
                        return Column(
                          children: [
                            DetailPet(
                              name: petName,
                              age: ageText,
                              image: petImage,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
