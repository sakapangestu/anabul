// import 'package:anabulhotel/api/api_service.dart';
// import 'package:anabulhotel/screen/hotel_pet/hotel_pet.dart';
// import 'package:anabulhotel/screen/tes/tes.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../api/api_service.dart';
import '../../helper/global_colors.dart';
import '../reservation/reservation.dart';
import 'hotel_pet.dart';

class HotelList extends StatefulWidget {
  const HotelList({Key? key, required this.hotels}) : super(key: key);
  final Map hotels;

  @override
  _HotelListState createState() => _HotelListState();
}

class _HotelListState extends State<HotelList> {
  ImageProvider imageProvider = const AssetImage("assets/splash/app_logo.png");
  List<Map<String, dynamic>> ratings = [];

  @override
  void initState() {
    super.initState();
    fetchRatings();
    loadImage();
  }

  Future<void> fetchRatings() async {
    try {
      List<Map<String, dynamic>> fetchedRatings =
          await Rating.getRatingHotel(widget.hotels['id_hotel']);
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

  Future<void> loadImage() async {
    String defaultImage = BaseImage.getImageHotel();
    if (widget.hotels['image'] != null) {
      String imageUrl = defaultImage + widget.hotels['image'];
      setState(() {
        imageProvider = NetworkImage(imageUrl);
      });
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
    GlobalColors globalColors = GlobalColors();
    double averageRating = calculateAverageRating(ratings);

    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) {
                  return HotelPet(
                    hotels: widget.hotels,
                    ratings: averageRating.toString(),
                  );
                }),
              ),
            );
          },
          child: SizedBox(
            height: 100,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Container(
                      height: 75,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        color: globalColors.bgOrangeDisabled,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.hotels['name'],
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
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
                                    Icon(
                                      Icons.location_on_rounded,
                                      color: globalColors.bgOrange,
                                      size: 16,
                                    ),
                                    Text(
                                      widget.hotels['city']['name'],
                                      style: TextStyle(
                                        color: globalColors.textGray,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.star_rate_rounded,
                                      color: globalColors.bgOrange,
                                      size: 14.sp,
                                    ),
                                    Text(
                                      averageRating.toString(),
                                      style: TextStyle(
                                        color: globalColors.textGray,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ],
                                )
                                // ratings.isNotEmpty
                                //     ?
                                // Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.start,
                                //         children: [
                                //           Icon(
                                //             Icons.star_rate_rounded,
                                //             color: globalColors.bgOrange,
                                //             size: 12.sp,
                                //           ),
                                //           Text(
                                //             averageRating.toString(),
                                //             style: TextStyle(
                                //               color: globalColors.textGray,
                                //               fontWeight: FontWeight.w400,
                                //               fontSize: 10.sp,
                                //             ),
                                //           ),
                                //         ],
                                //       )
                                //     : Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.start,
                                //         children: [
                                //           Icon(
                                //             Icons.star_rate_rounded,
                                //             color: globalColors.bgOrange,
                                //             size: 12.sp,
                                //           ),
                                //           Text(
                                //             "0.0",
                                //             style: TextStyle(
                                //               color: globalColors.textGray,
                                //               fontWeight: FontWeight.w400,
                                //               fontSize: 10.sp,
                                //             ),
                                //           ),
                                //         ],
                                //       )
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Reservation(hotels: widget.hotels),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: globalColors.bgOrangeDisabled,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Text(
                                  "Pesan",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 8.sp,
                                    color: globalColors.bgOrange,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
