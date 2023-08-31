// import 'dart:js_interop';

// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/component/button/rectangle/rectangle_orange_disabled.dart';
// import 'package:anabulhotel/component/pet/pet_list.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
// import 'package:anabulhotel/screen/pet/pet_create.dart';
import 'package:anabul/screen/pet/pet_create.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../../api/api_service.dart';
import '../../component/app_bar/app_bar_tittle.dart';
import '../../component/app_bar/app_bar_tittle_menu_bar.dart';
import '../../component/button/rectangle/rectangle_orange_disabled.dart';
import '../../component/pet/pet_list.dart';
import '../../helper/global_colors.dart';
import '../../model/data.dart';

class PetSreen extends StatefulWidget {
  const PetSreen({Key? key}) : super(key: key);

  @override
  State<PetSreen> createState() => _PetSreen();
}

class _PetSreen extends State<PetSreen> {
  final TextEditingController _searchController = TextEditingController();
  GlobalColors globalColors = GlobalColors();
  List<Pets> _conditionList = [];
  List<Pets> _filteredPetList = [];
  String imagePath = BaseImage.getImagePet();
  bool _isLoading =
      true; // Tambahkan variabel _isLoading untuk menunjukkan bahwa data sedang dimuat
  bool _hasError =
      false; // Tambahkan variabel _hasError untuk menunjukkan bahwa ada kesalahan dalam memuat data

  @override
  void initState() {
    super.initState();
    _fetchPetList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchPetList() async {
    try {
      final List<Pets> pets = await ApiService.getDataPet();

      setState(() {
        _conditionList = pets;
        _filteredPetList = pets;
        _isLoading = false;
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
    List<Pets> filteredList = [];

    if (query.isEmpty) {
      filteredList = List<Pets>.from(_conditionList);
    } else {
      filteredList = _conditionList.where((pets) {
        final String petName = pets.name.toString().toLowerCase();
        return petName.contains(query.toLowerCase());
      }).toList();
    }

    setState(() {
      _filteredPetList = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            title: "Daftar Hewan",
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
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
                    border:
                        Border.all(width: 0.1, color: globalColors.bgOrange)),
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
                    : (_filteredPetList.isNotEmpty)
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: ListView.builder(
                              itemCount: _filteredPetList.length,
                              itemBuilder: (context, index) {
                                // print("object contex : $context");
                                final pet = _filteredPetList[index];
                                // print("object pet : $pet");
                                return PetList(
                                  pets: Pets(
                                    id_pet: pet.id_pet,
                                    name: pet.name,
                                    user_id: pet.user_id,
                                    age: pet.age,
                                    class_name: pet.class_name,
                                    species_name: pet.species_name,
                                    category_name: pet.category_name,
                                    class_id: pet.class_id,
                                    species_id: pet.species_id,
                                    category_id: pet.category_id,
                                    birth_date: pet.birth_date,
                                    gender: pet.gender,
                                    fav_food: pet.fav_food,
                                    // image: "https://3cf3-203-6-149-2.ngrok-free.app/pet/profile/${pet.image}",
                                    image: "${imagePath + pet.image}",
                                    allergy: pet.allergy,
                                    another_disease: pet.another_disease,
                                    flea_disease: pet.flea_disease,
                                    vaccination: pet.vaccination,
                                  ),
                                );
                              },
                            ),
                          )
                        : const Center(child: Text('Tidak Ada Data'))),
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PetCreate()),
              );
            },
            child: const RectangleOrangeDisabled(
              title: "Tambahkan Hewan",
            ),
          ),
        ),
      ),
    );
  }
// Wrap setMenuProfile() {
//   return Wrap(
//     children: List.generate(listPet.length, (index) => PetListAnimal(data: listPet[index])),
//   );
// }
}
