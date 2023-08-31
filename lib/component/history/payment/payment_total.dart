import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../helper/global_colors.dart';

class PaymentTotal extends StatelessWidget {
  const PaymentTotal({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {

    GlobalColors globalColors = GlobalColors();

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "TOTAL : ",
          style: TextStyle(
              color: globalColors.textBlackBold,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: globalColors.bgOrangeDisabled,
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.centerRight,
          child: Text(
            title,
            style: TextStyle(
                color: globalColors.textBlackBold,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp),
          ),
        ),
      ],
    );
  }
}
