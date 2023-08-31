import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../../../api/api_service.dart';
import '../../../helper/global_colors.dart';
import '../../../screen/reservation/reservation_ticket.dart';

class ReservationAcceptList extends StatefulWidget {
  const ReservationAcceptList(
      {super.key, required this.dataAccept, required this.status});
  final List<Map<String, dynamic>> dataAccept;
  final String status;

  @override
  State<ReservationAcceptList> createState() => _ReservationAcceptListState();
}

class _ReservationAcceptListState extends State<ReservationAcceptList> {
  GlobalColors globalColors = GlobalColors();
  String defaultImage = BaseImage.getImageHotel();
  @override
  Widget build(BuildContext context) {
    // return Text("ada data");
    return ListView.builder(
      itemCount: widget.dataAccept.length,
      itemBuilder: (context, index) {
        final historyAccept = widget.dataAccept[index];
        final hotel = historyAccept['hotel'];
        final user = historyAccept['user'];
        final idReservation = historyAccept['id_reservation'];
        final startDate = historyAccept['start_date'];
        final endDate = historyAccept['end_date'];
        final List<dynamic> reservationDetails =
            historyAccept['reservation_details'];
        ImageProvider imageProvider;
        if (hotel['image'] != null) {
          imageProvider = NetworkImage(defaultImage + hotel['image']);
        } else {
          imageProvider = const AssetImage("assets/splash/app_logo.png");
        }
        print("data hotel: $hotel");
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
                                            MainAxisAlignment.spaceEvenly,
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
                                                color: globalColors.bgSuccess,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                    width: 0.5,
                                                    color: globalColors
                                                        .borderSuccess)),
                                            child: Text(
                                              widget.status,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 8.sp,
                                                color: globalColors.textSuccess,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
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
