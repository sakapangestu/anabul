// import 'package:anabulhotel/api/api_service.dart';
// import 'package:anabulhotel/screen/hotel_pet/hotel_pet.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../../api/api_service.dart';
import '../../helper/global_colors.dart';
import '../../screen/hotel_pet/hotel_pet.dart';
import '../../screen/reservation/reservation.dart';

class DashboardHotelAll extends StatefulWidget {
  const DashboardHotelAll({Key? key, required this.hotels}) : super(key: key);
  final Map hotels;

  @override
  _DashboardHotelAllState createState() => _DashboardHotelAllState();
}

class _DashboardHotelAllState extends State<DashboardHotelAll> {
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
      setState(() {
        ratings = fetchedRatings;
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

    return InkWell(
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
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: Stack(
          children: [
            Container(
              height: 240,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 0.1),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 7),
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.15),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          globalColors.bgOrange,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 7),
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Icon(
                                Icons.star_rate_rounded,
                                size: 16.sp,
                                color: globalColors.bgOrange,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                averageRating.toString(),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: globalColors.textBlackSmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.hotels['name'],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Ionicons.location,
                                            size: 12.sp,
                                            color: globalColors.textBlackBold,
                                          ),
                                          const SizedBox(width: 2),
                                          Text(
                                            widget.hotels['city']['name'],
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              color: globalColors.textBlackBold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
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
