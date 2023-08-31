import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../../api/api_service.dart';
import '../../helper/global_colors.dart';
import '../../screen/hotel_pet/hotel_pet.dart';

class DashboardRecomendation extends StatefulWidget {
  const DashboardRecomendation({Key? key, required this.hotels})
      : super(key: key);
  final Map hotels;

  @override
  _DashboardRecomendationState createState() => _DashboardRecomendationState();
}

class _DashboardRecomendationState extends State<DashboardRecomendation> {
  late ImageProvider imageProvider;
  late Future<Map<String, dynamic>> detailHotel;

  @override
  void initState() {
    super.initState();
    setState(() {
      detailHotel = Hotel.detailHotelRecomendation(widget.hotels['id_hotel']);
      print("hotel detail : $detailHotel");
    });
    String defaultImage = BaseImage.getImageHotel();
    if (widget.hotels['image'] != null) {
      imageProvider = NetworkImage(defaultImage + widget.hotels['image']);
    } else {
      imageProvider = AssetImage("assets/splash/app_logo.png");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("objectttt: ${widget.hotels}");
    GlobalColors globalColors = GlobalColors();
    return InkWell(
      onTap: () {
        detailHotel.then((data) {
          print("tes data: $data");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) {
                return HotelPet(
                  hotels: data,
                  ratings: widget.hotels['rating'].toString(),
                );
              }),
            ),
          );
        });
      },
      // onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: ((context) {
      //         return HotelPet(
      //           hotels: widget.hotels,
      //           ratings: "",
      //         );
      //       }),
      //     ),
      //   );
      // },
      child: Container(
        width: 160,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 0.1),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                decoration: const BoxDecoration(
                  // color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        globalColors.bgOrange,
                        Colors.white.withOpacity(0.6),
                      ],
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        widget.hotels['name'],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Ionicons.location,
                                  size: 10,
                                  color: globalColors.textGray,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  widget.hotels['city'],
                                  style: TextStyle(
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w500,
                                    color: globalColors.textGray,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Ionicons.star,
                                size: 10,
                                color: globalColors.bgOrange,
                              ),
                              Text(
                                widget.hotels['rating'].toString(),
                                style: TextStyle(
                                    fontSize: 8,
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
            )
          ],
        ),
      ),
    );
  }
}
