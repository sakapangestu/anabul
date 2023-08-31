import 'dart:io';

// import 'package:anabulhotel/api/api_service.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:ionicons/ionicons.dart';
import 'package:path/path.dart' as path;
// import 'package:anabulhotel/screen/tes/slidding_tes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../api/api_service.dart';
import '../../../component/app_bar/app_bar_tittle.dart';
import '../../../component/button/rectangle/rectangle_orange.dart';
import '../../../helper/global_colors.dart';
import '../../tes/slidding_tes.dart';
import 'detail/condition_panel_success_create.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

class ConditionPetCreate extends StatefulWidget {
  const ConditionPetCreate({Key? key, required this.idCondition})
      : super(key: key);
  final String idCondition;

  @override
  _ConditionPetCreateState createState() => _ConditionPetCreateState();
}

class _ConditionPetCreateState extends State<ConditionPetCreate> {
  GlobalColors globalColors = GlobalColors();
  final ImagePicker _picker = ImagePicker();
  TextEditingController descTambahanController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  // TextEditingController statusController = TextEditingController();
  String? temporarySelectedStatus;
  XFile? _image;
  bool _switchPanelCondition = false;
  PanelController pc = PanelController();
  List<Map<String, dynamic>> descriptions = [];
  String? selectedDesc;
  String? tempDesc;
  bool isFetchDesc = true;

  @override
  void initState() {
    super.initState();
    fetchDropdown();
  }

  Future<void> fetchDropdown() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      List<Map<String, dynamic>> descData = await TesSpecies.getDescription();
      print("isi apa desc: $descData");

      setState(() {
        descriptions = descData;
        isFetchDesc = false;
        print("object des: $descriptions");
      });
    } catch (e) {
      print('Error fetching provinces: $e');
      setState(() {
        isFetchDesc = false;
      });
    }
  }

  void _updateImage(XFile? image) {
    setState(() {
      _image = image;
    });
  }

  // Future<void> sendNotification() async {
  //   try {
  //     // Dapatkan token perangkat pengguna yang akan menerima notifikasi
  //     String? token = await FirebaseMessaging.instance.getToken();
  //
  //     // Kirim notifikasi menggunakan token perangkat
  //     await FirebaseMessaging.instance.send(
  //       // Konstruksi payload notifikasi
  //       RemoteMessage(
  //         data: {
  //           'title': 'Judul Notifikasi',
  //           'body': 'Isi notifikasi',
  //         },
  //         token: token,
  //       ),
  //     );
  //
  //     print('Notifikasi berhasil dikirim');
  //   } catch (e) {
  //     print('Gagal mengirim notifikasi: $e');
  //   }
  // }

  String statusError = "";
  String titleError = "";
  String descriptionError = "";
  String imageError = "";
  // bool _validateInputs() {
  //   bool isValid = true;
  //   RegExp regex = RegExp(r'^[A-Za-z\s]+$');
  //   // validasi nama hewan
  //   if (_namePetController.text.trim().isEmpty) {
  //     setState(() {
  //       petNameError = "Nama hewan diisi terlebih dahulu";
  //     });
  //     isValid = false;
  //   } else if (!regex.hasMatch(_namePetController.text.trim())) {
  //     setState(() {
  //       petNameError = "Simbol pada nama tidak valid";
  //     });
  //     isValid = false;
  //   } else {
  //     setState(() {
  //       petNameError = "";
  //     });
  //   }
  //   //validasi class
  //   if (temporarySelectedClass == null) {
  //     setState(() {
  //       petClassError = "Pilih kelas hewan terlebih dahulu";
  //     });
  //     isValid = false;
  //   } else {
  //     setState(() {
  //       petClassError = "";
  //     });
  //   }
  //   //validasi category
  //   if (temporarySelectedCategory == null) {
  //     setState(() {
  //       petCategoryError = "Pilih kategori hewan terlebih dahulu";
  //     });
  //     isValid = false;
  //   } else {
  //     setState(() {
  //       petCategoryError = "";
  //     });
  //   }
  //   //validasi species
  //   if (temporarySelectedSpecies == null) {
  //     setState(() {
  //       petSpeciesError = "Pilih jenis hewan terlebih dahulu";
  //     });
  //     isValid = false;
  //   } else {
  //     setState(() {
  //       petSpeciesError = "";
  //     });
  //   }
  //   //validasi gender
  //   if (temporarySelectedGender == null) {
  //     setState(() {
  //       petGenderError = "Pilih jenis hewan terlebih dahulu";
  //     });
  //     isValid = false;
  //   } else {
  //     setState(() {
  //       petGenderError = "";
  //     });
  //   }
  //   //validasi birth
  //   if (_birthController.text.trim().isEmpty) {
  //     setState(() {
  //       petBirthError = "Pilih tanggal lahir hewan anda terlebih dahulu";
  //     });
  //     isValid = false;
  //   } else {
  //     setState(() {
  //       petBirthError = "";
  //     });
  //   }
  //   //validasi fav food
  //   if (_favFoodController.text.trim().isEmpty) {
  //     setState(() {
  //       petFavFoodError = "Makanan favorit hewan diisi terlebih dahulu";
  //     });
  //     isValid = false;
  //   } else if (!regex.hasMatch(_favFoodController.text.trim())) {
  //     setState(() {
  //       petFavFoodError = "Simbol yang anda masukkan tidak valid";
  //     });
  //     isValid = false;
  //   } else {
  //     setState(() {
  //       petFavFoodError = "";
  //     });
  //   }
  //   return isValid;
  // }

  @override
  Widget build(BuildContext context) {
    print("drop desc : $descriptions");
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
      maxHeight: 40.h,
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
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, '/pet');
            },
          ),
          backgroundColor: const Color(0xffDC822A),
          flexibleSpace: const SafeArea(
            child: AppBarTitle(
              title: "Tambah Aktifitas Hewan",
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Deskripsi Utama",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  DropdownSearch<String>(
                    popupProps: PopupProps.menu(
                      showSelectedItems: true,
                      showSearchBox: true,
                      searchFieldProps: TextFieldProps(
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          suffixIcon: const Icon(
                            Ionicons.search_sharp,
                            color: Colors.orange,
                          ),
                          hintText: "Pencarian",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xFFDC822A)),
                          ),
                        ),
                      ),
                      searchDelay: const Duration(microseconds: 5000),
                    ),
                    items: (isFetchDesc)
                        ? ["Sedang Menunggu Data ..."]
                        : descriptions
                            .map((map) => map['name'].toString())
                            .toList(),
                    onChanged: (value) {
                      final selectedDescId = descriptions.firstWhere((map) =>
                          map['name'].toString() == value)['id_condition'];
                      print("value city ID: $selectedDescId");
                      setState(() {
                        selectedDesc = value;
                        // fetchDistricts(selectedDescId.toString());
                        tempDesc = selectedDescId!.toString();
                        print("value Desc:$selectedDesc");
                      });
                    },
                    selectedItem: selectedDesc,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        hintText: "Pilih Deskripsi",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: Color(0xFFDC822A)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Deskripsi Tambahan",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: descTambahanController,
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
                      hintText: "Masukkan Deskripsi Tambahan",
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
                          margin: const EdgeInsets.only(right: 10),
                          width: MediaQuery.sizeOf(context).width * 0.6,
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
                              pc.open();
                            });
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
              _image == null
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Pratinjau Gambar",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 5),
                        Center(
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              height: 240,
                              // width: 300,
                              decoration: BoxDecoration(
                                color: globalColors.bgOrangeDisabled,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: globalColors.textBlackSmall),
                              ),
                              child: Image.file(
                                File(_image!.path),
                                alignment: Alignment.center,
                                // width: 100,
                                // height: 100,
                                fit: BoxFit.contain,
                              )),
                        ),
                      ],
                    ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 9.h,
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(color: globalColors.borderLine, width: 0.5))),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            child: GestureDetector(
              onTap: () async {
                try {
                  final idReservationDetail = widget.idCondition;
                  final tempNote = descTambahanController.text.trim();
                  // final tempTitle = "Notifikasi Hewan";
                  File? selectedImage =
                      _image != null ? File(_image!.path) : null;

                  final result = await Pet.createPetCondition(
                      idReservationDetail, tempDesc!, tempNote, selectedImage);
                  print("object result: $result");

                  if (result['statusCode'] == 201) {
                    setState(() {
                      _switchPanelCondition = true;
                      pc.open();
                    });

                    // String? fcmToken =
                    //     await FirebaseMessaging.instance.getToken();
                    // print("FCM token: $fcmToken");
                    // await FirebaseMessaging.instance.sendMessage(
                    //   to: fcmToken!,
                    //   data: {
                    //     'title': 'Judul Notifikasi',
                    //     'body': 'Isi Notifikasi',
                    //   },
                    // );
                  }
                } catch (e) {
                  print('Terjadi kesalahan saat mengirim data: $e');
                }
              },
              child: const RectangleOrange(
                title: "Submit",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
