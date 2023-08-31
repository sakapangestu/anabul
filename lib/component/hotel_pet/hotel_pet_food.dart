// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../helper/global_colors.dart';

class HotelPetFood extends StatefulWidget {
  const HotelPetFood({Key? key, required this.hotels}) : super(key: key);
  final Map hotels;

  @override
  State<HotelPetFood> createState() => _HotelPetFood();
}

class _HotelPetFood extends State<HotelPetFood> {
  GlobalColors globalColors = GlobalColors();

  @override
  Widget build(BuildContext context) {
    final productList = widget.hotels['products'];
    print("productttt: $productList");
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Makanan",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        productList != null && productList.isNotEmpty
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
                            "Nama Product",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: globalColors.textBlackBold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
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
                  Column(
                    children: productList.map<Widget>(
                      (product) {
                        print("product: $product");
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
                                  product['name'],
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: globalColors.textBlackSmall,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Rp. ${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(product['price'])} ,-",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: globalColors.textBlackSmall,
                                  ),
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
                  "Makanan Belum Tersedia",
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
