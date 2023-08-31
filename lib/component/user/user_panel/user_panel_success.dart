import 'dart:math';

// import 'package:anabulhotel/api/api_service.dart';
// import 'package:anabulhotel/helper/session.dart';
// import 'package:anabulhotel/screen/dashboard/dashboard_pageview.dart';
// import 'package:anabulhotel/screen/dashboard/dashboard_pageview_staff.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../helper/global_colors.dart';
import '../../../screen/dashboard/dashboard_pageview.dart';
import '../../../screen/dashboard/dashboard_pageview_staff.dart';
import '../../button/rectangle/rectangle_orange_disabled.dart';

class UserPanelSuccess extends StatefulWidget {
  final PanelController? pc;
  final String? roles;

  const UserPanelSuccess({Key? key, this.pc, this.roles}) : super(key: key);

  @override
  _UserPanelSuccess createState() => _UserPanelSuccess();
}

class _UserPanelSuccess extends State<UserPanelSuccess> {
  GlobalColors globalColors = GlobalColors();

  @override
  Widget build(BuildContext context) {
    print(widget.roles);
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
                          "Profil Anda Berhasil Diubah",
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
                    print("objek role: ${widget.roles}");
                    if (widget.roles == "Staff") {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashboardPageViewStaff(
                                    initialIndex: 2,
                                  )));
                    } else if (widget.roles == "Customer") {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashboardPageView(
                                    initialIndex: 3,
                                  )));
                    }
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
