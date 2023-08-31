import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../helper/global_colors.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({Key? key, required this.title}) : super(key: key);
  final String title;


  @override
  Widget build(BuildContext context) {

    GlobalColors globalColors = GlobalColors();

    return Container(
      margin: const EdgeInsets.only(top: 40, bottom: 65),
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: globalColors.bgOrange,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(
            offset: const Offset(0, 10),
            blurRadius: 10,
            color: Colors.black.withOpacity(0.3)
        )
        ],
      ),
      child: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white
          )
      ),
    );
  }
}
