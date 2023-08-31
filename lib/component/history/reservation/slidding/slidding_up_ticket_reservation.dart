import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../helper/global_colors.dart';

class PanelTicketReservation extends StatefulWidget {

  final PanelController? pc;

  const PanelTicketReservation({
    Key? key,
    this.pc
  }) : super(key: key);

  @override
  _PanelTicketReservation createState() => _PanelTicketReservation();

}

class _PanelTicketReservation extends State<PanelTicketReservation> {

  GlobalColors globalColors = GlobalColors();

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: globalColors.textOrange, width: 0.5),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16)
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16))
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () {
                      widget.pc?.close();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Tiket Reservasi",
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: globalColors.textBlackBold,
                        fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      // color: Colors.red,
                        border: Border(bottom: BorderSide(width: 1, color: globalColors.bgOrange))
                    ),
                    // color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Detail Reservasi",
                          style: TextStyle(
                              fontSize: 10.sp,
                              color: globalColors.textBlackBold,
                              fontWeight: FontWeight.w600
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: globalColors.bgOrangeDisabled,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ID Reservasi",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: globalColors.textBlackBold,
                                    fontWeight: FontWeight.w600
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 5,),
                              Text(
                                "12345678901234567",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: globalColors.textBlackBold,
                                    fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Center(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      image: DecorationImage(
                                          image: AssetImage('assets/background/hotel.jpg'),
                                          fit: BoxFit.cover
                                      )
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      // hotels['name'],
                                      "Hotel Zone",
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 8.sp,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Icon(Icons.location_on_rounded, color: globalColors.bgOrange, size: 10,),
                                                Text(
                                                  // hotels['city']['name'],
                                                  "Yogya",
                                                  style: TextStyle(
                                                    color: globalColors.textGray,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 7.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 2),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Icon(Icons.star_rate_rounded, color: globalColors.bgOrange, size: 10,),
                                                Text(
                                                  "4.0",
                                                  style: TextStyle(
                                                    color: globalColors.textGray,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 6.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Icon(Icons.calendar_month_rounded, size: 20),
                              SizedBox(width: 10),
                              Text(
                                "10/05/02" + " - " + "11/05/02",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: globalColors.textBlackBold,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Icon(Icons.person, size: 20),
                              SizedBox(width: 10),
                              Text(
                                "Namikaze Uzumaki",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: globalColors.textBlackBold,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Detail Hewan",
                          style: TextStyle(
                              fontSize: 10.sp,
                              color: globalColors.textBlackBold,
                              fontWeight: FontWeight.w600
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.pets_rounded, size: 18, color: globalColors.bgOrange,),
                              SizedBox(width: 30),
                              Text(
                                "Redbull",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: globalColors.textBlackBold,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.pets_rounded, size: 18, color: globalColors.bgOrange,),
                              SizedBox(width: 30),
                              Text(
                                "Redbull",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: globalColors.textBlackBold,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.pets_rounded, size: 18, color: globalColors.bgOrange,),
                              SizedBox(width: 30),
                              Text(
                                "Redbull",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: globalColors.textBlackBold,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}