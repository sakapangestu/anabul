import 'package:flutter/material.dart';

import '../../../helper/global_colors.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({Key? key, required this.title}) : super(key: key);
  final String title;


  @override
  Widget build(BuildContext context) {

    GlobalColors globalColors = GlobalColors();
    String _text = "Anda Belum punya akun, ";

    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 5),
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
                Navigator.pushNamed(context, '/signup');
                // Navigator.pushNamed(context, '/dashboardPageView');
              },
            ),
          ),
        ],
      ),
    );
  }
}
