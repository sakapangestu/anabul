// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../helper/global_colors.dart';

class HotelPetTreatment extends StatefulWidget {
  const HotelPetTreatment({Key? key, required this.hotels}) : super(key: key);
  final Map hotels;

  @override
  State<HotelPetTreatment> createState() => _HotelPetTreatment();
}

class _HotelPetTreatment extends State<HotelPetTreatment> {
  GlobalColors globalColors = GlobalColors();

  @override
  Widget build(BuildContext context) {
    final serviceList = widget.hotels['services'];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Layanan",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        serviceList != null && serviceList.isNotEmpty
            ? Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                        // color: Colors.amber,
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.black.withOpacity(0.2)))),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Nama Layanan",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: globalColors.textBlackBold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Ukuran",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: globalColors.textBlackBold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  "Harga",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: globalColors.textBlackBold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: serviceList.map<Widget>(
                      (service) {
                        print("service: $service");
                        final serviceDetailList = service['service_details'];
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              // color: Colors.amber,
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black.withOpacity(0.2)))),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  service['name'],
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: globalColors.textBlackSmall,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  children: serviceDetailList
                                      .map<Widget>((serviceDetails) {
                                    print("service2 : $serviceDetails");
                                    return Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4),
                                            child: Text(
                                              serviceDetails['group']['name'],
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    globalColors.textBlackSmall,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            "Rp. ${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(serviceDetails['price'])} ,-",
                                            // "Rp. 50.000,-",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  globalColors.textBlackSmall,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(), //
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ).toList(), // Ubah menjadi .toList() di sini
                  ),
                ],
              )
            : Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                // color: Colors.amber,
                alignment: Alignment.center,
                child: Text(
                  "Layanan Belum Tersedia",
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: globalColors.textBlackBold),
                ),
              ),
      ]),
    );
  }
}
