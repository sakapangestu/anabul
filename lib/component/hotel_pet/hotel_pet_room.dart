import 'dart:convert';

// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../../api/api_service.dart';
import '../../helper/global_colors.dart';
import '../../helper/session.dart';

class HotelPetRoom extends StatefulWidget {
  const HotelPetRoom({Key? key, required this.hotels}) : super(key: key);
  final Map hotels;

  @override
  State<HotelPetRoom> createState() => _HotelPetRoom();
}

class _HotelPetRoom extends State<HotelPetRoom> {
  GlobalColors globalColors = GlobalColors();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("object hotel : ${widget.hotels}");
    final cageList = widget.hotels['cage_details'];
    return FutureBuilder<Map<String, dynamic>>(
      future: Hotel.getRoomStatus(widget.hotels['id_hotel']),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Tampilkan indikator loading jika data masih dimuat
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Tampilkan pesan error jika terjadi kesalahan saat memuat data
          return Text('Error: ${snapshot.error}');
        } else {
          // Tampilkan widget dengan menggunakan data yang diterima
          Map<String, dynamic> roomStatus = snapshot.data!;
          final cage_filled = roomStatus['cage_unfilled'].toString();
          final cage_all = roomStatus['cage_all'].toString();
          final TotalCageByDetail = roomStatus['TotalCageByDetail'];
          print("object : $roomStatus");
          print("caggeee 2: $cageList");
          // return Column(
          //   children: [
          //     Container(
          //       child: Text(
          //         "Text",
          //         style: TextStyle(
          //           fontSize: 14.sp,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ),
          //   ],
          // );
          // Lakukan hal lain dengan data status kamar
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Kandang",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "( $cage_filled/$cage_all ) tersedia",
                      style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w500,
                          color: globalColors.bgOrange),
                    ),
                  ],
                ),
              ),
              if (cageList != null && cageList.isNotEmpty)
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kandang Tersedia",
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                decoration: BoxDecoration(
                                    // color: Colors.amber,
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.black
                                                .withOpacity(0.2)))),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Tipe - Ukuran",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                          color: globalColors.textBlackBold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Terisi",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                          color: globalColors.textBlackBold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Tersedia",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                          color: globalColors.textBlackBold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: TotalCageByDetail.map<Widget>(
                                  (cageAll) {
                                    final cageCategory =
                                        cageAll['cage_category'];
                                    final cageType = cageAll['cage_type'];
                                    final totalUnfilled =
                                        cageAll['total_unfilled_cage']
                                            .toString();
                                    final totalFilled =
                                        cageAll['total_filled_cage'].toString();
                                    // print("objectttt: $product");
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      decoration: BoxDecoration(
                                          // color: Colors.amber,
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black
                                                      .withOpacity(0.2)))),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              "$cageCategory - $cageType",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    globalColors.textBlackSmall,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              totalFilled,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    globalColors.textBlackSmall,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              totalUnfilled,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    globalColors.textBlackSmall,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ).toList(), // Ubah menjadi .toList() di sini
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Jenis Kandang",
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    // color: Colors.amber,
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.black
                                                .withOpacity(0.2)))),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Tipe - Ukuran",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                          color: globalColors.textBlackBold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Harga",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                          color: globalColors.textBlackBold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: cageList.map<Widget>(
                                  (cages) {
                                    final cageCategory = cages['cage_category'];
                                    final cageType = cages['cage_type'];
                                    print("objectttt: $cageType");
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      decoration: BoxDecoration(
                                          // color: Colors.amber,
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black
                                                      .withOpacity(0.2)))),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${cageCategory['name']} - ${cageType['name']}",
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: globalColors
                                                        .textBlackSmall,
                                                  ),
                                                ),
                                                Text(
                                                  "${cageType['length']} X ${cageType['width']} X ${cageType['height']}",
                                                  style: TextStyle(
                                                    fontSize: 7.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: globalColors
                                                        .textBlackSmall,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "Rp. ${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(cages['price'])} ,-",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    globalColors.textBlackSmall,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ).toList(), // Ubah menjadi .toList() di sini
                              ),
                              // Column(
                              //   children: cageList.map<Widget>(
                              //     (cageCategories) {
                              //       final cageCategory = cageCategories['name'];
                              //       final cageDetailList =
                              //           cageCategories['cage_details'];
                              //       print("objecttttut: $cageCategories");
                              //       return Container(
                              //         width: MediaQuery.of(context).size.width,
                              //         padding:
                              //             const EdgeInsets.symmetric(vertical: 15),
                              //         decoration: BoxDecoration(
                              //             // color: Colors.amber,
                              //             border: Border(
                              //                 bottom: BorderSide(
                              //                     color: Colors.black
                              //                         .withOpacity(0.2)))),
                              //         child: Row(
                              //           children: [
                              //             Expanded(
                              //               flex: 2,
                              //               child: Text(
                              //                 cageCategory,
                              //                 style: TextStyle(
                              //                   fontSize: 12.sp,
                              //                   fontWeight: FontWeight.w400,
                              //                   color: globalColors.textBlackSmall,
                              //                 ),
                              //               ),
                              //             ),
                              //             Expanded(
                              //               flex: 1,
                              //               child: Text(
                              //                 "Rp 500000",
                              //                 textAlign: TextAlign.start,
                              //                 style: TextStyle(
                              //                   fontSize: 12.sp,
                              //                   fontWeight: FontWeight.w400,
                              //                   color: globalColors.textBlackSmall,
                              //                 ),
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       );
                              //     },
                              //   ).toList(), // Ubah menjadi .toList() di sini
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              else
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  // color: Colors.amber,
                  alignment: Alignment.center,
                  child: Text(
                    "Kandang Belum Tersedia",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: globalColors.textBlackBold),
                  ),
                ),
            ]),
          );
        }
      },
    );
  }
}
