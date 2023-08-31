import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../api/api_service.dart';
import '../../../component/app_bar/app_bar_tittle.dart';
import '../../../component/button/rectangle/rectangle_orange_disabled.dart';
import '../../../helper/global_colors.dart';
import '../../../model/data.dart';
import '../pet_update.dart';


class DetailPet extends StatelessWidget {
  const DetailPet({Key? key, required this.pets, required this.defaultImage}) : super(key: key);
  final Pets pets;
  final String defaultImage;

  @override
  Widget build(BuildContext context) {
    // print(pets.image);
    // String defaultImagePet = BaseImage.getImagePet();
    GlobalColors globalColors = GlobalColors();
    return Scaffold(
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
            title: "Detail Hewan",
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 24, left: 24, top: 15, bottom: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 1, color: globalColors.borderLine))
                ),
                child: Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(width: 1, color: globalColors.borderLine),
                              color: globalColors.bgOrangeDisabled,
                              image: DecorationImage(
                                  image: (pets.image != defaultImage) ? NetworkImage(pets.image) : NetworkImage("${defaultImage}default_pet.png"),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pets.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                pets.age,
                                style: TextStyle(
                                  color: globalColors.textGray,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        "Data Hewan",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Kelas Hewan",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            pets.class_name,
                            textAlign: TextAlign.right,
                            // widget.data["statusStaffs"]["name"],
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Kategori Hewan",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            pets.category_name,
                            textAlign: TextAlign.right,
                            // widget.data["statusStaffs"]["name"],
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Jenis Hewan",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            pets.species_name,
                            textAlign: TextAlign.right,
                            // widget.data["statusStaffs"]["name"],
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Tanggal Lahir",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        Expanded(
                          child: Text(
                            pets.birth_date,
                            textAlign: TextAlign.right,
                            // widget.data["statusStaffs"]["name"],
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Jenis Kelamin",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            pets.gender,
                            textAlign: TextAlign.right,
                            // widget.data["statusStaffs"]["name"],
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Makanan Kesukaan",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            pets.fav_food,
                            textAlign: TextAlign.right,
                            // widget.data["statusStaffs"]["name"],
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600
                            ),
                          ),
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
                top: BorderSide(color: globalColors.borderLine, width: 0.5)
            )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) {
                    return PetUpdate(pets: pets, defImageUpdate: defaultImage,);
                  }),
                ),
              );
              // pc.open();
            },
            child: const RectangleOrangeDisabled(title: "Ubah Data Hewan",),
          ),
        ),
      ),
    );
  }
}
