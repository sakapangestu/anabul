import 'dart:convert';
import 'dart:io';

// import 'package:anabulhotel/api/api_service.dart';
import 'package:anabul/screen/tes/slidding_tes.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
// import 'package:anabulhotel/screen/tes/slidding_tes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../api/api_service.dart';
import '../../helper/global_colors.dart';
import '../../helper/session.dart';
import '../dashboard/dashboard_pageview.dart';
import '../staff/condition/detail/condition_panel_success_create.dart';

class ConditionPetTesCreate extends StatefulWidget {
  const ConditionPetTesCreate({Key? key}) : super(key: key);

  @override
  _ConditionPetTesCreateState createState() => _ConditionPetTesCreateState();
}

class _ConditionPetTesCreateState extends State<ConditionPetTesCreate> {
  GlobalColors globalColors = GlobalColors();
  ImagePicker _picker = ImagePicker();
  TextEditingController _keteranganController = TextEditingController();
  String? temporarySelectedStatus;
  String? _selectedStatus;
  XFile? _image;
  bool _switchPanelCondition = false;
  PanelController pc = PanelController();

  void _updateImage(XFile? image) {
    setState(() {
      _image = image;
      print("gambar apa: $_image");
      print("gambar apa: $image");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      panelBuilder: (ScrollController sc) {
        if (_switchPanelCondition == true) {
          return ConditionPanelSuccessCreate(pc: pc);
        } else {
          return ConditionTesSlidding(
            pc: pc,
            updateImage: _updateImage,
            picker: _picker,
          );
        }
      },
      controller: pc,
      isDraggable: true,
      maxHeight: (_switchPanelCondition) ? 50.h : 40.h,
      minHeight: 0,
      backdropEnabled: true,
      backdropTapClosesPanel: true,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      body: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Upload Gambar'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //status
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Status",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: globalColors.textBlackBold),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFDC822A)),
                      ),
                      hintText: "Status Kondisi",
                    ),
                    value: _selectedStatus,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedStatus = value;
                        temporarySelectedStatus = value!;
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                        value: "Main",
                        child: Text("Bermain"),
                      ),
                      DropdownMenuItem(
                        value: "Makan",
                        child: Text("Makan"),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Keterangan",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _keteranganController,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: globalColors.textBlackSmall),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: globalColors.bgOrange),
                      ),
                      hintText: "Masukkan Keterangan",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Gambar",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(left: 20, right: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: globalColors.textBlackSmall),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 290,
                          child: _image != null
                              ? Text(
                                  path.basename(File(_image!.path).path),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400),
                                )
                              : Text(
                                  "Pilih Gambar",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _switchPanelCondition = false;
                            });
                            print(_switchPanelCondition);
                            pc.open();
                            // setState(() {
                            //   _passwordVisible = !_passwordVisible;
                            // });
                          },
                          icon: Icon(
                            Icons.image_rounded,
                            color: globalColors.bgOrange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tes Gambar",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: globalColors.textBlackSmall),
                      ),
                      child: _image != null
                          ? Image.file(
                              File(_image!.path),
                              alignment: Alignment.center,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                          : Container(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () async {
                    try {
                      final tempStatus = temporarySelectedStatus!;
                      final tempNote = _keteranganController.text.trim();
                      File? selectedImage =
                          _image != null ? File(_image!.path) : null;

                      print("status: $tempStatus");
                      print("note: $tempNote");

                      final data = await SessionManager.getData();
                      final token = data!['data']['token'];
                      var baseUrl = BaseUrl.baseUrl;
                      var request = http.MultipartRequest(
                        'POST',
                        Uri.parse('${baseUrl}api/petCondition/add'),
                      );
                      request.headers['Authorization'] = token;

                      request.fields['reservation_detail_id'] =
                          '05754871-fe8a-4e6f-9df2-36dd91bb9a35';
                      request.fields['status'] = 'Diterima';
                      request.fields['condition'] = tempStatus.toString();
                      request.fields['description'] = tempNote.toString();

                      if (selectedImage != null) {
                        request.files.add(
                          await http.MultipartFile.fromPath(
                            'image',
                            selectedImage.path,
                          ),
                        );
                      }

                      var response = await request.send();
                      print("respone : $response");
                      var responseBody = await response.stream.bytesToString();
                      print('Data berhasil dikirim');
                      print('Response Body: $responseBody');

                      if (response.statusCode == 200) {
                        print('Data berhasil dikirim');
                      } else {
                        print(
                            'Gagal mengirim data. Status code: ${response.statusCode}');
                      }
                    } catch (e) {
                      print('Terjadi kesalahan saat mengirim data: $e');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
