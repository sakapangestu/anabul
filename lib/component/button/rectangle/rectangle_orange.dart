import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../helper/global_colors.dart';

class RectangleOrange extends StatelessWidget {
  const RectangleOrange({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {

    GlobalColors globalColors = GlobalColors();

    return Container(
      decoration: BoxDecoration(
          color: globalColors.bgOrange,
          borderRadius: const BorderRadius.all(Radius.circular(8))
      ),
      // alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: globalColors.textWhite,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp
            ),
          ),
        ),
      ),
    );
  }
}
