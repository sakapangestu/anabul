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
import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:sizer/sizer.dart';

import '../../component/hotel_pet/hotel_pet_food.dart';
import '../../component/hotel_pet/hotel_pet_image.dart';
import '../../component/hotel_pet/hotel_pet_maps.dart';
import '../../component/hotel_pet/hotel_pet_rating.dart';
import '../../component/hotel_pet/hotel_pet_room.dart';
import '../../component/hotel_pet/hotel_pet_treatment.dart';
import '../../helper/global_colors.dart';

class HotelDetailTes extends StatefulWidget {
  const HotelDetailTes({Key? key, required this.hotels}) : super(key: key);
  final Map hotels;

  @override
  State<HotelDetailTes> createState() => _HotelDetailTes();
}

class _HotelDetailTes extends State<HotelDetailTes> {
  GlobalColors globalColors = GlobalColors();

  @override
  Widget build(BuildContext context) {
    // print("description: ${widget.hotels['description']}");
    return Column(
      children: [
        //deskripsi
        widget.hotels['description'] != null &&
                widget.hotels['description'].isNotEmpty
            ? ExpandableText(
                widget.hotels['description'],
                expandText: 'Lihat selengkapnya',
                collapseText: 'Lihat lebih sedikit',
                textAlign: TextAlign.justify,
                maxLines: 6,
                linkStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue),
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: globalColors.textBlackSmall),
              )
            : Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                // color: Colors.amber,
                alignment: Alignment.center,
                child: Text(
                  "Tidak Ada Deskripsi Hotel",
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: globalColors.textBlackBold),
                ),
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
        HotelPetRating(hotels: widget.hotels),
      ],
    );
  }
}
