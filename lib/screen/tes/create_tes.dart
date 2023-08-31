// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/component/button/rectangle/rectangle_orange.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../component/app_bar/app_bar_tittle.dart';
import '../../component/button/rectangle/rectangle_orange.dart';
import '../../helper/global_colors.dart';

class CreateTes extends StatefulWidget {
  const CreateTes({Key? key}) : super(key: key);

  @override
  State<CreateTes> createState() => _CreateTes();
}

class _CreateTes extends State<CreateTes> {
  GlobalColors globalColors = GlobalColors();
  bool isMainActive = true;
  bool isImageOnline = false;
  String networkImage =
      "https://cdn1.iconfinder.com/data/icons/user-pictures/100/female1-512.png";

  TextEditingController _namePetController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _speciesController = TextEditingController();
  TextEditingController _birthController = TextEditingController();
  String? _selectedGender;
  String? temporarySelectedGender;
  TextEditingController _favFoodController = TextEditingController();

  @override
  void initState() {
    bool checkUri = Uri.tryParse("")?.hasAbsolutePath ?? false;

    if (checkUri) {
      isImageOnline = true;
      networkImage = "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, '/pet');
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const Pet()),
            // );
          },
        ),
        backgroundColor: Color(0xffDC822A),
        flexibleSpace: const SafeArea(
          child: AppBarTitle(
            title: "Tambah Hewan",
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1, color: globalColors.borderLine))),
                  child: Column(
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
                                  backgroundImage: NetworkImage(networkImage),
                                  backgroundColor: Colors.black,
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
                                            onTap: () {},
                                            borderRadius:
                                                const BorderRadius.all(
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
                                                          Radius.circular(
                                                              100))),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2),
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
                      Text(
                        "Pasang Foto Terbaik Anda!",
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Nama Hewan",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 5),
                    TextField(
                      controller: _namePetController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: globalColors.textBlackSmall),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: globalColors.bgOrange),
                        ),
                        hintText: "Nama Hewan",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                //category
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Kelas Hewan",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 5),
                    TextField(
                      controller: _categoryController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: globalColors.textBlackSmall),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: globalColors.bgOrange),
                        ),
                        hintText: "Kelas Hewan",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Kategori Hewan",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 5),
                    TextField(
                      controller: _categoryController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: globalColors.textBlackSmall),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: globalColors.bgOrange),
                        ),
                        hintText: "Kategori Hewan",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                //species
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Jenis Hewan",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 5),
                    TextField(
                      controller: _speciesController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: globalColors.textBlackSmall),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: globalColors.bgOrange),
                        ),
                        hintText: "Jenis Hewan",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                //gender
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Jenis Kelamin",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 5),
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
                      value: _selectedGender,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedGender = value;
                          temporarySelectedGender = value!;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          child: Text("Laki - Laki"),
                          value: "Laki-laki",
                        ),
                        DropdownMenuItem(
                          child: Text("Perempuan"),
                          value: "Perempuan",
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                //date birth
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Tanggal Lahir",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 5),
                    //email
                    TextField(
                      controller: _birthController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: globalColors.textBlackSmall),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: globalColors.bgOrange),
                        ),
                        hintText: "DD / MM / YYYY",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Makanan Kesukaan",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 5),
                    //email
                    TextField(
                      controller: _favFoodController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: globalColors.textBlackSmall),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: globalColors.bgOrange),
                        ),
                        hintText: "Makanan Kesukaan",
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
            onTap: () {
              // pc.open();
            },
            child: RectangleOrange(
              title: "Simpan",
            ),
          ),
        ),
      ),
    );
  }
}
