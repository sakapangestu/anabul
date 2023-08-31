// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:ionicons/ionicons.dart';
// import 'dart:convert';

// import '../../api/api_service.dart';
// import '../../component/app_bar/app_bar_tittle.dart';
// import '../../component/app_bar/app_bar_tittle_menu_bar.dart';
// import '../../component/pet/pet_list.dart';
// import '../../helper/global_colors.dart';
// import '../../helper/session.dart';
// import '../../model/data.dart';
// import '../condition/condition_list.dart';
// import '../hotel_pet/hotel_list.dart';
// // import 'package:fluttertoast/fluttertoast.dart';

// class HotelSearchTes extends StatefulWidget {
//   const HotelSearchTes({Key? key}) : super(key: key);

//   @override
//   State<HotelSearchTes> createState() => _HotelSearchTesState();
// }

// class _HotelSearchTesState extends State<HotelSearchTes> {
//   final TextEditingController _searchController = TextEditingController();
//   GlobalColors globalColors = GlobalColors();
//   List<Map<String, dynamic>> provinces = [];
//   List<Map<String, dynamic>> cities = [];
//   List<Map<String, dynamic>> districts = [];
//   List<Map<String, dynamic>> subDistricts = [];
//   String? selectedProvince;
//   String? selectedCity;
//   String? selectedDistrict;
//   String? selectedSubDistrict;
//   bool isFetchProvince = true;
//   bool isFetchCities = true;
//   bool isFetchDistricts = true;
//   bool isFetchSubDistricts = true;
//   // List<Pets> _conditionList = [];
//   // List<Pets> _filteredconditionList = [];
//   // String imagePath = BaseImage.getImagePet();

//   @override
//   void initState() {
//     super.initState();
//     fetchDropdown();
//   }

//   // @override
//   // void dispose() {
//   //   _searchController.dispose();
//   //   super.dispose();
//   // }

//   // Future<void> _fetchConditionList() async {
//   //   try {
//   //     final List<Pets> pets = await ApiService.getDataPet();

//   //     setState(() {
//   //       _conditionList = pets;
//   //       _filteredconditionList = pets;
//   //     });
//   //   } catch (e) {
//   //     print('Error: $e');
//   //     // Handle error
//   //   }
//   // }

//   // void _filterConditionList(String query) {
//   //   List<Pets> filteredList = [];

//   //   if (query.isEmpty) {
//   //     filteredList = List<Pets>.from(_conditionList);
//   //   } else {
//   //     filteredList = _conditionList.where((condition) {
//   //       final String petName = condition.name.toString().toLowerCase();
//   //       return petName.contains(query.toLowerCase());
//   //     }).toList();
//   //   }

//   //   setState(() {
//   //     _filteredconditionList = filteredList;
//   //   });
//   // }

//   // void showToastMessage(String message) {
//   //   Fluttertoast.showToast(
//   //       msg: message, //message to show toast
//   //       toastLength: Toast.LENGTH_LONG, //duration for message to show
//   //       gravity: ToastGravity.CENTER, //where you want to show, top, bottom
//   //       timeInSecForIosWeb: 1, //for iOS only
//   //       //backgroundColor: Colors.red, //background Color for message
//   //       textColor: Colors.white, //message text color
//   //       fontSize: 16.0 //message font size
//   //       );
//   // }

//   Future<void> fetchDropdown() async {
//     try {
//       await Future.delayed(Duration(seconds: 3));
//       print("terpilih prov: $selectedProvince");
//       final List<Map<String, dynamic>> provinceData = [
//         {'id_province': '1', 'name': 'Province A'},
//         {'id_province': '2', 'name': 'Province B'},
//         // Add more provinces here
//       ];

//       // List<Map<String, dynamic>> provinceData = await Address.getProvince();
//       // List<Map<String, dynamic>> cityData =
//       //     await Address.getCity(selectedProvince);
//       setState(() {
//         provinces = provinceData;
//         isFetchProvince = false;
//       });
//     } catch (e) {
//       print('Error fetching provinces: $e');
//       setState(() {
//         isFetchProvince = false;
//         isFetchCities = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           elevation: 0.5,
//           leading: Icon(Ionicons.reorder_four, color: globalColors.iconOrange),
//           backgroundColor: Colors.white,
//           flexibleSpace: const SafeArea(
//             child: AppBarTitleMenuBar(
//               title: "Kondisi",
//             ),
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
//           child: Column(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Provinsi",
//                     textAlign: TextAlign.start,
//                     style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(height: 5),
//                   DropdownSearch<String>(
//                     popupProps: PopupProps.menu(
//                       showSelectedItems: true,
//                       // disabledItemFn: (String s) => s.startsWith('I'),
//                       showSearchBox: true,
//                       searchFieldProps: TextFieldProps(
//                           decoration: InputDecoration(
//                         contentPadding:
//                             const EdgeInsets.symmetric(horizontal: 20),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide:
//                               BorderSide(color: globalColors.textBlackBold),
//                         ),
//                         suffixIcon: Icon(
//                           Ionicons.search_sharp,
//                           color: globalColors.bgOrange,
//                         ),
//                         hintText: "Pencarian",
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide:
//                               const BorderSide(color: Color(0xFFDC822A)),
//                         ),
//                       )),
//                       searchDelay: const Duration(microseconds: 5000),
//                     ),
//                     items: (isFetchProvince)
//                         ? ["Sedang Menunggu Data ..."]
//                         : provinces
//                             .map((map) => map['name'].toString())
//                             .toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         // Ambil ID dari item yang dipilih berdasarkan nilai value
//                         final selectedProvinceId = provinces.firstWhere((map) =>
//                             map['name'].toString() == value)['id_province'];
//                         print("value province ID: $selectedProvinceId");
//                         selectedProvince = value;
//                         print("value prov: $selectedProvince");
//                       });
//                     },
//                     selectedItem: selectedProvince,
//                     dropdownDecoratorProps: DropDownDecoratorProps(
//                       dropdownSearchDecoration: InputDecoration(
//                         contentPadding:
//                             const EdgeInsets.symmetric(horizontal: 20),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide:
//                               BorderSide(color: globalColors.textBlackBold),
//                         ),
//                         hintText: "Pilih Provinsi",
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide:
//                               const BorderSide(color: Color(0xFFDC822A)),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Kabupaten / Kota",
//                     textAlign: TextAlign.start,
//                     style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(height: 5),
//                   DropdownSearch<String>(
//                     popupProps: PopupProps.menu(
//                       showSelectedItems: true,
//                       // disabledItemFn: (String s) => s.startsWith('I'),
//                       showSearchBox: true,
//                       searchFieldProps: TextFieldProps(
//                           decoration: InputDecoration(
//                         contentPadding:
//                             const EdgeInsets.symmetric(horizontal: 20),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide:
//                               BorderSide(color: globalColors.textBlackBold),
//                         ),
//                         suffixIcon: Icon(
//                           Ionicons.search_sharp,
//                           color: globalColors.bgOrange,
//                         ),
//                         hintText: "Pencarian",
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide:
//                               const BorderSide(color: Color(0xFFDC822A)),
//                         ),
//                       )),
//                       searchDelay: const Duration(microseconds: 5000),
//                     ),
//                     items: (isFetchProvince)
//                         ? ["Sedang Menunggu Data ..."]
//                         : cities.map((map) => map['name'].toString()).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         // Ambil ID dari item yang dipilih berdasarkan nilai value
//                         final selectedCityId = cities.firstWhere((map) =>
//                             map['name'].toString() == value)['id_city'];
//                         print("value province ID: $selectedCityId");
//                         selectedCity = value;
//                         print("value prov: $selectedCity");
//                       });
//                     },
//                     selectedItem: selectedCity,
//                     dropdownDecoratorProps: DropDownDecoratorProps(
//                       dropdownSearchDecoration: InputDecoration(
//                         contentPadding:
//                             const EdgeInsets.symmetric(horizontal: 20),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide:
//                               BorderSide(color: globalColors.textBlackBold),
//                         ),
//                         hintText: "Pilih Kabupaten / Kota",
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide:
//                               const BorderSide(color: Color(0xFFDC822A)),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//             ],
//           ),
//         ));
//   }
// }

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ionicons/ionicons.dart';
import 'dart:convert';

import '../../api/api_service.dart';
import '../../component/app_bar/app_bar_tittle.dart';
import '../../component/app_bar/app_bar_tittle_menu_bar.dart';
import '../../component/pet/pet_list.dart';
import '../../helper/global_colors.dart';
import '../../helper/session.dart';
import '../../model/data.dart';
import '../condition/condition_list.dart';
import '../hotel_pet/hotel_list.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class HotelSearchTes extends StatefulWidget {
  const HotelSearchTes({Key? key}) : super(key: key);

  @override
  State<HotelSearchTes> createState() => _HotelSearchTesState();
}

class _HotelSearchTesState extends State<HotelSearchTes> {
  final TextEditingController _searchController = TextEditingController();
  GlobalColors globalColors = GlobalColors();
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

  bool _isContainerVisible = false;

  void _toggleContainerVisibility() {
    setState(() {
      _isContainerVisible = !_isContainerVisible;
    });
  }

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          leading: Icon(Ionicons.reorder_four, color: globalColors.iconOrange),
          backgroundColor: Colors.white,
          flexibleSpace: const SafeArea(
            child: AppBarTitleMenuBar(
              title: "Kondisi",
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
          child: Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
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
                            selectedItem: selectedProvince,
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
                      const SizedBox(height: 10),
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
                            selectedItem: selectedCity,
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
                      const SizedBox(height: 10),
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
                            selectedItem: selectedDistrict,
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
                      const SizedBox(height: 10),
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
                            selectedItem: selectedSubDistrict,
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
                      const SizedBox(height: 10),
                      Container(
                        height: 400,
                        // Your existing content here
                      ),
                      GestureDetector(
                        onTap: _toggleContainerVisibility,
                        child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          color: Colors.blue,
                          child: const Text('Tampilkan Peraturan'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (_isContainerVisible)
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 100),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        const Text(
                          'Peraturan ditampilkan!',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const Text(
                          'Peraturan ditampilkan!',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const Text(
                          'Peraturan ditampilkan!',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        Expanded(child: Container()),
                        ElevatedButton(
                          onPressed: _toggleContainerVisibility,
                          child: const Text(
                            'Tutup Peraturan',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ));
  }
}

// https://chat.openai.com/c/f36b7dc9-e153-40cf-9769-f0b8c86f6dfc ==> filter search
// https://chat.openai.com/c/e1c99d0e-9a55-44c2-a79b-03084ded09ae ==> filter search
// https://chat.openai.com/c/e8c8eb65-4313-42bf-b25a-2f24343ede29 ==> dashboard
// https://chat.openai.com/c/0fcc972d-0dbf-4f29-8500-466ce95f06c2 ==> show modal
