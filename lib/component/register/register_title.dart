import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../helper/global_colors.dart';
import '../../../screen/forgot/forgot_email.dart';

class RegisterTitle extends StatelessWidget {
  const RegisterTitle({Key? key, required this.title}) : super(key: key);
  final String title;


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: const EdgeInsets.only(top: 40, bottom: 20),
            child: Image.asset("assets/splash/app_logos.png", scale: 8,)
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }
}
