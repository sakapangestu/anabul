// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../helper/global_colors.dart';

class UserDefaultProfile extends StatelessWidget {
  const UserDefaultProfile({
    super.key,
    required this.error,
  });
  final String error;
  // final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    GlobalColors globalColors = GlobalColors();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage:
                        Image.asset('assets/background/default_user.png').image,
                    backgroundColor: globalColors.bgOrangeDisabled,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           DetailUserTes(user: data)),
                                // );
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: globalColors.bgOrange, width: 1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100))),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Icon(
                                    Icons.edit,
                                    size: 20,
                                    color: globalColors.bgOrange,
                                  ),
                                  // child: Image.asset("assets/icons/icon-edit-profile.png", scale: 3.5),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'Silahkan Login Terlebih Dahulu',
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 10),
        Text(
          error,
          style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w200),
        ),
      ],
    );
  }
}
