import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../api/api_service.dart';
import '../../../helper/global_colors.dart';

class HistoryBill extends StatelessWidget {
  const HistoryBill(
      {Key? key,
      required this.title,
      required this.id,
      required this.hotel,
      required this.user,
      required this.start,
      required this.end,
      required this.rating})
      : super(key: key);
  final String title;
  final String id;
  final Map hotel;
  final Map user;
  final String start;
  final String end;
  final String rating;

  @override
  Widget build(BuildContext context) {
    GlobalColors globalColors = GlobalColors();
    String defaultImage = BaseImage.getImageHotel();
    ImageProvider imageProvider;
    if (hotel['image'] != null) {
      imageProvider = NetworkImage(defaultImage + hotel['image']);
    } else {
      imageProvider = const AssetImage("assets/splash/app_logo.png");
    }
    DateTime startDate = DateTime.parse(start.toString());
    DateTime endDate = DateTime.parse(end.toString());
    return Column(
      children: [
        Container(
          child: Text(
            title,
            style: TextStyle(
                fontSize: 12.sp,
                color: globalColors.textBlackBold,
                fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 25),
          width: double.infinity,
          decoration: BoxDecoration(
            // color: Colors.red,
              border: Border(bottom: BorderSide(width: 1, color: globalColors.bgOrange))
          ),
          // color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Detail Reservasi",
                style: TextStyle(
                    fontSize: 10.sp,
                    color: globalColors.textBlackBold,
                    fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: globalColors.bgOrangeDisabled,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ID Reservasi",
                      style: TextStyle(
                          fontSize: 10.sp,
                          color: globalColors.textBlackBold,
                          fontWeight: FontWeight.w600
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      id,
                      style: TextStyle(
                          fontSize: 10.sp,
                          // fontSize: 14.sp,
                          color: globalColors.textBlackBold,
                          fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Center(
                      child: Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hotel['name'],
                            // "Hotel Zone",
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.location_on_rounded, color: globalColors.bgOrange, size: 10.sp,),
                                        Text(
                                          hotel['city']['name'],
                                          // hotel['address'],
                                          style: TextStyle(
                                            color: globalColors.textGray,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Container(
                                    // color: Colors.blue,
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.star_rate_rounded, color: globalColors.bgOrange, size: 10.sp,),
                                        Text(
                                          "4.0",
                                          style: TextStyle(
                                            color: globalColors.textGray,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 9.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month_rounded, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      "${DateFormat('dd/MM/yyyy').format(startDate)} - ${DateFormat('dd/MM/yyyy').format(endDate)}",
                      style: TextStyle(
                          fontSize: 10.sp,
                          color: globalColors.textBlackBold,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    const Icon(Icons.person, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      user['name'],
                      style: TextStyle(
                          fontSize: 10.sp,
                          color: globalColors.textBlackBold,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
