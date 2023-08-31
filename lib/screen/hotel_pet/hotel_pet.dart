// import 'package:anabulhotel/api/api_service.dart';
// import 'package:anabulhotel/component/button/rounded/rounded_orange.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
// import 'package:anabulhotel/screen/reservation/reservation.dart';
// import 'package:anabulhotel/screen/tes/hotelDetail_tes.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../api/api_service.dart';
import '../../component/button/rounded/rounded_orange.dart';
import '../../helper/global_colors.dart';
import '../reservation/reservation.dart';
import '../tes/hotelDetail_tes.dart';

class HotelPet extends StatefulWidget {
  const HotelPet({Key? key, required this.hotels, required this.ratings})
      : super(key: key);
  final Map hotels;
  final String ratings;

  @override
  State<HotelPet> createState() => _HotelPet();
}

class _HotelPet extends State<HotelPet> {
  GlobalColors globalColors = GlobalColors();

  @override
  Widget build(BuildContext context) {
    // print("object isi apa: ${widget.hotels}");
    String defaultImage = BaseImage.getImageHotel();
    ImageProvider imageProvider;
    if (widget.hotels['image'] != null) {
      imageProvider = NetworkImage(defaultImage + widget.hotels['image']);
    } else {
      imageProvider = const AssetImage("assets/splash/app_logo.png");
    }
    // print("image: $imageUrl");
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: globalColors.iconOrange,
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: Container(
                height: 90,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                    color: Colors.white),
                width: double.infinity,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          widget.hotels['name'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  size: 16.sp,
                                  color: globalColors.bgOrange,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  widget.hotels['city']['name'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: globalColors.textGray,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star_rate_rounded,
                                  size: 16.sp,
                                  color: globalColors.bgOrange,
                                ),
                                Text(
                                  // "( " + "${widget.hotels['rate']}" + " )",
                                  "( ${widget.ratings} )",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: globalColors.textGray),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: globalColors.bgOrange,
            expandedHeight: 400,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
                width: double.infinity,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: HotelDetailTes(
                hotels: widget.hotels,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 9.h,
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: globalColors.borderLine, width: 0.5))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Reservation(hotels: widget.hotels)),
              );
              // pc.open();
            },
            child: const RoundedOrange(title: "Pesan"),
          ),
        ),
      ),
    );
  }
}
