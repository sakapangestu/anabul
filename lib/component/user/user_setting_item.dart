import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../helper/global_colors.dart';

class UserSettingItem extends StatefulWidget {

  const UserSettingItem({Key? key, required this.data, required this.pc}) : super(key: key);

  final Map data;
  final PanelController? pc;

  @override
  _UserSettingItem createState() => _UserSettingItem();

}

class _UserSettingItem extends State<UserSettingItem> {

  GlobalColors globalColors = GlobalColors();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            if(widget.data["name"] == "Keluar Akun") {
              widget.pc?.open();
            } else {
              Navigator.pushNamed(context, widget.data["route"]);
            }
          },
          splashColor: globalColors.bgOrangeDisabled,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon (widget.data["icon"], color: globalColors.textBlackBold, size: 24.sp),
                    const SizedBox(width: 30,),
                    Text(
                      widget.data["name"],
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: globalColors.textBlackBold
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.keyboard_arrow_right_rounded,
                  size: 25,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}