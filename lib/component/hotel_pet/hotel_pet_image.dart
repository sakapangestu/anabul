// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../api/api_service.dart';
import '../../helper/global_colors.dart';

class HotelPetImage extends StatefulWidget {
  const HotelPetImage({Key? key, required this.hotels}) : super(key: key);

  final Map hotels;

  @override
  State<HotelPetImage> createState() => _HotelPetImage();
}

class _HotelPetImage extends State<HotelPetImage> {
  GlobalColors globalColors = GlobalColors();

  @override
  Widget build(BuildContext context) {
    String defaultImageAlbum = BaseImage.getHotelAlbums();
    final listAlbums = widget.hotels['hotel_albums'];
    // print("foto foto: $listAlbums");
    return Container(
      height: 120,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Galeri Foto",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
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
          if (listAlbums != null && listAlbums.isNotEmpty)
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listAlbums.length,
                itemBuilder: (context, index) {
                  final albums = listAlbums[index];
                  ImageProvider imageProvider;
                  if (albums['image'] != null) {
                    imageProvider =
                        NetworkImage(defaultImageAlbum + albums['image']);
                  } else {
                    imageProvider =
                        const AssetImage("assets/splash/app_logo.png");
                  }
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          margin: const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                              color: globalColors.bgOrangeDisabled,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              // color: Colors.amber,
              alignment: Alignment.center,
              child: Text(
                "Album Foto Belum Tersedia",
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: globalColors.textBlackBold),
              ),
            ),
        ],
      ),
    );
  }
}
