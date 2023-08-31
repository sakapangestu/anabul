import 'dart:convert';
// import 'package:anabulhotel/screen/tes/tes_card.dart';
import 'package:anabul/screen/tes/tes_card.dart';
import 'package:http/http.dart' as http;

// import 'package:anabulhotel/screen/tes/Maps.dart';
// import 'package:anabulhotel/screen/tes/tested.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../api/api_service.dart';
import '../../component/app_bar/app_bar_tittle_menu_bar.dart';
import '../../component/button/rectangle/rectangle_orange_disabled.dart';
import '../../helper/global_colors.dart';
import '../../helper/session.dart';

class Tes extends StatefulWidget {
  Tes({Key? key}) : super(key: key);

  @override
  State<Tes> createState() => _TesState();
}

class _TesState extends State<Tes> {
  List<Map<String, dynamic>> petConditions = [];
  GlobalColors globalColors = GlobalColors();

  @override
  void initState() {
    super.initState();
    fetchPetConditions();
  }

  Future<void> fetchPetConditions() async {
    try {
      final data = await SessionManager.getData();
      final token = data!['data']['token'];
      final response = await http.get(
        Uri.parse('${BaseApi.baseUrlApi}reservationDetail/all'),
        headers: {'Authorization': '$token'},
      );
      var datas = jsonDecode(response.body);
      print("datas: $datas");
      var pet = datas['data']['data'];
      setState(() {
        petConditions = List<Map<String, dynamic>>.from(pet);
      });
    } catch (error) {
      print('Error fetching pet conditions: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    // String tempName = data['data']['name'];
    // print("ini isi apa: $defaultImage");
    // setState(() {
    //   userImage = userImage + data['image'];
    // });
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        leading: Icon(Icons.add_alarm_rounded, color: globalColors.iconOrange),
        backgroundColor: Colors.white,
        flexibleSpace: const SafeArea(
          child: AppBarTitleMenuBar(
            title: "Profil",
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 800,
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: TesSpecies.getPetCondition(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                // final petConditions = snapshot.data!;
                return ListView.builder(
                    itemBuilder: ((context, index) {
                      var data =
                          (snapshot.data as List<Map<String, dynamic>>)[index];
                      DateTime birthDate =
                          DateTime.parse(data['pet']['birth_date'].toString());
                      int ageInYears = DateTime.now().year - birthDate.year;
                      int ageInMonths = DateTime.now().month - birthDate.month;

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
                          ageText = '${ageInMonths} bulan';
                          ageText = 'Umur $ageText';
                          // print(ageText);
                        }
                      } else {
                        // Umur lebih dari 1 tahun
                        ageText = '${ageInYears} tahun';
                        ageText = 'Umur $ageText';
                        // print(ageText);
                      }
                      print("age: $ageText");
                      var pet = data['pet'];
                      print("tes data: ${pet}");
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            ConditionListTes(
                              pets: pet,
                              age: ageText,
                            ),
                            // ConditionList(
                            //   pets:
                            //   Pets(
                            //     id_pet: pet.id_pet,
                            //     name: pet.name,
                            //     user_id: pet.user_id,
                            //     age: pet.age,
                            //     class_name: pet.class_name,
                            //     species_name: pet.species_name,
                            //     category_name: pet.category_name,
                            //     class_id: pet.class_id,
                            //     species_id: pet.species_id,
                            //     category_id: pet.category_id,
                            //     birth_date: pet.birth_date,
                            //     gender: pet.gender,
                            //     fav_food: pet.fav_food,
                            //     // image: "https://3cf3-203-6-149-2.ngrok-free.app/pet/profile/${pet.image}",
                            //     image: "${imagePath + pet.image}",
                            //   ),
                            // ),
                            SizedBox(height: 5),
                          ],
                        ),
                      );
                    }),
                    // separatorBuilder: (context, index) {
                    //   return const Divider();
                    // },
                    itemCount:
                        (snapshot.data as List<Map<String, dynamic>>).length);
                // return Column(
                //   children: petConditions.map((petCondition) {
                //     return Text(
                //       'Reservation ID: ${petCondition['reservation_id']} - Pet Name: ${petCondition['pet']['name']}',
                //     );
                //   }).toList(),
                // );
              } else {
                return Center(child: Text('No data available'));
              }
            },
          ),
        ),
      ),
    );
  }
}
