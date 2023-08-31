import 'package:flutter/material.dart';

class AppBarTitleMenuBar extends StatelessWidget {
  const AppBarTitleMenuBar({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xffDC822A)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
