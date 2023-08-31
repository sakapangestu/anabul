import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../helper/global_colors.dart';
import '../../../helper/session.dart';
import '../../component/button/rounded/rounded_logout.dart';

class MenuPanelSuccessSecurity extends StatefulWidget {

  final PanelController? pc;

  const MenuPanelSuccessSecurity({
    Key? key,
    required this.pc,
  }) : super(key: key);

  @override
  _MenuPanelSuccessSecurity createState() => _MenuPanelSuccessSecurity();

}

class _MenuPanelSuccessSecurity extends State<MenuPanelSuccessSecurity> {

  GlobalColors globalColors = GlobalColors();

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: globalColors.textOrange, width: 0.5),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16)
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 35),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Password baru anda telah berhasil diubah",
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: globalColors.textBlackBold,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Password akun anda mengalami perubahan. Silahkan login kembali untuk keamanan akun anda.",
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: globalColors.textBlackBold,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: globalColors.borderLine, width: 0.5)
                  )
              ),
              child: GestureDetector(
                onTap: () async {
                  await SessionManager.clearSession();
                  Navigator.pushNamed(context, '/login');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Center(child: Text('Password berhasil diubah'))),
                  );
                },
                child: const RoundedLogout(title: "Kembali ke login"),
              ),
            ),
          ],
        ),
      ),
    );
  }

}