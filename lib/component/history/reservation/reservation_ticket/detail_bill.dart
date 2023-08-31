import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../../api/api_service.dart';
import '../../../../helper/global_colors.dart';

class DetailBill extends StatelessWidget {
  const DetailBill({
    Key? key,
    required this.bill,
  }) : super(key: key);
  final Map bill;

  @override
  Widget build(BuildContext context) {
    print("apa si ini: ${bill}");
    // print("apa si ini: ${reservationDetails['reservation_services'][0]}");
    GlobalColors globalColors = GlobalColors();
    final pet = bill['pet'];
    final serviceList = bill['service'];
    final productList = bill['product'];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.pets_rounded,
                size: 18,
                color: globalColors.bgOrange,
              ),
              const SizedBox(width: 15),
              Text(
                pet,
                style: TextStyle(
                    fontSize: 12.sp,
                    color: globalColors.textBlackBold,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 5),
              Text(
                "(hewan)",
                style: TextStyle(
                    fontSize: 10.sp,
                    color: globalColors.textBlackBold,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          // Container(
          //   padding: const EdgeInsets.symmetric(vertical: 5),
          //   alignment: Alignment.center,
          //   child: Text(
          //     "Detail Tagihan",
          //     style: TextStyle(
          //         fontSize: 8.sp,
          //         color: globalColors.textBlackBold,
          //         fontWeight: FontWeight.bold
          //     ),
          //   ),
          // ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Harga Kandang",
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: globalColors.textBlackBold,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "Rp. ${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(bill['cage_cost'])} ,-",
                        // "Rp. ${bill['cage_cost'].toString()},-",
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: globalColors.textBlackBold,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: serviceList.map<Widget>(
                    (service) {
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              service['service'],
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: globalColors.textBlackBold,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "Rp. ${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(service['service_cost'])} ,-",
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: globalColors.textBlackBold,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
                Column(
                  children: productList.map<Widget>(
                    (product) {
                      print("testes : $product");
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              // "aaa",
                              product['product'],
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: globalColors.textBlackBold,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              // "asas",
                              "Rp. ${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(product['product_cost'])} ,-",
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: globalColors.textBlackBold,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
