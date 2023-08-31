import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OnboardingItem extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String subtitle;

  OnboardingItem({
    required this.imageAsset,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Gambar
              Stack(
                children: [
                  Container(
                    height: 500,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      imageAsset,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 500,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.20),
                  ),
                ],
              ),
              // Judul
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 15),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              )
            ]
        )
    );
  }
}