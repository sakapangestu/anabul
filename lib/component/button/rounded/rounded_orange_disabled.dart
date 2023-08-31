import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../helper/global_colors.dart';

class RoundedOrangeDisabled extends StatelessWidget {
  const RoundedOrangeDisabled({Key? key, required this.title}) : super(key: key);
  final String title;


  @override
  Widget build(BuildContext context) {

    GlobalColors globalColors = GlobalColors();

    return Container(
      decoration: BoxDecoration(
          color: globalColors.bgOrangeDisabled,
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          border: Border.all(color: globalColors.bgOrange)
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
            color: globalColors.bgOrange,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600
        ),
      ),
    );
  }
}
