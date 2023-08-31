import 'dart:math';

// import 'package:anabulhotel/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../helper/global_colors.dart';
import '../../../screen/dashboard/dashboard_pageview.dart';
import '../../button/rectangle/rectangle_orange_disabled.dart';

class PetPanelSuccessCreate extends StatefulWidget {
  final PanelController? pc;

  const PetPanelSuccessCreate({Key? key, this.pc}) : super(key: key);

  @override
  _PetPanelSuccessCreate createState() => _PetPanelSuccessCreate();
}

class _PetPanelSuccessCreate extends State<PetPanelSuccessCreate> {
  GlobalColors globalColors = GlobalColors();

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: globalColors.textOrange, width: 0.5),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: const BoxDecoration(
                              // color: Colors.red,
                              image: DecorationImage(
                                  image: AssetImage("assets/icon/success.png"),
                                  fit: BoxFit.fill)),
                        ),
                        // Image.asset("assets/icon/success.png"),
                        Text(
                          "Data Hewan Anda Berhasil Ditambahkan",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: globalColors.textBlackBold,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Profil anda berhasil diubah. Silahkan kembali ke beranda untuk menggunakan aplikasi.",
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: globalColors.textBlackBold,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 9.h,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: globalColors.borderLine, width: 0.5))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardPageView(
                                  initialIndex: 3,
                                )));
                  },
                  child: RectangleOrangeDisabled(
                    title: "Kembali Ke Menu User",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
