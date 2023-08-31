import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../helper/global_colors.dart';
import '../../../screen/forgot/forgot_email.dart';

class ForgotButton extends StatelessWidget {
  const ForgotButton({Key? key, required this.title}) : super(key: key);
  final String title;


  @override
  Widget build(BuildContext context) {

    GlobalColors globalColors = GlobalColors();

    return Container(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        child: Text(
          title,
          style: TextStyle(
              color: globalColors.bgOrange,
              fontSize: 12,
              fontWeight: FontWeight.bold
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/forgotPassword');
        },
      ),
    );
  }
}
