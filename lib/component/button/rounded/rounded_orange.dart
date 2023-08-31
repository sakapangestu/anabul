import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../helper/global_colors.dart';

class RoundedOrange extends StatelessWidget {
  const RoundedOrange({Key? key, required this.title}) : super(key: key);
  final String title;

  
  @override
  Widget build(BuildContext context) {

    GlobalColors globalColors = GlobalColors();

    return Container(
      decoration: BoxDecoration(
          color: globalColors.bgOrange,
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          border: Border.all(color: globalColors.bgOrange)
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
            color: globalColors.textWhite,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600
        ),
      ),
    );
  }
}
