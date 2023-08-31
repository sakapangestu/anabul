import 'dart:io';

// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../api/api_service.dart';
import '../../component/app_bar/app_bar_tittle.dart';
import '../../component/button/rectangle/rectangle_orange.dart';
import '../../component/pet/pet_panel/pet_panel_picture.dart';
import '../../component/pet/pet_panel/pet_panel_success_update.dart';
import '../../helper/global_colors.dart';
import '../../model/data.dart';

class PetUpdate extends StatefulWidget {
  const PetUpdate({Key? key, required this.pets, required this.defImageUpdate})
      : super(key: key);
  final Pets pets;
  final String defImageUpdate;

  @override
  State<PetUpdate> createState() => _PetUpdate();
}

class _PetUpdate extends State<PetUpdate> {
  GlobalColors globalColors = GlobalColors();
  PanelController pc = PanelController();
  String? defaultImagePet;
  PickedFile? _image;
  final ImagePicker _picker = ImagePicker();
  bool _switchPanelCondition = false;

  TextEditingController _namePetController = TextEditingController();
  // TextEditingController _birthController = TextEditingController();
  TextEditingController _favFoodController = TextEditingController();
  String? _selectedClass;
  String? _selectedCategory;
  String? _selectedSpecies;
  late String speciesData;
  late String genderData;
  String? temporarySelectedClass;
  String? imageData;
  String? birthData;
  String? temporarySelectedCategory;
  String? temporarySelectedSpecies;
  String? tempBirthSelected;
  String? _selectedGender;
  String? temporarySelectedGender;

  List<Classes> _classList = [];
  List<Category> _categoryList = [];
  List<Species> _speciesList = [];

  @override
  void initState() {
    defaultImagePet = widget.defImageUpdate;
    // print("foto default: $defaultImagePet");
    imageData = widget.pets.image;
    // print("foto : $imageData");
    _namePetController = TextEditingController(text: widget.pets.name);
    _onClassSelected(widget.pets.class_id);
    _onCategorySelected(widget.pets.category_id);
    speciesData = widget.pets.species_id;
    birthData = widget.pets.birth_date;
    tempBirthSelected = birthData;
    // _birthController = TextEditingController(text: widget.pets.birth_date);
    genderData = widget.pets.gender;
    _favFoodController = TextEditingController(text: widget.pets.fav_food);

    super.initState();
    Pet.getClass().then((classes) {
      setState(() {
        _classList = classes;
      });
    });
  }

  void _onClassSelected(String? idClass) async {
    setState(() {
      _selectedClass = idClass;
      temporarySelectedClass = idClass!;
      _selectedCategory = null;
      _categoryList = [];
      _selectedSpecies = null;
      _speciesList = [];
    });
    if (_selectedClass != null) {
      var categories = await Pet.getCategory(_selectedClass!);

      setState(() {
        _categoryList = categories;
      });
    }
  }

  void _onCategorySelected(String? idCategory) async {
    setState(() {
      _selectedCategory = idCategory;
      temporarySelectedCategory = idCategory!;
      _selectedSpecies = null;
      _speciesList = [];
    });

    if (_selectedCategory != null) {
      var species = await Pet.getSpecies(_selectedCategory!);

      setState(() {
        _speciesList = species;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to get species'),
        ),
      );
    }
  }

  void _updateImage(PickedFile? image) {
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.pets.image);
    // String defaultImage = BaseImage.getImageUser();
    // print(defaultImagePet);
    bool isImageUploaded = _image != null;
    return SlidingUpPanel(
      panelBuilder: (ScrollController sc) {
        if (_switchPanelCondition == true) {
          // return Text(_switchPanelCondition.toString());
          // if(form == kosong){
          //   return alert nek isih kosong;
          // }
          return PetPanelSuccessUpdate(pc: pc);
        } else {
          return PetPanelPicture(
            pc: pc,
            updateImage: _updateImage,
            picker: _picker,
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
              Navigator.pop(context, '/pet');
            },
          ),
          backgroundColor: const Color(0xffDC822A),
          flexibleSpace: const SafeArea(
            child: AppBarTitle(
              title: "Ubah Data Hewan",
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
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
                                      if (imageData != defaultImagePet) {
                                        return NetworkImage(imageData!);
                                      } else {
                                        return NetworkImage(
                                            "${defaultImagePet}default_pet.png");
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
                                      mainAxisAlignment: MainAxisAlignment.end,
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
                      const Text(
                        "Pasang Foto Hewan Anda!",
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
                    const SizedBox(height: 5),
                    TextField(
                      controller: _namePetController,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
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
                const SizedBox(height: 16),
                //class
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Kelas Hewan",
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
                      ),
                      value: _selectedClass,
                      hint: const Text('Kelas Hewan'),
                      items: _classList.map((classes) {
                        return DropdownMenuItem<String>(
                          value: classes.id_class,
                          child: Text(classes.name),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        _onClassSelected(value);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                //category
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Kategori Hewan",
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
                      ),
                      value: _selectedCategory,
                      hint: const Text('Kategori Hewan'),
                      items: _categoryList.map((category) {
                        return DropdownMenuItem<String>(
                          value: category.id_category,
                          child: Text(category.name),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        _onCategorySelected(value);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
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
                      ),
                      value: speciesData.isNotEmpty
                          ? speciesData
                          : _selectedSpecies,
                      hint: const Text('Jenis Hewan'),
                      items: _speciesList.map((species) {
                        return DropdownMenuItem<String>(
                          value: species.id_species,
                          child: Text(species.name),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedSpecies = value;
                          temporarySelectedSpecies = value!;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
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
                      value:
                          genderData.isNotEmpty ? genderData : _selectedGender,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedGender = value;
                          temporarySelectedGender = value!;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: "Jantan",
                          child: Text("Jantan"),
                        ),
                        DropdownMenuItem(
                          value: "Betina",
                          child: Text("Betina"),
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
                            width: 290,
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
                                    tempBirthSelected = DateFormat('yyyy-MM-dd')
                                        .format(selectedDate);
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
                      "Makanan Kesukaan",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 5),
                    //email
                    TextField(
                      controller: _favFoodController,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
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
                  final petId = widget.pets.id_pet;
                  final namePet = _namePetController.text;
                  final speciesId = temporarySelectedSpecies ?? speciesData;
                  final genderPet = temporarySelectedGender ?? genderData;
                  final favFood = _favFoodController.text;
                  final birthPet = tempBirthSelected!;
                  // print("pet_id: $petId");
                  // print("name_pet: $namePet");
                  // print("species_id: $speciesId");
                  // print("gender_pet: $genderPet");
                  // print("fav_food: $favFood");
                  // print("birth: $birthPet");
                  File? selectedImage =
                      _image != null ? File(_image!.path) : null;

                  await ApiService.updatePet(petId, namePet, speciesId,
                      genderPet, favFood, birthPet, selectedImage);
                  // if (result != null) {
                  //   SessionManager.saveToken(result);
                  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashboardPageView()));
                  // }

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => DashboardPageView()),
                  // );
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
