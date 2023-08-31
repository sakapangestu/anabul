import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../helper/global_colors.dart';
import '../../../helper/session.dart';
import '../button/rounded/rounded_logout.dart';

class UserPanelSendEmail extends StatefulWidget {

  final PanelController? pc;
  final String email;

  const UserPanelSendEmail({
    Key? key,
    required this.pc,
    required this.email,
  }) : super(key: key);

  @override
  _UserPanelSendEmail createState() => _UserPanelSendEmail();

}

class _UserPanelSendEmail extends State<UserPanelSendEmail> {

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
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pesan Verifikasi Akan dikirimkan Ke Email Anda",
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
                          "Akun email anda akan mendapatkan pesan email verifikasi. Jika belum mendapatkan email bisa klik button dibawah.",
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
                  // Navigator.pushNamed(context, '/login');
                },
                child: const RoundedLogout(title: "kirimkan email"),
              ),
            ),
          ],
        ),
      ),
    );
  }

}