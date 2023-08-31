import 'dart:io';

// import 'package:anabulhotel/api/api_service.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../api/api_service.dart';
import '../../../../component/app_bar/app_bar_tittle.dart';
import '../../../../component/button/rectangle/rectangle_orange.dart';
import '../../../../component/user/user_panel/user_panel_success.dart';
import '../../../../component/user/user_panel/user_panel_update_photo.dart';
import '../../../../helper/global_colors.dart';

class DetailStaff extends StatefulWidget {
  const DetailStaff({Key? key, required this.user}) : super(key: key);
  final Map<String, dynamic> user;

  @override
  _DetailStaff createState() => _DetailStaff();
}

class _DetailStaff extends State<DetailStaff> {
  GlobalColors globalColors = GlobalColors();
  PanelController pc = PanelController();
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  bool _switchPanelCondition = false;
  final _nameController = TextEditingController();
  final _nikController = TextEditingController();
  late String genderData;
  DateTime? birth;
  String? birthData;
  String? provinceData;
  String? cityData;
  String? districtData;
  String? subDistrictData;
  String? _selectedGender;
  String? temporarySelectedGender;
  String? tempBirthSelected;
  String? userImage;
  String? id_user;
  String defaultImage = BaseImage.getImageUser();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  List<Map<String, dynamic>> provinces = [];
  List<Map<String, dynamic>> cities = [];
  List<Map<String, dynamic>> districts = [];
  List<Map<String, dynamic>> subDistricts = [];
  String? selectedProvince;
  String? selectedCity;
  String? selectedDistrict;
  String? selectedSubDistrict;
  String? tempProvince;
  String? tempCity;
  String? tempDistrict;
  String? tempSubDistrict;
  String? selectedProvinceId;
  String? selectedCityId;
  String? selectedDistrictId;
  String? selectedSubDistrictId;
  bool isFetchProvince = true;
  bool isFetchCities = true;
  bool isFetchDistricts = true;
  bool isFetchSubDistricts = true;

  @override
  void initState() {
    setState(() {
      userImage = defaultImage + widget.user['image'];
    });
    id_user = widget.user['id'];
    _nameController.text = widget.user['name'];
    _nikController.text = widget.user['nik'].toString();
    genderData = widget.user['gender'].toString();
    birth = DateTime.parse(widget.user['birth_date'].toString());
    print("print birth : $birth");
    birthData = DateFormat('dd/MM/yyyy').format(birth!);
    print("print birthData : $birthData");
    // birthData = widget.user['birth_date'];
    tempBirthSelected = birthData!;
    print("print tempBirthSelected : $tempBirthSelected");
    _phoneController.text = "0${widget.user['phone']}";
    _emailController.text = widget.user['email'];
    provinceData = widget.user['province']['name'];
    print("prov : $provinceData");
    cityData = widget.user['city']['name'];
    print("city : $cityData");
    districtData = widget.user['district']['name'];
    print("district : $districtData");
    subDistrictData = widget.user['subdistrict']['name'];
    print("subdis : $subDistrictData");
    _addressController.text = widget.user['address'];
    super.initState();
    fetchDropdownProvince();
  }

  Future<void> fetchDropdownProvince() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      print("terpilih prov: $selectedProvince");
      List<Map<String, dynamic>> provinceData = await Address.getProvince();
      setState(() {
        provinces = provinceData;
        isFetchProvince = false;
      });
    } catch (e) {
      print('Error fetching provinces: $e');
      setState(() {
        isFetchProvince = false;
        isFetchCities = false;
      });
    }
  }

  Future<void> fetchCities(int provinceId) async {
    print("ID PROV : $provinceId");
    try {
      await Future.delayed(const Duration(seconds: 3));
      List<Map<String, dynamic>> cityData = await Address.getCity(provinceId);
      print("object kota : $cityData"); // Simulate delay
      setState(() {
        cities = cityData;
        print("data kota : $cities");
        isFetchCities = false;
      });
    } catch (e) {
      print('Error fetching cities: $e');
      setState(() {
        isFetchCities = false;
      });
    }
  }

  Future<void> fetchDistrict(int cityId) async {
    print("ID city : $cityId");
    try {
      await Future.delayed(const Duration(seconds: 3));
      List<Map<String, dynamic>> districtData =
          await Address.getDistrict(cityId);
      print("object kec : $districtData"); // Simulate delay
      setState(() {
        districts = districtData;
        print("data kec : $districts");
        isFetchDistricts = false;
      });
    } catch (e) {
      print('Error fetching cities: $e');
      setState(() {
        isFetchDistricts = false;
      });
    }
  }

  Future<void> fetchSubDistrict(int districtId) async {
    print("ID district : $districtId");
    try {
      await Future.delayed(const Duration(seconds: 3));
      List<Map<String, dynamic>> subDistrictData =
          await Address.getSubDistrict(districtId);
      print("object des : $subDistrictData"); // Simulate delay
      setState(() {
        subDistricts = subDistrictData;
        print("data des : $subDistricts");
        isFetchSubDistricts = false;
      });
    } catch (e) {
      print('Error fetching cities: $e');
      setState(() {
        isFetchSubDistricts = false;
      });
    }
  }

  void _updateImage(XFile? image) {
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("data image update: $_image");
    bool isImageUploaded = _image != null;
    return SlidingUpPanel(
      panelBuilder: (ScrollController sc) {
        if (_switchPanelCondition == true) {
          return UserPanelSuccess(
            pc: pc,
            roles: widget.user['role'],
          );
        } else {
          return UserPanelUpdatePhoto(
            pc: pc,
            updateImage: _updateImage,
            picker: _picker,
            title: 'Ganti Foto Profil',
          );
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                                backgroundImage: () {
                                  if (isImageUploaded) {
                                    return Image.file(
                                      File(_image!.path),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ).image;
                                  } else {
                                    if (widget.user['image'] != defaultImage) {
                                      return NetworkImage(userImage!);
                                    } else {
                                      return NetworkImage(
                                          "${defaultImage}default_user.png");
                                    }
                                  }
                                }(),
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
                                            _switchPanelCondition != true;
                                            pc.open();
                                          },
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8)),
                                          splashColor:
                                              globalColors.bgOrangeDisabled,
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        globalColors.bgOrange,
                                                    width: 1),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(100))),
                                            child: Padding(
                                              padding: const EdgeInsets.all(2),
                                              child: Icon(
                                                Icons.camera_enhance_rounded,
                                                size: 16,
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
                    const SizedBox(height: 10),
                    const Text(
                      "Pasang Foto Terbaik Anda!",
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.w300),
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
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 5),
                    TextField(
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
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 5),
                    TextField(
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
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 17),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: globalColors.textBlackSmall),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 200,
                            // color: Colors.amber,
                            child: Text(
                              birthData!,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.w400),
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
                                    print("object birthData: $birthData");
                                    tempBirthSelected = DateFormat('yyyy-MM-dd')
                                        .format(selectedDate);
                                    print(
                                        "object tempBirthSelected: $tempBirthSelected");
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
                // genderData != null && genderData.isNotEmpty
                //     ? Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           const Text(
                //             "Jenis Kelamin",
                //             textAlign: TextAlign.start,
                //             style: TextStyle(
                //                 fontSize: 12, fontWeight: FontWeight.w600),
                //           ),
                //           const SizedBox(height: 5),
                //           DropdownButtonFormField(
                //             decoration: InputDecoration(
                //               contentPadding:
                //                   const EdgeInsets.symmetric(horizontal: 20),
                //               enabledBorder: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(8),
                //                 borderSide: BorderSide(
                //                     color: globalColors.textBlackBold),
                //               ),
                //               focusedBorder: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(8),
                //                 borderSide:
                //                     const BorderSide(color: Color(0xFFDC822A)),
                //               ),
                //               hintText: "Jenis Kelamin",
                //             ),
                //             value: genderData,
                //             onChanged: (String? value) {
                //               setState(() {
                //                 _selectedGender = value;
                //                 temporarySelectedGender = value!;
                //               });
                //             },
                //             items: const [
                //               DropdownMenuItem(
                //                 value: "Laki-laki",
                //                 child: Text("Laki - Laki"),
                //               ),
                //               DropdownMenuItem(
                //                 value: "Perempuan",
                //                 child: Text("Perempuan"),
                //               ),
                //             ],
                //           ),
                //         ],
                //       )
                //     : Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           const Text(
                //             "Jenis Kelamin",
                //             textAlign: TextAlign.start,
                //             style: TextStyle(
                //                 fontSize: 12, fontWeight: FontWeight.w600),
                //           ),
                //           const SizedBox(height: 5),
                //           DropdownButtonFormField(
                //             decoration: InputDecoration(
                //               contentPadding:
                //                   const EdgeInsets.symmetric(horizontal: 20),
                //               enabledBorder: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(8),
                //                 borderSide: BorderSide(
                //                     color: globalColors.textBlackBold),
                //               ),
                //               focusedBorder: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(8),
                //                 borderSide:
                //                     const BorderSide(color: Color(0xFFDC822A)),
                //               ),
                //               hintText: "Jenis Kelamin",
                //             ),
                //             value: _selectedGender,
                //             onChanged: (String? value) {
                //               setState(() {
                //                 _selectedGender = value;
                //                 temporarySelectedGender = value!;
                //               });
                //             },
                //             items: const [
                //               DropdownMenuItem(
                //                 value: "Laki-laki",
                //                 child: Text("Laki - Laki"),
                //               ),
                //               DropdownMenuItem(
                //                 value: "Perempuan",
                //                 child: Text("Perempuan"),
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                // const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Jenis Kelamin",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
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
                          borderSide:
                              const BorderSide(color: Color(0xFFDC822A)),
                        ),
                        hintText: "Jenis Kelamin",
                      ),
                      value: (genderData != null && genderData.isNotEmpty)
                          ? genderData
                          : _selectedGender,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedGender = value;
                          temporarySelectedGender = value!;
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
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 5),
                    TextField(
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
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 5),
                    TextField(
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
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.only(top: 15),
                  decoration: const BoxDecoration(
                      border: Border(top: BorderSide(width: 0.2))),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Provinsi",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 5),
                          DropdownSearch<String>(
                            popupProps: PopupProps.menu(
                              showSelectedItems: true,
                              // disabledItemFn: (String s) => s.startsWith('I'),
                              showSearchBox: true,
                              searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: globalColors.textBlackBold),
                                ),
                                suffixIcon: Icon(
                                  Ionicons.search_sharp,
                                  color: globalColors.bgOrange,
                                ),
                                hintText: "Pencarian",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFDC822A)),
                                ),
                              )),
                              searchDelay: const Duration(microseconds: 5000),
                            ),
                            items: (isFetchProvince)
                                ? ["Sedang Menunggu Data ..."]
                                : provinces
                                    .map((map) => map['name'].toString())
                                    .toList(),
                            onChanged: (value) {
                              setState(() {
                                // Ambil ID dari item yang dipilih berdasarkan nilai value
                                final selectedProvinceId = provinces.firstWhere(
                                    (map) =>
                                        map['name'].toString() ==
                                        value)['id_province'];
                                print("value province ID: $selectedProvinceId");
                                selectedProvince = value;
                                tempProvince = selectedProvince!;
                                fetchCities(selectedProvinceId);
                                print("value prov: $selectedProvince");
                              });
                            },
                            selectedItem: (provinceData != null &&
                                    provinceData!.isNotEmpty)
                                ? provinceData
                                : selectedProvince,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: globalColors.textBlackBold),
                                ),
                                hintText: "Pilih Provinsi",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFDC822A)),
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
                            "Kabupaten",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 5),
                          DropdownSearch<String>(
                            popupProps: PopupProps.menu(
                              showSelectedItems: true,
                              // disabledItemFn: (String s) => s.startsWith('I'),
                              showSearchBox: true,
                              searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: globalColors.textBlackBold),
                                ),
                                suffixIcon: Icon(
                                  Ionicons.search_sharp,
                                  color: globalColors.bgOrange,
                                ),
                                hintText: "Pencarian",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFDC822A)),
                                ),
                              )),
                              searchDelay: const Duration(microseconds: 5000),
                            ),
                            items: (isFetchCities)
                                ? ["Sedang Menunggu Data ..."]
                                : cities
                                    .map((map) => map['name'].toString())
                                    .toList(),
                            onChanged: (value) {
                              final selectedCityId = cities.firstWhere((map) =>
                                  map['name'].toString() == value)['id_city'];

                              setState(() {
                                selectedCity = value;
                                tempCity = selectedCity!;
                                fetchDistrict(selectedCityId);
                              });
                            },
                            selectedItem:
                                (cityData != null && cityData!.isNotEmpty)
                                    ? cityData
                                    : selectedCity,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: globalColors.textBlackBold),
                                ),
                                hintText: "Pilih Kabupaten / Kota",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFDC822A)),
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
                            "Kecamatan",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 5),
                          DropdownSearch<String>(
                            popupProps: PopupProps.menu(
                              showSelectedItems: true,
                              // disabledItemFn: (String s) => s.startsWith('I'),
                              showSearchBox: true,
                              searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: globalColors.textBlackBold),
                                ),
                                suffixIcon: Icon(
                                  Ionicons.search_sharp,
                                  color: globalColors.bgOrange,
                                ),
                                hintText: "Pencarian",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFDC822A)),
                                ),
                              )),
                              searchDelay: const Duration(microseconds: 5000),
                            ),
                            items: (isFetchDistricts)
                                ? ["Sedang Menunggu Data ..."]
                                : districts
                                    .map((map) => map['name'].toString())
                                    .toList(),
                            onChanged: (value) {
                              final selectedDistrictId = districts.firstWhere(
                                      (map) => map['name'].toString() == value)[
                                  'id_district'];

                              setState(() {
                                selectedDistrict = value;
                                tempDistrict = selectedDistrict!;
                                fetchSubDistrict(selectedDistrictId);
                              });
                            },
                            selectedItem: (districtData != null &&
                                    districtData!.isNotEmpty)
                                ? districtData
                                : selectedDistrict,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: globalColors.textBlackBold),
                                ),
                                hintText: "Pilih Kecamatan",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFDC822A)),
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
                            "Desa / Kelurahan",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 5),
                          DropdownSearch<String>(
                            popupProps: PopupProps.menu(
                              showSelectedItems: true,
                              // disabledItemFn: (String s) => s.startsWith('I'),
                              showSearchBox: true,
                              searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: globalColors.textBlackBold),
                                ),
                                suffixIcon: Icon(
                                  Ionicons.search_sharp,
                                  color: globalColors.bgOrange,
                                ),
                                hintText: "Pencarian",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFDC822A)),
                                ),
                              )),
                              searchDelay: const Duration(microseconds: 5000),
                            ),
                            items: (isFetchSubDistricts)
                                ? ["Sedang Menunggu Data ..."]
                                : subDistricts
                                    .map((map) => map['name'].toString())
                                    .toList(),
                            onChanged: (value) {
                              final selectedSubDistrictId =
                                  subDistricts.firstWhere((map) =>
                                      map['name'].toString() ==
                                      value)['id_district'];

                              setState(() {
                                selectedSubDistrict = value;
                                tempSubDistrict = selectedSubDistrict!;
                              });
                            },
                            selectedItem: (subDistrictData != null &&
                                    subDistrictData!.isNotEmpty)
                                ? subDistrictData
                                : selectedSubDistrict,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: globalColors.textBlackBold),
                                ),
                                hintText: "Pilih Desa / Kelurahan",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFDC822A)),
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
              ],
            ),
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
                  setState(() {
                    _switchPanelCondition = true;
                    pc.open();
                  });
                  final id = id_user!;
                  final name = _nameController.text;
                  // print(name);
                  final nik = int.parse(_nikController.text);
                  // print(nik);
                  final gender = temporarySelectedGender ?? genderData;
                  // print(gender);
                  final phone = int.parse(_phoneController.text);
                  final email = _emailController.text;
                  final address = _addressController.text;
                  final birthDate = tempBirthSelected!;
                  print("result birthDate: $birthDate");
                  File? selectedImage =
                      _image != null ? File(_image!.path) : null;

                  var result = await ApiService.updateUser(
                      id,
                      name,
                      nik,
                      birthDate,
                      gender,
                      phone,
                      email,
                      address,
                      tempProvince!,
                      tempCity!,
                      tempDistrict!,
                      tempSubDistrict!,
                      selectedImage);
                  print("object hasil : $result");
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
  // GlobalColors globalColors = GlobalColors();
  // PanelController pc = PanelController();
  // XFile? _image;
  // final ImagePicker _picker = ImagePicker();
  // bool _switchPanelCondition = false;
  // final _nameController = TextEditingController();
  // final _nikController = TextEditingController();
  // late String genderData;
  // DateTime? birth;
  // String? birthData;
  // String? _selectedGender;
  // String? temporarySelectedGender;
  // String? tempBirthSelected;
  // String? userImage;
  // String? id_user;
  // String defaultImage = BaseImage.getImageUser();
  // final _phoneController = TextEditingController();
  // final _emailController = TextEditingController();
  // final _addressController = TextEditingController();

  // @override
  // void initState() {
  //   // print("isi data: ${widget.user}");
  //   setState(() {
  //     userImage = defaultImage + widget.user['image'];
  //   });
  //   id_user = widget.user['id'];
  //   _nameController.text = widget.user['name'];
  //   _nikController.text = widget.user['nik'].toString();
  //   genderData = widget.user['gender'].toString();
  //   birth = DateTime.parse(widget.user['birth_date'].toString());
  //   birthData = DateFormat('dd/MM/yyyy').format(birth!);
  //   // birthData = widget.user['birth_date'];
  //   tempBirthSelected = birthData!;
  //   _phoneController.text = "0${widget.user['phone']}";
  //   _emailController.text = widget.user['email'];
  //   _addressController.text = widget.user['address'];
  //   super.initState();
  // }

  // void _updateImage(XFile? image) {
  //   setState(() {
  //     _image = image;
  //     // print("gambar apa: $_image");
  //     // print("gambar apa: $image");
  //   });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   bool isImageUploaded = _image != null;
  //   // print("tes:: $userImage");
  //   return SlidingUpPanel(
  //     panelBuilder: (ScrollController sc) {
  //       if (_switchPanelCondition == true) {
  //         // return Text(_switchPanelCondition.toString());
  //         // if(form == kosong){
  //         //   return alert nek isih kosong;
  //         // }
  //         return UserPanelSuccess(pc: pc, roles: widget.user['role']);
  //       } else {
  //         return UserPanelUpdatePhoto(
  //           pc: pc,
  //           updateImage: _updateImage,
  //           picker: _picker,
  //           title: 'Ganti Foto Profil',
  //         );
  //         // return Text(_switchPanelCondition.toString());
  //       }
  //     },
  //     controller: pc,
  //     isDraggable: true,
  //     maxHeight: 40.h,
  //     minHeight: 0,
  //     backdropEnabled: true,
  //     backdropTapClosesPanel: false,
  //     borderRadius: const BorderRadius.only(
  //         topLeft: Radius.circular(16), topRight: Radius.circular(16)),
  //     body: Scaffold(
  //       resizeToAvoidBottomInset: false,
  //       appBar: AppBar(
  //         elevation: 0,
  //         leading: IconButton(
  //           icon: const Icon(Icons.arrow_back),
  //           onPressed: () {
  //             Navigator.pop(context, '/dashboardPageView');
  //           },
  //         ),
  //         backgroundColor: const Color(0xffDC822A),
  //         flexibleSpace: const SafeArea(
  //           child: AppBarTitle(
  //             title: "Edit User",
  //           ),
  //         ),
  //       ),
  //       body: SingleChildScrollView(
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.stretch,
  //             children: [
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       SizedBox(
  //                         width: 100,
  //                         height: 100,
  //                         child: Stack(
  //                           children: [
  //                             CircleAvatar(
  //                               radius: 80,
  //                               backgroundImage: () {
  //                                 if (isImageUploaded) {
  //                                   return Image.file(
  //                                     File(_image!.path),
  //                                     width: 100,
  //                                     height: 100,
  //                                     fit: BoxFit.cover,
  //                                   ).image;
  //                                 } else {
  //                                   if (widget.user['image'] != defaultImage) {
  //                                     return NetworkImage(userImage!);
  //                                   } else {
  //                                     return NetworkImage(
  //                                         "${defaultImage}default_user.png");
  //                                   }
  //                                 }
  //                               }(),
  //                               backgroundColor: globalColors.bgOrangeDisabled,
  //                             ),
  //                             Row(
  //                               mainAxisAlignment: MainAxisAlignment.end,
  //                               children: [
  //                                 Column(
  //                                   mainAxisAlignment: MainAxisAlignment.end,
  //                                   children: [
  //                                     Material(
  //                                       color: Colors.transparent,
  //                                       child: InkWell(
  //                                         onTap: () {
  //                                           pc.open();
  //                                         },
  //                                         borderRadius: const BorderRadius.all(
  //                                             Radius.circular(8)),
  //                                         splashColor:
  //                                             globalColors.bgOrangeDisabled,
  //                                         child: Container(
  //                                           width: 30,
  //                                           height: 30,
  //                                           decoration: BoxDecoration(
  //                                               color: Colors.white,
  //                                               border: Border.all(
  //                                                   color:
  //                                                       globalColors.bgOrange,
  //                                                   width: 1),
  //                                               borderRadius:
  //                                                   const BorderRadius.all(
  //                                                       Radius.circular(100))),
  //                                           child: Padding(
  //                                             padding: const EdgeInsets.all(2),
  //                                             child: Icon(
  //                                               Icons.camera_enhance_rounded,
  //                                               size: 16,
  //                                               color: globalColors.bgOrange,
  //                                             ),
  //                                             // child: Image.asset("assets/icons/icon-edit-profile.png", scale: 3.5),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     )
  //                                   ],
  //                                 ),
  //                               ],
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   const SizedBox(height: 10),
  //                   const Text(
  //                     "Pasang Foto Terbaik Anda!",
  //                     style:
  //                         TextStyle(fontSize: 11, fontWeight: FontWeight.w300),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 10),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   const Text(
  //                     "Nama",
  //                     textAlign: TextAlign.start,
  //                     style:
  //                         TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
  //                   ),
  //                   const SizedBox(height: 5),
  //                   TextField(
  //                     decoration: InputDecoration(
  //                       contentPadding:
  //                           const EdgeInsets.symmetric(horizontal: 20),
  //                       enabledBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                         borderSide:
  //                             BorderSide(color: globalColors.textBlackBold),
  //                       ),
  //                       focusedBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                         borderSide:
  //                             const BorderSide(color: Color(0xFFDC822A)),
  //                       ),
  //                       hintText: "Nama Lengkap",
  //                     ),
  //                     controller: _nameController,
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 10),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   const Text(
  //                     "NIK",
  //                     textAlign: TextAlign.start,
  //                     style:
  //                         TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
  //                   ),
  //                   const SizedBox(height: 5),
  //                   TextField(
  //                     decoration: InputDecoration(
  //                       contentPadding:
  //                           const EdgeInsets.symmetric(horizontal: 20),
  //                       enabledBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                         borderSide:
  //                             BorderSide(color: globalColors.textBlackBold),
  //                       ),
  //                       focusedBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                         borderSide:
  //                             const BorderSide(color: Color(0xFFDC822A)),
  //                       ),
  //                       hintText: "Nomor Induk Kependudukan",
  //                     ),
  //                     controller: _nikController,
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 16),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   const Text(
  //                     "Tanggal Lahir",
  //                     textAlign: TextAlign.start,
  //                     style:
  //                         TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
  //                   ),
  //                   const SizedBox(height: 5),
  //                   Container(
  //                     width: MediaQuery.of(context).size.width,
  //                     height: 50,
  //                     padding: const EdgeInsets.symmetric(horizontal: 17),
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(8),
  //                       border: Border.all(color: globalColors.textBlackSmall),
  //                     ),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         SizedBox(
  //                           width: 290,
  //                           child: Text(
  //                             birthData!,
  //                             textAlign: TextAlign.start,
  //                             style: TextStyle(
  //                                 fontSize: 12.sp, fontWeight: FontWeight.w400),
  //                           ),
  //                         ),
  //                         GestureDetector(
  //                           onTap: () {
  //                             showDatePicker(
  //                               context: context,
  //                               initialDate: DateTime.now(),
  //                               firstDate: DateTime(1900),
  //                               lastDate: DateTime.now(),
  //                             ).then((selectedDate) {
  //                               if (selectedDate != null) {
  //                                 setState(() {
  //                                   birthData = DateFormat('dd/MM/yyyy')
  //                                       .format(selectedDate);
  //                                   // print("data isi apa: $birthData");
  //                                   tempBirthSelected = DateFormat('yyyy-MM-dd')
  //                                       .format(selectedDate);
  //                                   // print("data isi ya: $tempBirthSelected");
  //                                 });
  //                               }
  //                             });
  //                           },
  //                           child: Icon(
  //                             Icons.calendar_month_rounded,
  //                             color: globalColors.textBlackSmall,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 16),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   const Text(
  //                     "Jenis Kelamin",
  //                     textAlign: TextAlign.start,
  //                     style:
  //                         TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
  //                   ),
  //                   const SizedBox(height: 5),
  //                   DropdownButtonFormField(
  //                     decoration: InputDecoration(
  //                       contentPadding:
  //                           const EdgeInsets.symmetric(horizontal: 20),
  //                       enabledBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                         borderSide:
  //                             BorderSide(color: globalColors.textBlackBold),
  //                       ),
  //                       focusedBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                         borderSide:
  //                             const BorderSide(color: Color(0xFFDC822A)),
  //                       ),
  //                       hintText: "Jenis Kelamin",
  //                     ),
  //                     value: _selectedGender ?? genderData,
  //                     onChanged: (String? value) {
  //                       setState(() {
  //                         _selectedGender = value;
  //                         temporarySelectedGender = value!;
  //                       });
  //                     },
  //                     items: const [
  //                       DropdownMenuItem(
  //                         value: "Laki-laki",
  //                         child: Text("Laki - Laki"),
  //                       ),
  //                       DropdownMenuItem(
  //                         value: "Perempuan",
  //                         child: Text("Perempuan"),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 16),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   const Text(
  //                     "No. Telepon",
  //                     textAlign: TextAlign.start,
  //                     style:
  //                         TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
  //                   ),
  //                   const SizedBox(height: 5),
  //                   TextField(
  //                     decoration: InputDecoration(
  //                       contentPadding:
  //                           const EdgeInsets.symmetric(horizontal: 20),
  //                       enabledBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                         borderSide:
  //                             BorderSide(color: globalColors.textBlackBold),
  //                       ),
  //                       focusedBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                         borderSide:
  //                             const BorderSide(color: Color(0xFFDC822A)),
  //                       ),
  //                       hintText: "Nomor Telepon",
  //                     ),
  //                     controller: _phoneController,
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 16),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   const Text(
  //                     "Alamat Email",
  //                     textAlign: TextAlign.start,
  //                     style:
  //                         TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
  //                   ),
  //                   const SizedBox(height: 5),
  //                   TextField(
  //                     decoration: InputDecoration(
  //                       contentPadding:
  //                           const EdgeInsets.symmetric(horizontal: 20),
  //                       enabledBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                         borderSide:
  //                             BorderSide(color: globalColors.textBlackBold),
  //                       ),
  //                       focusedBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                         borderSide:
  //                             const BorderSide(color: Color(0xFFDC822A)),
  //                       ),
  //                       hintText: "Alamat Email",
  //                     ),
  //                     controller: _emailController,
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 16),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   const Text(
  //                     "Alamat",
  //                     textAlign: TextAlign.start,
  //                     style:
  //                         TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
  //                   ),
  //                   const SizedBox(height: 5),
  //                   TextField(
  //                     decoration: InputDecoration(
  //                       contentPadding:
  //                           const EdgeInsets.symmetric(horizontal: 20),
  //                       enabledBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                         borderSide:
  //                             BorderSide(color: globalColors.textBlackBold),
  //                       ),
  //                       focusedBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                         borderSide:
  //                             const BorderSide(color: Color(0xFFDC822A)),
  //                       ),
  //                       hintText: "Alamat Rumah",
  //                     ),
  //                     controller: _addressController,
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       bottomNavigationBar: Container(
  //         height: 9.h,
  //         decoration: BoxDecoration(
  //             border: Border(
  //                 top: BorderSide(color: globalColors.borderLine, width: 0.5))),
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
  //           child: GestureDetector(
  //             onTap: () async {
  //               try {
  //                 setState(() {
  //                   _switchPanelCondition = true;
  //                   pc.open();
  //                 });
  //                 final id = id_user!;
  //                 final name = _nameController.text;
  //                 // print(name);
  //                 final nik = int.parse(_nikController.text);
  //                 // print(nik);
  //                 final gender = temporarySelectedGender ?? genderData;
  //                 // print(gender);
  //                 final phone = int.parse(_phoneController.text);
  //                 final email = _emailController.text;
  //                 final address = _addressController.text;
  //                 final birthDate = tempBirthSelected!;
  //                 File? selectedImage =
  //                     _image != null ? File(_image!.path) : null;

  //                 var result = await ApiService.updateUser(id, name, nik,
  //                     birthDate, gender, phone, email, address, selectedImage);
  //                 print("data update : $result");

  //                 // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => DashboardPageViewStaff()));
  //                 // ScaffoldMessenger.of(context).showSnackBar(
  //                 //   const SnackBar(content: Center(child: Text('Data berhasil diubah'))),
  //                 // );
  //               } catch (e) {
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   SnackBar(content: Text('$e')),
  //                 );
  //               }
  //             },
  //             child: const RectangleOrange(
  //               title: "Simpan",
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
