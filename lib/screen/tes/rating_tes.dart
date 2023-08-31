// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/component/button/rectangle/rectangle_orange_disabled.dart';
// import 'package:anabulhotel/component/pet/pet_list.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

import '../../api/api_service.dart';
import '../../component/app_bar/app_bar_tittle.dart';
import '../../component/app_bar/app_bar_tittle_menu_bar.dart';
import '../../component/button/rectangle/rectangle_orange.dart';
import '../../helper/global_colors.dart';
import '../../model/data.dart';

class RatingTes extends StatefulWidget {
  const RatingTes({Key? key, required this.idReservation, required this.hotels})
      : super(key: key);
  final String idReservation;
  final Map hotels;

  @override
  State<RatingTes> createState() => _RatingTes();
}

class _RatingTes extends State<RatingTes> {
  GlobalColors globalColors = GlobalColors();
  TextEditingController ulasanController = TextEditingController();
  int? tempRating;
  String defaultImage = BaseImage.getImageHotel();

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;
    if (widget.hotels['image'] != null) {
      imageProvider = NetworkImage(defaultImage + widget.hotels['image']);
    } else {
      imageProvider = const AssetImage("assets/splash/app_logo.png");
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, '/dashboardPageView');
          },
        ),
        backgroundColor: const Color(0xffDC822A),
        flexibleSpace: const SafeArea(
          child: AppBarTitle(
            title: "Berikan Penilaian dan Ulasan",
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        color: globalColors.bgOrangeDisabled,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.hotels['name'],
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: globalColors.textBlackBold),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.hotels['city']['name'],
                      style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: globalColors.textBlackBold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Berikan Penilaian",
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: globalColors.textBlackSmall),
              ),
              const SizedBox(height: 10),
              Center(
                child: RatingBar.builder(
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      tempRating = rating.toInt();
                      print("object rate: $tempRating");
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                maxLines: 3,
                controller: ulasanController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: globalColors.textBlackSmall),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: globalColors.bgOrange),
                  ),
                  hintText: "Masukkan Ulasan Anda ...",
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 9.h,
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: globalColors.borderLine, width: 0.5))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: GestureDetector(
            onTap: () async {
              try {
                final reservationId = widget.idReservation;
                final rate = tempRating;
                final ulasan = ulasanController.text.trim();

                print("id reservasi : $reservationId");
                print("rate input: $rate");
                print("ulasan input: $ulasan");

                final result = await Rating.createRatingHotel(
                    reservationId, rate!, ulasan);
                print("result rating: $result");

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Center(child: Text('rating berhasil diubah'))),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$e')),
                );
              }
            },
            child: const RectangleOrange(title: "Kirim"),
          ),
        ),
      ),
    );
  }
}
