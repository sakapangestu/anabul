import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../../../api/api_service.dart';
import '../../../helper/global_colors.dart';
import '../../../helper/session.dart';
import '../../../screen/reservation/reservation_ticket.dart';
import 'package:http/http.dart' as http;

class ReservationProcessList extends StatefulWidget {
  const ReservationProcessList(
      {super.key, required this.dataProcess, required this.status});
  final List<Map<String, dynamic>> dataProcess;
  final String status;

  @override
  State<ReservationProcessList> createState() => _ReservationProcessListState();
}

class _ReservationProcessListState extends State<ReservationProcessList> {
  GlobalColors globalColors = GlobalColors();
  String defaultImage = BaseImage.getImageHotel();

  static Future<Map<String, dynamic>> cancelReservation(
      String idReservation) async {
    final data = await SessionManager.getData();
    final token = data!['data']['token'];
    final response = await http.put(
        Uri.parse('${BaseApi.baseUrlApi}reservation/reservationStatus'),
        headers: {
          'Authorization': '$token',
        },
        body: {
          'id_reservation': idReservation,
          'reservation_status': 'Dibatalkan',
        });

    // print(response.body);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print("object :$responseData");
      return responseData;
    } else {
      throw Exception('Password Gagal Diubah');
    }
  }

  // bool isCancelled = false;
  @override
  Widget build(BuildContext context) {
    // return Text("ada data");
    return ListView.builder(
      itemCount: widget.dataProcess.length,
      itemBuilder: (context, index) {
        final historyProcess = widget.dataProcess[index];
        final hotel = historyProcess['hotel'];
        var city = hotel['city'];
        final user = historyProcess['user'];
        final idReservation = historyProcess['id_reservation'];
        final startDate = historyProcess['start_date'];
        final endDate = historyProcess['end_date'];
        final List<dynamic> reservationDetails =
            historyProcess['reservation_details'];
        ImageProvider imageProvider;
        if (hotel['image'] != null) {
          imageProvider = NetworkImage(defaultImage + hotel['image']);
        } else {
          imageProvider = const AssetImage("assets/splash/app_logo.png");
        }
        return SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 7),
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.3),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                // color: Colors.blue,
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1,
                                        color: globalColors.borderLine)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: globalColors.bgOrangeDisabled,
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 15),
                                      // color: Colors.white,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Text(
                                              hotel['name'],
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            // color: Colors.red,
                                            alignment: Alignment.centerLeft,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  Ionicons.location,
                                                  size: 10.sp,
                                                  color: globalColors.bgOrange,
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  hotel['city']['name'],
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 15),
                                            decoration: BoxDecoration(
                                                color: globalColors.bgWarning,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                    width: 0.5,
                                                    color: globalColors
                                                        .borderYellow)),
                                            child: Text(
                                              // isCancelled
                                              //     ? 'Dibatalkan'
                                              widget.status,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 8.sp,
                                                color: globalColors.textYellow,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () async {
                                        try {
                                          final response =
                                              await cancelReservation(
                                                  idReservation);
                                          print("cancel : $response");
                                          // Handle the response here (e.g., show a success message)
                                        } catch (error) {
                                          // Handle any error that occurs during the cancellation process
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color:
                                                globalColors.bgOrangeDisabled,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                                width: 0.5,
                                                color: globalColors.bgOrange)),
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          "Batalkan Pesanan",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: globalColors.bgOrange,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ReservationTicket(
                                                    historyReservationDetails:
                                                        reservationDetails,
                                                    hotel: hotel,
                                                    idReservation:
                                                        idReservation,
                                                    user: user,
                                                    endDate: endDate,
                                                    startDate: startDate,
                                                  )),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color:
                                                globalColors.bgOrangeDisabled,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                                width: 0.5,
                                                color: globalColors.bgOrange)),
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          "Lihat Tiket",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: globalColors.bgOrange,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ]),
        );
      },
    );
  }
}
