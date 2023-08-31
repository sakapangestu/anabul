// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:anabul/component/app_bar/app_bar_tittle.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../component/button/rounded/rounded_orange.dart';
import '../../helper/global_colors.dart';

class DetailFormTes extends StatefulWidget {
  DetailFormTes({Key? key, required this.qtyPet}) : super(key: key);
  final int qtyPet;

  @override
  State<DetailFormTes> createState() => _DetailFormTes();
}

class _DetailFormTes extends State<DetailFormTes> {
  GlobalColors globalColors = GlobalColors();
  List<String> qtyPetTotal = [];
  List<String> sizeRoom = ["S", "M", "L", "XL", "2XL", "3XL"];
  List<String> typeRoom = ["AC", "NON AC"];
  List<String> treat = ["Grooming", "Schooling"];

  final _species = TextEditingController();
  final _pet = TextEditingController();
  final _weight = TextEditingController();
  final _vaccine = TextEditingController();
  final _allergy = TextEditingController();
  final _diseasehistory = TextEditingController();
  final _room = TextEditingController();
  final _typeroom = TextEditingController();
  final _treatment = TextEditingController();

  @override
  void initState() {
    super.initState();
    // membuat list qtyPetTotal
    for (int i = 0; i < widget.qtyPet; i++) {
      qtyPetTotal.add((i + 1).toString());
      // print("total : ${qtyPetTotal}");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("tess: ${widget.qtyPet}");
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xffDC822A),
        flexibleSpace: const SafeArea(
          child: AppBarTitle(
            title: "Detail Reservasi",
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: List.generate(qtyPetTotal.length, (index) {
            // print("totalll : ${qtyPetTotal.length}");
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
              // color: Colors.red,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 0.5, color: globalColors.borderLine))),
              child: Column(
                children: [
                  Text("Reservasi Hewan ${qtyPetTotal[index]}"),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "Jenis Hewan",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: _species,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Color(0xFFDC822A)),
                              ),
                              hintText: "Pilih Jenis Hewan",
                              fillColor: MaterialStateColor.resolveWith(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.focused)) {
                                  return const Color(0xFFFFFFFF);
                                } else {
                                  return const Color(0xFFD9D9D9)
                                      .withOpacity(0.2);
                                }
                              }),
                              filled: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "Hewan",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: _pet,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Color(0xFFDC822A)),
                              ),
                              hintText: "Pilih Hewan Anda",
                              fillColor: MaterialStateColor.resolveWith(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.focused)) {
                                  return const Color(0xFFFFFFFF);
                                } else {
                                  return const Color(0xFFD9D9D9)
                                      .withOpacity(0.2);
                                }
                              }),
                              filled: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "Berat",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(top: 5),
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: TextField(
                                  controller: _weight,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0xFFDC822A)),
                                    ),
                                    hintText: "1.0",
                                    fillColor: MaterialStateColor.resolveWith(
                                        (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.focused)) {
                                        return const Color(0xFFFFFFFF);
                                      } else {
                                        return const Color(0xFFD9D9D9)
                                            .withOpacity(0.2);
                                      }
                                    }),
                                    filled: true,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 40,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.5, color: globalColors.borderLine),
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xFFD9D9D9).withOpacity(0.6),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              margin: EdgeInsets.only(top: 5, left: 2),
                              alignment: Alignment.center,
                              child: Text(
                                "KG",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "Vaksinasi Hewan",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: _vaccine,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Color(0xFFDC822A)),
                              ),
                              hintText: "Sudah",
                              fillColor: MaterialStateColor.resolveWith(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.focused)) {
                                  return const Color(0xFFFFFFFF);
                                } else {
                                  return const Color(0xFFD9D9D9)
                                      .withOpacity(0.2);
                                }
                              }),
                              filled: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "Alergi Makanan",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: _allergy,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Color(0xFFDC822A)),
                              ),
                              hintText: "Tidak",
                              fillColor: MaterialStateColor.resolveWith(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.focused)) {
                                  return const Color(0xFFFFFFFF);
                                } else {
                                  return const Color(0xFFD9D9D9)
                                      .withOpacity(0.2);
                                }
                              }),
                              filled: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "Riwayat Penyakit Lain",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: TextField(
                            controller: _diseasehistory,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Color(0xFFDC822A)),
                              ),
                              hintText: "Riwayat Penyakit",
                              fillColor: MaterialStateColor.resolveWith(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.focused)) {
                                  return const Color(0xFFFFFFFF);
                                } else {
                                  return const Color(0xFFD9D9D9)
                                      .withOpacity(0.2);
                                }
                              }),
                              filled: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "Pilih Ukuran Kandang",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            children: List.generate(sizeRoom.length, (index) {
                              return GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 40,
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5,
                                          color: globalColors.borderLine),
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xFFD9D9D9).withOpacity(0.3),
                                    ),
                                    // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                    // margin: EdgeInsets.only(top: 5),
                                    alignment: Alignment.center,
                                    child: Text(
                                      sizeRoom[index],
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ));
                            }),
                          ),
                          // child:
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "Pilih Tipe Kandang",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            children: List.generate(typeRoom.length, (index) {
                              return GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    // width: 80,
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5,
                                          color: globalColors.borderLine),
                                      borderRadius: BorderRadius.circular(100),
                                      color: Color(0xFFD9D9D9).withOpacity(0.3),
                                    ),
                                    // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                    // margin: EdgeInsets.only(top: 5),
                                    alignment: Alignment.center,
                                    child: Text(
                                      typeRoom[index],
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ));
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "Layanan Tambahan",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            children: List.generate(treat.length, (index) {
                              return GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    // width: 80,
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5,
                                          color: globalColors.borderLine),
                                      borderRadius: BorderRadius.circular(100),
                                      color: Color(0xFFD9D9D9).withOpacity(0.3),
                                    ),
                                    // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                    // margin: EdgeInsets.only(top: 5),
                                    alignment: Alignment.center,
                                    child: Text(
                                      treat[index],
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ));
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        )),
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
              // pc.open();
            },
            child: const RoundedOrange(
              title: "Pesan",
            ),
          ),
        ),
      ),
    );
  }
}
