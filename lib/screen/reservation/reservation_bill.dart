// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/component/button/rectangle/rectangle_orange_disabled.dart';
// import 'package:anabulhotel/component/history/reservation/reservation_ticket/detail_bill.dart';
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
import '../../component/button/rectangle/rectangle_orange.dart';
import '../../component/history/payment/payment_total.dart';
import '../../component/history/reservation/history_bill.dart';
import '../../component/history/reservation/history_ticket.dart';
import '../../component/history/reservation/reservation_ticket/detail_bill.dart';
import '../../helper/global_colors.dart';
import '../../model/data.dart';

class ReservationBill extends StatefulWidget {
  const ReservationBill(
      {Key? key,
      required this.historyReservationDetails,
      required this.idReservation,
      required this.startDate,
      required this.endDate,
      required this.hotel,
      required this.user,
      required this.result})
      : super(key: key);
  final int result;
  final String idReservation;
  final String startDate;
  final String endDate;
  final Map hotel;
  final Map user;
  final List<dynamic> historyReservationDetails;

  @override
  State<ReservationBill> createState() => _ReservationBill();
}

class _ReservationBill extends State<ReservationBill> {
  GlobalColors globalColors = GlobalColors();
  String defaultImage = BaseImage.getImageHotel();
  List<Map<String, dynamic>> ratings = [];

  @override
  void initState() {
    super.initState();
    fetchRatings();
  }

  String formatPrice(String price) {
    final formattedPrice = NumberFormat.currency(
      locale: 'id_ID',
      symbol: '',
      decimalDigits: 0,
    ).format(double.parse(price));
    return formattedPrice;
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
    // final bill = widget.historyReservation[0];
    double averageRating = calculateAverageRating(ratings);
    final id = widget.idReservation;
    final hotel = widget.hotel;
    final user = widget.user;
    final start = widget.startDate;
    final end = widget.endDate;
    // final total_cost = bill['total_cost'];
    // print("bill : $total_cost");
    // print("harga ${bill['reservation']['total_cost']}");
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
            title: "Detail Tagihan",
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
                HistoryBill(
                    title: 'Tagihan',
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
                    "Detail Tagihan",
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: globalColors.textBlackBold,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: FutureBuilder<Map<String, dynamic>>(
                    future: History.getHistoryBill(id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        if (snapshot.hasData) {
                          // Data tagihan berhasil diterima
                          Map<String, dynamic> billData = snapshot.data!;
                          final detailBill = billData['detail'];
                          // Lakukan sesuatu dengan data tagihan
                          return ListView.builder(
                            itemCount: detailBill.length,
                            itemBuilder: (context, index) {
                              var bill = detailBill[index];
                              var pet = bill['pet'];
                              print("object: $bill");
                              // Sesuaikan tampilan item tagihan sesuai kebutuhan
                              return Column(
                                children: [
                                  DetailBill(bill: bill),
                                ],
                              );
                            },
                          );
                        } else {
                          // Tidak ada data tagihan yang diterima
                          return Text('Tidak ada data tagihan.');
                        }
                      }
                    },
                  ),
                  // child: ListView.builder(
                  //   itemCount: widget.historyReservationDetails.length,
                  //   itemBuilder: (context, index) {
                  //     final reservationDetails = widget.historyReservationDetails[index];
                  //     return Column(
                  //       children: [
                  //         DetailBill(reservationDetails: reservationDetails),
                  //       ],
                  //     );
                  //   },
                  // ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 9.h,
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: globalColors.borderLine, width: 0.5))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: PaymentTotal(
            title: "Rp. ${formatPrice(widget.result.toString())} ,-",
            // "${widget.result}"
          ),
        ),
      ),
    );
  }
}
