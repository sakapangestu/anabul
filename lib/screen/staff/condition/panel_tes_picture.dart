import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../helper/global_colors.dart';

class PanelTesPicture extends StatefulWidget {

  final PanelController? pc;

  const PanelTesPicture({
    Key? key,
    this.pc
  }) : super(key: key);

  @override
  _PanelTesPicture createState() => _PanelTesPicture();

}

class _PanelTesPicture extends State<PanelTesPicture> {

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
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ganti Foto Profile",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: globalColors.textBlackSmall,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {},
                                splashColor: globalColors.textGray,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color:Colors.black, width: 1),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))
                                  ),
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.camera_alt_rounded, size: 40),
                                      Text(
                                        "Ambil Foto",
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            color: globalColors.textBlackSmall,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                splashColor: globalColors.textGray,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black, width: 1),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))
                                  ),
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.image_rounded, size: 40),
                                      Text(
                                        "Upload Foto",
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            color: globalColors.textBlackSmall,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}