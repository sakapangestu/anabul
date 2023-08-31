import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../api/api_service.dart';
import '../../../helper/global_colors.dart';
import '../../../helper/session.dart';
import '../../button/rounded/rounded_logout.dart';

class UserPanelLogout extends StatefulWidget {

  final PanelController? pc;
  final String? name;

  const UserPanelLogout({
    Key? key,
    this.pc,
    this.name,
  }) : super(key: key);

  @override
  _UserPanelLogout createState() => _UserPanelLogout();

}

class _UserPanelLogout extends State<UserPanelLogout> {

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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Keluar Aplikasi Anabul Hotel",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: globalColors.textBlackBold,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Apakah anda yakin ingin keluar? anda harus login lagi ketika anda kembali ke aplikasi.",
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
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: globalColors.borderLine, width: 0.5)
                  )
              ),
              child: GestureDetector(
                onTap: () async {
                  var data = await SessionManager.getData();
                  String token = data!['data']['token'];
                  print(token);
                  try {
                    // sukses
                    if (token.isNotEmpty) {
                      var result = await ApiService.logout(token);
                      Navigator.pushNamed(context, '/login');
                      return result;
                    } else {
                      Navigator.pushNamed(context, '/login');// gagal
                    }
                  } catch (error) {
                    print('Error during logout: $error');
                    Navigator.pushNamed(context, '/login');
                  }
                },
                child: const RoundedLogout(title: "Keluar Akun"),
              ),
            ),
          ],
        ),
      ),
    );
  }

}