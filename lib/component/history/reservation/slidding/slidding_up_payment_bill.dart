import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../helper/global_colors.dart';

class PanelPaymentBill extends StatefulWidget {

  final PanelController? pc;

  const PanelPaymentBill({
    Key? key,
    this.pc
  }) : super(key: key);

  @override
  _PanelPaymentBill createState() => _PanelPaymentBill();

}

class _PanelPaymentBill extends State<PanelPaymentBill> {

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
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(bottom: 120),
        decoration: const BoxDecoration(
            // color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(16))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () {
                          widget.pc?.close();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Tagihan Pembayaran",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: globalColors.textBlackBold,
                              fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.red,
                          ),
                          // color: Colors.red,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Detail Tagihan",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: globalColors.textBlackBold,
                                    fontWeight: FontWeight.w400
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
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: globalColors.bgOrangeDisabled, width: 0.5)
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () {
                    widget.pc?.close();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: globalColors.bgOrange, width: 1),
                        color: globalColors.bgOrangeDisabled.withOpacity(0.5),
                        borderRadius: const BorderRadius.all(Radius.circular(8))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: Text(
                          "Batalkan",
                          style: TextStyle(
                              color: globalColors.bgOrange,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}