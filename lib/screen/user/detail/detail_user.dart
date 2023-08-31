import 'dart:io';

// import 'package:anabulhotel/api/api_service.dart';
// import 'package:anabulhotel/screen/dashboard/dashboard_pageview.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../api/api_service.dart';
import '../../../component/app_bar/app_bar_tittle.dart';
import '../../../component/button/rectangle/rectangle_orange.dart';
import '../../../component/user/user_panel/user_panel_success.dart';
import '../../../component/user/user_panel/user_panel_update_photo.dart';
import '../../../helper/global_colors.dart';
import '../../../helper/session.dart';

class DetailUser extends StatefulWidget {
  const DetailUser({Key? key}) : super(key: key);

  @override
  _DetailUserState createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  GlobalColors globalColors = GlobalColors();
  PanelController pc = PanelController();
  XFile? _image;
  ImagePicker _picker = ImagePicker();
  bool _switchPanelCondition = false;
  final _nameController = TextEditingController();
  final _nikController = TextEditingController();
  String? genderData;
  String? tempBirthSelected;
  String? birthData;
  String? id_user;
  String? role;
  String? imageData;
  String? _selectedGender;
  String? temporarySelectedGender;
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _updateImage(XFile? image) {
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      panelBuilder: (ScrollController sc) {
        if (_switchPanelCondition == true) {
          // return Text(_switchPanelCondition.toString());
          // if(form == kosong){
          //   return alert nek isih kosong;
          // }
          return UserPanelSuccess(
            pc: pc,
            roles: role,
          );
        } else {
          return UserPanelUpdatePhoto(
            pc: pc,
            updateImage: _updateImage,
            picker: _picker,
            title: 'Ganti Foto Profil',
          );
          // return Text(_switchPanelCondition.toString());
        }
      },
      controller: pc,
      isDraggable: true,
      maxHeight: 40.h,
      minHeight: 0,
      backdropEnabled: true,
      backdropTapClosesPanel: false,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      body: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, '/dashboardPageView');
            },
          ),
          backgroundColor: const Color(0xffDC822A),
          flexibleSpace: const SafeArea(
            child: AppBarTitle(
              title: "Edit User",
            ),
          ),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: ApiService.getDataUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              bool isImageUploaded = _image != null;
              String defaultImage = BaseImage.getImageUser();
              final user = snapshot.data!;
              DateTime birth = DateTime.parse(user['birth_date'].toString());
              // print("object: $user");
              id_user = user['id'];
              _nameController.text = user['name'];
              _nikController.text = user['nik'].toString();
              genderData = user['gender'].toString();
              imageData = user['image'];
              role = user['role'];
              birthData = DateFormat('dd/MM/yyyy').format(birth);
              tempBirthSelected = birthData;
              print(birthData);
              _phoneController.text = "0${user['phone']}";
              _emailController.text = user['email'];
              _addressController.text = user['address'];
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 80,
                                      backgroundImage: () {
                                        if (isImageUploaded) {
                                          return Image.file(
                                            File(_image!.path),
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ).image;
                                        } else {
                                          if (imageData!.isEmpty) {
                                            return Image.asset(
                                                    'assets/background/default_user.png')
                                                .image;
                                          } else {
                                            return NetworkImage(
                                                defaultImage + imageData!);
                                          }
                                        }
                                      }(),
                                      backgroundColor:
                                          globalColors.bgOrangeDisabled,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () {
                                                  pc.open();
                                                },
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(8)),
                                                splashColor: globalColors
                                                    .bgOrangeDisabled,
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: globalColors
                                                              .bgOrange,
                                                          width: 1),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  100))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(2),
                                                    child: Icon(
                                                      Icons
                                                          .camera_enhance_rounded,
                                                      size: 16,
                                                      color:
                                                          globalColors.bgOrange,
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
                          const SizedBox(height: 10),
                          const Text(
                            "Pasang Foto Terbaik Anda!",
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Nama",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 5),
                          TextField(
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: globalColors.textBlackBold),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Color(0xFFDC822A)),
                              ),
                              hintText: "Nama Lengkap",
                            ),
                            controller: _nameController,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "NIK",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 5),
                          TextField(
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: globalColors.textBlackBold),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Color(0xFFDC822A)),
                              ),
                              hintText: "Nomor Induk Kependudukan",
                            ),
                            controller: _nikController,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Tanggal Lahir",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 17),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: globalColors.textBlackSmall),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 290,
                                  child: Text(
                                    birthData!,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                    ).then((selectedDate) {
                                      if (selectedDate != null) {
                                        setState(() {
                                          birthData = DateFormat('dd/MM/yyyy')
                                              .format(selectedDate);
                                          print("data isi apa: $birthData");
                                          tempBirthSelected =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(selectedDate);
                                          print(
                                              "data isi ya: $tempBirthSelected");
                                        });
                                      }
                                    });
                                  },
                                  child: Icon(
                                    Icons.calendar_month_rounded,
                                    color: globalColors.textBlackSmall,
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
                            "Jenis Kelamin",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 5),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: globalColors.textBlackBold),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Color(0xFFDC822A)),
                              ),
                              hintText: "Jenis Kelamin",
                            ),
                            value: genderData!.isNotEmpty
                                ? genderData
                                : _selectedGender,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedGender = value;
                                temporarySelectedGender = value!;
                                print("kelamin : $_selectedGender");
                                print("kelamin tes : $temporarySelectedGender");
                              });
                            },
                            items: const [
                              DropdownMenuItem(
                                value: "Laki-laki",
                                child: Text("Laki - Laki"),
                              ),
                              DropdownMenuItem(
                                value: "Perempuan",
                                child: Text("Perempuan"),
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
                            "No. Telepon",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 5),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: globalColors.textBlackBold),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Color(0xFFDC822A)),
                              ),
                              hintText: "Nomor Telepon",
                            ),
                            controller: _phoneController,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Alamat Email",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 5),
                          TextField(
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: globalColors.textBlackBold),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Color(0xFFDC822A)),
                              ),
                              hintText: "Alamat Email",
                            ),
                            controller: _emailController,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Alamat",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 5),
                          TextField(
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: globalColors.textBlackBold),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Color(0xFFDC822A)),
                              ),
                              hintText: "Alamat Rumah",
                            ),
                            controller: _addressController,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
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
                  final id = id_user!;
                  final name = _nameController.text;
                  print(name);
                  final nik = int.parse(_nikController.text);
                  print(nik);
                  final gender = temporarySelectedGender ?? genderData;
                  print(" : $gender");
                  final phone = int.parse(_phoneController.text);
                  final email = _emailController.text;
                  final address = _addressController.text;
                  final birth_date = tempBirthSelected!;
                  File? selectedImage =
                      _image != null ? File(_image!.path) : null;

                  var result = await ApiService.updateUser(
                      id,
                      name,
                      nik,
                      birth_date,
                      gender!,
                      phone,
                      email,
                      address,
                      address,
                      address,
                      address,
                      address,
                      selectedImage);
                  print("data update : ${result}");
                  setState(() {
                    _switchPanelCondition = true;
                    pc.open();
                  });

                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => DashboardPageView()));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Center(child: Text('Data berhasil diubah'))),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$e')),
                  );
                }
              },
              child: const RectangleOrange(
                title: "Simpan",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
