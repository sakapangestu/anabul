// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../api/api_service.dart';
import '../../helper/global_colors.dart';

class HotelPetRating extends StatefulWidget {
  const HotelPetRating({Key? key, required this.hotels}) : super(key: key);
  final Map hotels;

  @override
  State<HotelPetRating> createState() => _HotelPetRating();
}

class _HotelPetRating extends State<HotelPetRating> {
  GlobalColors globalColors = GlobalColors();
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
    // print("id hotel: ${widget.hotels['id_hotel']}");
    return Container(
      // color: Colors.red,
      margin: const EdgeInsets.only(bottom: 10),
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: Rating.getRatingHotel(widget.hotels['id_hotel']),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            if (snapshot.hasData) {
              List<Map<String, dynamic>> data = snapshot.data!;
              double averageRating = calculateAverageRating(data);
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Ulasan",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            data.isNotEmpty
                                ? Row(
                                    children: [
                                      Icon(
                                        Icons.star_rate_rounded,
                                        size: 14.sp,
                                        color: globalColors.bgOrange,
                                      ),
                                      Text(
                                        "( ${averageRating.toStringAsFixed(1)} )",
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.bold,
                                            color: globalColors.textGray),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${data.length} ulasan",
                                        style: TextStyle(
                                            fontSize: 7.sp,
                                            fontWeight: FontWeight.bold,
                                            color: globalColors.textGray),
                                      ),
                                    ],
                                  )
                                : Container()
                          ],
                        ),
                        GestureDetector(
                          child: Text(
                            "Lihat Semua",
                            style: TextStyle(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w900,
                                color: globalColors.bgOrange),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  data.isNotEmpty
                      ? Column(
                          children: List.generate(data.length, (index) {
                            var dataRate = data[index];
                            var rate = dataRate['star'];
                            var comment = dataRate['comment'];
                            var user = dataRate['reservation']['user']['name'];
                            var dateCreate = dataRate['CreatedAt'];
                            DateTime date =
                                DateTime.parse(dateCreate.toString());
                            String formattedDate =
                                DateFormat('d MMM yyyy').format(date);
                            // var pet = dataRate['pet'];
                            // print("object date: $formattedDate");
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              height: 120,
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
                                    flex: 1,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              width: 6.h,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/background/hotel.jpg"),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  user,
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: globalColors
                                                        .textBlackBold,
                                                  ),
                                                ),
                                                Text(
                                                  formattedDate,
                                                  style: TextStyle(
                                                    fontSize: 8.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: globalColors
                                                        .textBlackBold,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: globalColors.bgOrange,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.star_rate_rounded,
                                                size: 12.sp,
                                                color: globalColors.textWhite,
                                              ),
                                              Text(
                                                rate.toString(),
                                                style: TextStyle(
                                                    fontSize: 8.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        globalColors.textWhite),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          comment,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w400,
                                            color: globalColors.textBlackBold,
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            );
                          }),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          // color: Colors.amber,
                          alignment: Alignment.center,
                          child: Text(
                            "Belum Ada Penilaian",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: globalColors.textBlackBold),
                          ),
                        ),
                ],
              );
            } else {
              // Tidak ada data tagihan yang diterima
              return const Text('Tidak ada data rating.');
            }
          }
        },
      ),
    );
  }
}
