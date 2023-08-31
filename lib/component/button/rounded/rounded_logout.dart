import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../helper/global_colors.dart';

class RoundedLogout extends StatelessWidget {
  const RoundedLogout({Key? key, required this.title}) : super(key: key);
  final String title;

  
  @override
  Widget build(BuildContext context) {

    GlobalColors globalColors = GlobalColors();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          color: globalColors.bgOrangeDisabled,
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          border: Border.all(color: globalColors.borderLogout)
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
            color: globalColors.borderLogout,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600
        ),
      ),
    );
  }
}
