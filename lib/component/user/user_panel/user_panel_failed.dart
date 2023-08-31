import 'dart:math';

// import 'package:anabulhotel/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../helper/global_colors.dart';
import '../../button/rectangle/rectangle_orange_disabled.dart';

class UserPanelFailed extends StatefulWidget {
  final PanelController? pc;

  const UserPanelFailed({Key? key, this.pc}) : super(key: key);

  @override
  _UserPanelFailed createState() => _UserPanelFailed();
}

class _UserPanelFailed extends State<UserPanelFailed> {
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
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () {
                          widget.pc?.close();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/icon/success.png"),
                        Text(
                          "Profil Anda Berhasil Diubah",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: globalColors.textBlackBold,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Data yang masukkan ada kesamaan pada data sebelumnya. Pastikan data yang kamu masukkan udah benar.",
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
                    // Navigator.pop(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Pet()),
                    // );
                  },
                  child: RectangleOrangeDisabled(
                    title: "Tambahkan Hewan",
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
