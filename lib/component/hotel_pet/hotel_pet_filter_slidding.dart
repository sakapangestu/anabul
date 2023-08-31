import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../../../helper/global_colors.dart';
import '../../api/api_service.dart';
import '../button/rectangle/rectangle_orange.dart';

class HotelPetFilterSlidding extends StatefulWidget {
  final PanelController? pc;
  final void Function(String? city) onFilterApplied;

  const HotelPetFilterSlidding(
      {Key? key, this.pc, required this.onFilterApplied})
      : super(key: key);

  @override
  _HotelPetFilterSlidding createState() => _HotelPetFilterSlidding();
}

class _HotelPetFilterSlidding extends State<HotelPetFilterSlidding> {
  GlobalColors globalColors = GlobalColors();
  List<Map<String, dynamic>> provinces = [];
  List<Map<String, dynamic>> cities = [];
  String? selectedProvince;
  String? tempProvince;
  String? selectedCity;
  String? tempCity;
  bool isFetchProvince = true;
  bool isFetchCities = true;

  @override
  void initState() {
    super.initState();
    fetchDropdown();
  }

  Future<void> fetchDropdown() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      List<Map<String, dynamic>> provinceData = await Address.getProvince();
      List<Map<String, dynamic>> cityData = [];

      setState(() {
        provinces = provinceData;
        isFetchProvince = false;
        isFetchCities = false;
      });
    } catch (e) {
      print('Error fetching provinces: $e');
      setState(() {
        isFetchProvince = false;
        isFetchCities = false;
      });
    }
  }

  Future<void> fetchCities(String provinceId) async {
    try {
      List<Map<String, dynamic>> cityData =
          await Address.getCity(int.parse(provinceId));

      List<Map<String, dynamic>> filteredCities = cityData
          .where((city) => city['province_id'] == int.parse(provinceId))
          .toList();

      setState(() {
        cities = filteredCities;
        isFetchCities = false;
      });
    } catch (e) {
      print('Error fetching cities: $e');
      setState(() {
        isFetchCities = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: globalColors.textOrange, width: 0.5),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 24),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.pc?.close();
                            });
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Filter Pet Hotel",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Provinsi",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
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
                      items: (isFetchProvince)
                          ? ["Sedang Menunggu Data ..."]
                          : provinces
                              .map((map) => map['name'].toString())
                              .toList(),
                      onChanged: (value) {
                        final selectedProvinceId = provinces.firstWhere((map) =>
                            map['name'].toString() == value)['id_province'];
                        print("value province ID: $selectedProvinceId");
                        setState(() {
                          selectedProvince = value;
                          fetchCities(selectedProvinceId.toString());
                          tempProvince = selectedProvince!;
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
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          hintText: "Pilih Provinsi",
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
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Kota / Kabupaten",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
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
                      items: (isFetchCities)
                          ? ["Sedang Menunggu Data ..."]
                          : cities
                              .map((map) => map['name'].toString())
                              .toList(),
                      onChanged: (value) {
                        final selectedCityId = cities.firstWhere((map) =>
                            map['name'].toString() == value)['id_city'];
                        print("value city ID: $selectedCityId");
                        setState(() {
                          selectedCity = value;
                          // fetchDistricts(selectedCityId.toString());
                          tempCity = selectedCity!;
                          print("value city:$selectedCity");
                        });
                      },
                      selectedItem: selectedCity,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          hintText: "Pilih Kab / Kota",
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
              ],
            ),
            Container(
              height: 9.h,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: globalColors.borderLine, width: 0.5))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      final tempCityFilter = tempCity;
                      print("tempCity coy: $tempCityFilter");
                      widget.onFilterApplied(
                          tempCityFilter); // Mengirim nilai city yang dipilih ke HotelSearch
                      widget.pc?.close();
                    });
                  },
                  child: RectangleOrange(title: "Filter"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
