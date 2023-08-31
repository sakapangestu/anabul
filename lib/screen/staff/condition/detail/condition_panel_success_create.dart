import 'dart:math';

// import 'package:anabulhotel/api/api_service.dart';
// import 'package:anabulhotel/screen/dashboard/dashboard_pageview_staff.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../component/button/rectangle/rectangle_orange_disabled.dart';
import '../../../../helper/global_colors.dart';
import '../../../dashboard/dashboard_pageview_staff.dart';

class ConditionPanelSuccessCreate extends StatefulWidget {
  final PanelController? pc;

  const ConditionPanelSuccessCreate({Key? key, this.pc}) : super(key: key);

  @override
  _ConditionPanelSuccessCreate createState() => _ConditionPanelSuccessCreate();
}

class _ConditionPanelSuccessCreate extends State<ConditionPanelSuccessCreate> {
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/icon/success.png"),
                      Text(
                        "Aktivitas Hewan Anda Berhasil Ditambahkan",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: globalColors.textBlackBold,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Aktivitas hewan berhasil dibuat. Silahkan kembali ke beranda untuk menggunakan aplikasi.",
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashboardPageViewStaff(
                                initialIndex: 1,
                              )),
                    );
                  },
                  child: RectangleOrangeDisabled(title: "Kembali Ke Aktifitas"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
