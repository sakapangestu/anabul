// import 'package:anabulhotel/component/dashboard/dashboard_hotel_all.dart';
// import 'package:anabulhotel/component/dashboard/dashboard_recomendation.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
// import 'package:anabulhotel/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../../api/api_service.dart';
import '../../component/button/rectangle/rectangle_orange.dart';
import '../../component/button/rounded/rounded_orange.dart';
import '../../component/dashboard/dashboard_carousel.dart';
import '../../component/dashboard/dashboard_hotel_all.dart';
import '../../component/dashboard/dashboard_recomendation.dart';
import '../../helper/global_colors.dart';

class DashboardCustomer extends StatefulWidget {
  const DashboardCustomer({
    Key? key,
  }) : super(key: key);

  @override
  State<DashboardCustomer> createState() => _DashboardCustomer();
}

class _DashboardCustomer extends State<DashboardCustomer> {
  @override
  Widget build(BuildContext context) {
    GlobalColors globalColors = GlobalColors();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    height: 45,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    // color: Colors.red,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/splash/app_logos_horizontal.png"),
                                      fit: BoxFit.contain,
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  // flex: 2,
                                  child: GestureDetector(
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Icon(
                                    Ionicons.search,
                                    size: 24,
                                    color: globalColors.bgOrange,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(context, '/searchHotel');
                                },
                              )),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/notifications');
                            },
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.notifications_active_rounded,
                                size: 24,
                                color: globalColors.bgOrange,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                FutureBuilder<Map<String, dynamic>?>(
                  future: ApiService.getDataUser(),
                  builder: (BuildContext context,
                      AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text('Silahkan Login Terlebih Dahulu'));
                    } else if (!snapshot.hasData) {
                      return const Center(
                          child: Text('tidak mendapatkan data'));
                    } else {
                      Map<String, dynamic>? data = snapshot.data!;
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hai, ${data['name']}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            const Text(
                              "Sayangi hewan anda, percayakan pada kami",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            // const SizedBox(
                            //   height: 3,
                            // ),
                            // const Text(
                            //   "Percayakan pada kami",
                            //   style: TextStyle(
                            //     fontSize: 14,
                            //     fontWeight: FontWeight.w500,
                            //   ),
                            // ),
                          ],
                        ),
                      );
                    }
                  },
                ),
                const DashboardCarousel(),
                const Text(
                  "Rekomendasi Hotel",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // rekomendasi
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: Hotel.getHotelRecomendation(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.hasData) {
                      final List<Map<String, dynamic>> hotelTopList =
                          snapshot.data!;
                      return Container(
                        height: 240,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children:
                                  List.generate(hotelTopList.length, (index) {
                            var hotelTop = hotelTopList[index];
                            // print("data hotel: $hotelTop");
                            // return Text("tes");
                            return DashboardRecomendation(hotels: hotelTop);
                          })),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Text(
                          "Terjadi kesalahan saat memuat data hotel");
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  "Mitra Anabul Hotel",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: Hotel.getHotel(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Text(
                          "Terjadi kesalahan saat memuat data hotel");
                    } else {
                      final List<Map<String, dynamic>> hotelList =
                          snapshot.data!;
                      print(hotelList);
                      // Mengurutkan hotel berdasarkan rating tertinggi
                      // hotelList
                      //     .sort((a, b) => b['rating'].compareTo(a['rating']));

                      // Mengambil 5 data pertama setelah diurutkan
                      final List<Map<String, dynamic>> topRatedHotels =
                          hotelList.take(5).toList();

                      return Column(
                        children: List.generate(topRatedHotels.length, (index) {
                          var hotel = topRatedHotels[index];
                          return DashboardHotelAll(hotels: hotel);
                        }),
                      );
                    }
                  },
                ),
                Container(
                  height: 9.h,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: globalColors.borderLine, width: 0.5))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 24),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/searchHotel');
                      },
                      child: const RoundedOrange(title: "Lihat Semua Hotel"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
