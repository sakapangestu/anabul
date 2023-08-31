// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/component/hotel_pet/hotel_pet_food.dart';
// import 'package:anabulhotel/component/hotel_pet/hotel_pet_image.dart';
// import 'package:anabulhotel/component/hotel_pet/hotel_pet_maps.dart';
// import 'package:anabulhotel/component/hotel_pet/hotel_pet_rating.dart';
// import 'package:anabulhotel/component/hotel_pet/hotel_pet_room.dart';
// import 'package:anabulhotel/component/hotel_pet/hotel_pet_treatment.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:sizer/sizer.dart';

import '../../component/hotel_pet/hotel_pet_food.dart';
import '../../component/hotel_pet/hotel_pet_image.dart';
import '../../component/hotel_pet/hotel_pet_maps.dart';
import '../../component/hotel_pet/hotel_pet_rating.dart';
import '../../component/hotel_pet/hotel_pet_room.dart';
import '../../component/hotel_pet/hotel_pet_treatment.dart';
import '../../helper/global_colors.dart';

class HotelPetDetail extends StatefulWidget {
  const HotelPetDetail({Key? key, required this.hotels}) : super(key: key);
  final Map hotels;

  @override
  State<HotelPetDetail> createState() => _HotelPetDetail();
}

class _HotelPetDetail extends State<HotelPetDetail> {
  GlobalColors globalColors = GlobalColors();
  List<String> food = ["Whiskas", "Coucou", "Proplan"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //deskripsi
        ExpandableText(
          widget.hotels['description'],
          expandText: 'Lihat selengkapnya',
          collapseText: 'Lihat lebih sedikit',
          textAlign: TextAlign.justify,
          maxLines: 6,
          linkStyle: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w500, color: Colors.blue),
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: globalColors.textBlackSmall),
        ),
        //Foto
        HotelPetImage(
          hotels: widget.hotels,
        ),
        //Kandang
        HotelPetRoom(hotels: widget.hotels),
        //Makanan
        HotelPetFood(hotels: widget.hotels),
        //Layanan
        HotelPetTreatment(hotels: widget.hotels),
        //Lokasi
        HotelPetMaps(hotels: widget.hotels),
        //Ulasan
        HotelPetRating(hotels: widget.hotels)
      ],
    );
  }
}
