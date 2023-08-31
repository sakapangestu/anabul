import 'dart:io';

// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/component/button/rectangle/rectangle_orange.dart';
// import 'package:anabulhotel/component/pet/pet_panel/pet_panel_picture.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../api/api_service.dart';
import '../../component/app_bar/app_bar_tittle.dart';
import '../../component/button/rectangle/rectangle_orange.dart';
import '../../component/pet/pet_panel/pet_panel_picture.dart';
import '../../component/pet/pet_panel/pet_panel_success_create.dart';
import '../../component/user/user_panel/user_panel_logout.dart';
import '../../helper/global_colors.dart';
import '../../model/data.dart';
import '../dashboard/dashboard_pageview.dart';

class PetCreate extends StatefulWidget {
  const PetCreate({Key? key}) : super(key: key);

  @override
  State<PetCreate> createState() => _PetCreate();
}

class _PetCreate extends State<PetCreate> {
  GlobalColors globalColors = GlobalColors();
  String defaultImagePet = BaseImage.getImagePet();
  PanelController pc = PanelController();
  PickedFile? _image;
  final ImagePicker _picker = ImagePicker();
  bool _switchPanelCondition = false;

  final TextEditingController _namePetController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _favFoodController = TextEditingController();
  String? _selectedClass;
  String? _selectedCategory;
  String? _selectedSpecies;
  DateTime? _selectedDate;
  late String speciesData;
  late String genderData;
  String? temporarySelectedClass;
  String? temporarySelectedCategory;
  String? temporarySelectedSpecies;
  String? _selectedGender;
  String? tempBirthSelected;
  String? temporarySelectedGender;

  List<Classes> _classList = [];
  List<Category> _categoryList = [];
  List<Species> _speciesList = [];

  String petNameError = "";
  String petClassError = "";
  String petCategoryError = "";
  String petSpeciesError = "";
  String petGenderError = "";
  String petBirthError = "";
  String petFavFoodError = "";
  bool _validateInputs() {
    bool isValid = true;
    RegExp regex = RegExp(r'^[A-Za-z\s]+$');
    // validasi nama hewan
    if (_namePetController.text.trim().isEmpty) {
      setState(() {
        petNameError = "Nama hewan diisi terlebih dahulu";
      });
      isValid = false;
    } else if (!regex.hasMatch(_namePetController.text.trim())) {
      setState(() {
        petNameError = "Simbol pada nama tidak valid";
      });
      isValid = false;
    } else {
      setState(() {
        petNameError = "";
      });
    }
    //validasi class
    if (temporarySelectedClass == null) {
      setState(() {
        petClassError = "Pilih kelas hewan terlebih dahulu";
      });
      isValid = false;
    } else {
      setState(() {
        petClassError = "";
      });
    }
    //validasi category
    if (temporarySelectedCategory == null) {
      setState(() {
        petCategoryError = "Pilih kategori hewan terlebih dahulu";
      });
      isValid = false;
    } else {
      setState(() {
        petCategoryError = "";
      });
    }
    //validasi species
    if (temporarySelectedSpecies == null) {
      setState(() {
        petSpeciesError = "Pilih jenis hewan terlebih dahulu";
      });
      isValid = false;
    } else {
      setState(() {
        petSpeciesError = "";
      });
    }
    //validasi gender
    if (temporarySelectedGender == null) {
      setState(() {
        petGenderError = "Pilih jenis hewan terlebih dahulu";
      });
      isValid = false;
    } else {
      setState(() {
        petGenderError = "";
      });
    }
    //validasi birth
    if (_birthController.text.trim().isEmpty) {
      setState(() {
        petBirthError = "Pilih tanggal lahir hewan anda terlebih dahulu";
      });
      isValid = false;
    } else {
      setState(() {
        petBirthError = "";
      });
    }
    //validasi fav food
    if (_favFoodController.text.trim().isEmpty) {
      setState(() {
        petFavFoodError = "Makanan favorit hewan diisi terlebih dahulu";
      });
      isValid = false;
    } else if (!regex.hasMatch(_favFoodController.text.trim())) {
      setState(() {
        petFavFoodError = "Simbol yang anda masukkan tidak valid";
      });
      isValid = false;
    } else {
      setState(() {
        petFavFoodError = "";
      });
    }
    return isValid;
  }

  @override
  void initState() {
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        tempBirthSelected = DateFormat('yyyy-MM-dd').format(_selectedDate!);
        _birthController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!);
      });
    } else {
      // Jika tanggal tidak dipilih, set tanggal default ke hari ini
      setState(() {
        _selectedDate = DateTime.now();
        tempBirthSelected = DateFormat('yyyy-MM-dd').format(_selectedDate!);
        _birthController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(defaultImagePet);
    return SlidingUpPanel(
      panelBuilder: (ScrollController sc) {
        if (_switchPanelCondition == true) {
          // return Text(_switchPanelCondition.toString());
          // if(form == kosong){
          //   return alert nek isih kosong;
          // }
          return PetPanelSuccessCreate(pc: pc);
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
            icon: const Icon(Ionicons.arrow_back),
            onPressed: () {
              Navigator.pop(context, '/pet');
            },
          ),
          backgroundColor: const Color(0xffDC822A),
          flexibleSpace: const SafeArea(
            child: AppBarTitle(
              title: "Tambah Hewan",
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
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // color: Colors.red,
                              image: DecorationImage(
                                image: _image != null
                                    ? Image.file(
                                        File(_image!.path),
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ).image
                                    : Image.network(
                                            "${defaultImagePet}default_pet.png")
                                        .image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _switchPanelCondition = false;
                                          });
                                          pc.open();
                                        },
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8)),
                                        splashColor:
                                            globalColors.bgOrangeDisabled,
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          padding:
                                              const EdgeInsets.only(bottom: 4),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: globalColors.bgOrange,
                                                  width: 1),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(100))),
                                          child: Icon(
                                            Ionicons.camera,
                                            size: 18,
                                            color: globalColors.bgOrange,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Pasang Foto Hewan Anda!",
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(height: 8),
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
                    const SizedBox(height: 2),
                    //error field email
                    Text(
                      petNameError,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
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
                    const SizedBox(height: 2),
                    //error field email
                    Text(
                      petClassError,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
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
                    const SizedBox(height: 2),
                    //error field email
                    Text(
                      petCategoryError,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
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
                      value: _selectedSpecies,
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
                    const SizedBox(height: 2),
                    //error field email
                    Text(
                      petSpeciesError,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
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
                        hintText: "Jenis Kelamin", // Ikon default
                      ),
                      value: _selectedGender,
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
                    const SizedBox(height: 2),
                    //error field email
                    Text(
                      petGenderError,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // date birth
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Tanggal Lahir",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextField(
                          controller: _birthController,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Colors.orange),
                            ),
                            suffixIcon: Icon(
                              Icons.calendar_month_rounded,
                              color: globalColors.textBlackSmall,
                            ),
                            hintText: "DD / MM / YYYY",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    //error field email
                    Text(
                      petBirthError,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
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
                    const SizedBox(height: 2),
                    //error field email
                    Text(
                      petFavFoodError,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
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
              // onTap: (){
              //   pc.open();
              // },
              onTap: () async {
                if (_validateInputs()) {
                  try {
                    final namePet = _namePetController.text.trim();
                    File? selectedImage =
                        _image != null ? File(_image!.path) : null;
                    final speciesId = temporarySelectedSpecies!;
                    final genderPet = temporarySelectedGender!;
                    final birthPet = tempBirthSelected.toString();
                    final favFood = _favFoodController.text.trim();

                    if (_validateInputs()) {
                      var result = await ApiService.createPet(
                          namePet,
                          speciesId,
                          genderPet,
                          favFood,
                          birthPet,
                          selectedImage);
                      print(result);
                      setState(() {
                        _switchPanelCondition = true;
                        pc.open();
                      });
                    }
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Center(child: Text('Data berhasil diubah'))),
                    // );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$e')),
                    );
                  }
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
