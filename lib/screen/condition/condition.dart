// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../api/api_service.dart';
import 'package:ionicons/ionicons.dart';
import '../../component/app_bar/app_bar_tittle_menu_bar.dart';
import '../../component/condition/condition_list_pet.dart';
import '../../component/pet/pet_list.dart';
import '../../helper/global_colors.dart';
import '../../model/data.dart';
import 'condition_list.dart';

class Condition extends StatefulWidget {
  const Condition({Key? key}) : super(key: key);

  @override
  State<Condition> createState() => _Condition();
}

class _Condition extends State<Condition> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _conditionList = [];
  List<Map<String, dynamic>> _filteredconditionList = [];
  GlobalColors globalColors = GlobalColors();
  String imagePath = BaseImage.getImagePet();
  bool _isLoading =
      true; // Tambahkan variabel _isLoading untuk menunjukkan bahwa data sedang dimuat
  bool _hasError =
      false; // Tambahkan variabel _hasError untuk menunjukkan bahwa ada kesalahan dalam memuat data

  @override
  void initState() {
    super.initState();
    _fetchConditionList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchConditionList() async {
    try {
      List<Map<String, dynamic>> conditionList =
          await TesSpecies.getPetCondition();
      setState(() {
        _conditionList = conditionList;
        _filteredconditionList = conditionList;
        _isLoading =
            false; // Menghentikan indikator loading setelah berhasil mendapatkan data
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading =
            false; // Menghentikan indikator loading jika terjadi kesalahan
      });
    }
  }

  void _filterConditionList(String query) {
    List<Map<String, dynamic>> filteredList = [];

    if (query.isEmpty) {
      filteredList = List<Map<String, dynamic>>.from(_conditionList);
      print("filterList: $filteredList");
    } else {
      filteredList = _conditionList.where((condition) {
        final String petName =
            condition['pet']['name'].toString().toLowerCase();
        // final String cityName = condition['city']['name'].toString().toLowerCase();
        return petName.contains(query.toLowerCase());
        // cityName.contains(query.toLowerCase());
      }).toList();
    }

    setState(() {
      _filteredconditionList = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        // leading: Icon(Ionicons.reorder_four, color: globalColors.iconOrange),
        backgroundColor: Colors.white,
        flexibleSpace: const SafeArea(
          child: AppBarTitleMenuBar(
            title: "Kondisi",
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(right: 24, left: 24, top: 15, bottom: 15),
            decoration: BoxDecoration(
                // color: Colors.red,
                border: Border(
                    bottom: BorderSide(
                        width: 0.5, color: globalColors.borderLine))),
            // color: Colors.red,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: globalColors.bgOrangeDisabled,
                  // color: Color(0xFFD9D9D9).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 0.1, color: globalColors.bgOrange)),
              alignment: Alignment.center,
              child: TextField(
                controller: _searchController,
                onChanged: (query) => _filterConditionList(query),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: globalColors.bgOrange),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFDC822A)),
                  ),
                  hintText: "Search",
                  suffixIcon: Icon(
                    Ionicons.search_outline,
                    color: globalColors.textGray,
                  ),
                  filled: true,
                ),
              ),
            ),
          ),
          Expanded(
              child: _isLoading
                  ? const Center(
                      child:
                          CircularProgressIndicator(), // Tampilkan indikator loading jika data sedang dimuat
                    )
                  : (_filteredconditionList.isNotEmpty)
                      ? ListView.builder(
                          itemCount: _filteredconditionList.length,
                          itemBuilder: (context, index) {
                            final condition = _filteredconditionList[index];
                            print("object con : $condition");
                            final idReservationDetail =
                                condition['id_reservation_detail'];
                            final pet = condition['pet'];
                            final String image =
                                imagePath + condition['pet']['image'];
                            final DateTime birthDate = DateTime.parse(
                                condition['pet']['birth_date'].toString());
                            int ageInYears =
                                DateTime.now().year - birthDate.year;
                            int ageInMonths =
                                DateTime.now().month - birthDate.month;

                            if (DateTime.now().day < birthDate.day) {
                              ageInMonths--;
                            }

                            String ageText = '';

                            if (ageInYears < 1) {
                              if (ageInMonths < 1) {
                                // Umur kurang dari 1 bulan
                                ageText =
                                    '${birthDate.difference(DateTime.now()).inDays.abs()} hari';
                                ageText = ageText.replaceAll("-", "");
                                ageText = 'Umur $ageText';
                                // print(ageText);
                              } else {
                                // Umur kurang dari 1 tahun
                                ageText = '$ageInMonths bulan';
                                ageText = 'Umur $ageText';
                                // print(ageText);
                              }
                            } else {
                              // Umur lebih dari 1 tahun
                              ageText = '$ageInYears tahun';
                              ageText = 'Umur $ageText';
                              // print(ageText);
                            }
                            return Column(
                              children: [
                                Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 0.2,
                                                color: Colors.grey))),
                                    child: ConditionList(
                                      pets: pet,
                                      age: ageText,
                                      idCondition: idReservationDetail,
                                    )),
                                const SizedBox(height: 5),
                              ],
                            );
                          },
                        )
                      : const Center(child: Text('Tidak Ada Data'))),
        ],
      ),
    );
  }
}
