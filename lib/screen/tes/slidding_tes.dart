import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../helper/global_colors.dart';

class ConditionTesSlidding extends StatefulWidget {
  final PanelController pc;
  final Function(XFile?) updateImage;
  final ImagePicker picker;

  ConditionTesSlidding({
    Key? key,
    required this.pc,
    required this.updateImage,
    required this.picker,
  }) : super(key: key);

  @override
  _ConditionTesSliddingState createState() => _ConditionTesSliddingState();
}

class _ConditionTesSliddingState extends State<ConditionTesSlidding> {
  GlobalColors globalColors = GlobalColors();
  XFile? _image;

  Future<XFile?> getImageFromCamera() async {
    var image = await widget.picker.pickImage(source: ImageSource.camera);
    return image;
  }

  Future<XFile?> getImageFromGallery() async {
    var image = await widget.picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  void _updateImage(XFile? image) {
    XFile? _image;
    setState(() {
      _image = image;
    });
    widget.updateImage(image);
    widget.pc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: globalColors.textOrange, width: 0.5),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
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
                          widget.pc.close();
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tambah Foto Aktifitas Hewan",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: globalColors.textBlackSmall,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () async {
                                  var image = await getImageFromCamera();
                                  _updateImage(image);
                                },
                                splashColor: globalColors.textGray,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.camera_alt_rounded,
                                          size: 40),
                                      Text(
                                        "Ambil Foto",
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: globalColors.textBlackSmall,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () async {
                                  // var image = await getImageFromGallery();
                                  // _updateImage(image);
                                },
                                splashColor: globalColors.textGray,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.image_rounded, size: 40),
                                      Text(
                                        "Upload Foto",
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: globalColors.textBlackSmall,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_image != null)
                          Image.file(
                            File(_image!.path),
                            width: 200,
                            height: 200,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: globalColors.bgOrangeDisabled, width: 0.5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () {
                    widget.pc?.close();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: globalColors.bgOrange, width: 1),
                      color: globalColors.bgOrangeDisabled.withOpacity(0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: Text(
                          "Batalkan",
                          style: TextStyle(
                            color: globalColors.bgOrange,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
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
