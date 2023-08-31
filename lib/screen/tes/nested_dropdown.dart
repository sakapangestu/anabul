// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../api/api_service.dart';
// import '../../component/button/rectangle/rectangle_orange.dart';
// import '../../model/data.dart';
// import '../dashboard/dashboard_pageview.dart';
//
// class TesEdit extends StatefulWidget {
//   const TesEdit({Key? key, required this.pets}) : super(key: key);
//   final Pets pets;
//
//   @override
//   State<TesEdit> createState() => _TesEdit();
// }
//
// class _TesEdit extends State<TesEdit> {
//
//   GlobalColors globalColors = GlobalColors();
//   bool isMainActive = true;
//   bool isImageOnline = false;
//   String? networkImage;
//
//   TextEditingController _namePetController = TextEditingController();
//   TextEditingController _birthController = TextEditingController();
//   TextEditingController _favFoodController = TextEditingController();
//   String? _selectedClass;
//   // late String classData;
//   String? _selectedCategory;
//   // late String categoryData;
//   String? _selectedSpecies;
//   late String speciesData;
//   late String genderData;
//   String? temporarySelectedClass;
//   String? temporarySelectedCategory;
//   String? temporarySelectedSpecies;
//   String? _selectedGender;
//   String? temporarySelectedGender;
//
//   List<Classes> _classList = [];
//   List<Category> _categoryList = [];
//   List<Species> _speciesList = [];
//
//   @override
//   void initState() {
//     networkImage = widget.pets.image;
//     _namePetController = TextEditingController(text: widget.pets.name);
//     _onClassSelected(widget.pets.class_id);
//     _onCategorySelected(widget.pets.category_id);
//     speciesData = widget.pets.species_id;
//     // _selectedSpecies = widget.pets.species_id;
//     _birthController = TextEditingController(text: widget.pets.birth_date);
//     genderData = widget.pets.gender;
//     _favFoodController = TextEditingController(text: widget.pets.fav_food);
//
//     super.initState();
//     Pet.getClass().then((classes) {
//       setState(() {
//         _classList = classes;
//       });
//     });
//   }
//
//   void _onClassSelected(String? idClass) async {
//     setState(() {
//       _selectedClass = idClass;
//       temporarySelectedClass = idClass!;
//       _selectedCategory = null;
//       _categoryList = [];
//       _selectedSpecies = null;
//       _speciesList = [];
//     });
//     if (_selectedClass != null) {
//       var categories = await Pet.getCategory(_selectedClass!);
//
//       setState(() {
//         _categoryList = categories;
//       });
//     } else {
//       print("Failed to get category");
//     }
//   }
//
//   void _onCategorySelected(String? idCategory) async {
//     setState(() {
//       _selectedCategory = idCategory;
//       temporarySelectedCategory = idCategory!;
//       _selectedSpecies = null;
//       _speciesList = [];
//     });
//
//     if (_selectedCategory != null) {
//       var species = await Pet.getSpecies(_selectedCategory!);
//
//       setState(() {
//         _speciesList = species;
//       });
//     } else {
//       print("Failed to get species");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context, '/pet');
//             // Navigator.push(
//             // context,
//             // MaterialPageRoute(builder: (context) => const DetailPet()),
//             // );
//           },
//         ),
//         backgroundColor: const Color(0xffDC822A),
//         flexibleSpace: const SafeArea(
//           child: AppBarTitle(
//             title: "Edit Hewan",
//           ),
//         ),
//       ),
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               // Container(
//               //   margin: const EdgeInsets.only(bottom: 20),
//               //   decoration: BoxDecoration(
//               //       border: Border(bottom: BorderSide(width: 1, color: globalColors.borderLine))
//               //   ),
//               //   child: Column(
//               //     mainAxisAlignment: MainAxisAlignment.center,
//               //     children: [
//               //       Row(
//               //         mainAxisAlignment: MainAxisAlignment.center,
//               //         children: [
//               //           Container(
//               //             width: 100,
//               //             height: 100,
//               //             child: Stack(
//               //               children: [
//               //                 CircleAvatar(
//               //                   radius: 80,
//               //                   backgroundImage: NetworkImage(networkImage!),
//               //                   backgroundColor: Colors.black,
//               //                 ),
//               //                 Row(
//               //                   mainAxisAlignment: MainAxisAlignment.end,
//               //                   children: [
//               //                     Column(
//               //                       mainAxisAlignment: MainAxisAlignment.end,
//               //                       children: [
//               //                         Material(
//               //                           color: Colors.transparent,
//               //                           child: InkWell(
//               //                             onTap: () {
//               //
//               //                             },
//               //                             borderRadius: const BorderRadius.all(Radius.circular(8)),
//               //                             splashColor: globalColors.bgOrangeDisabled,
//               //                             child: Container(
//               //                               width: 30,
//               //                               height: 30,
//               //                               decoration: BoxDecoration(
//               //                                   color: Colors.white,
//               //                                   border: Border.all(color: globalColors.bgOrange, width: 1),
//               //                                   borderRadius: const BorderRadius.all(Radius.circular(100))
//               //                               ),
//               //                               child: Padding(
//               //                                 padding: const EdgeInsets.all(2),
//               //                                 child: Icon(Icons.camera_enhance_rounded, size: 16, color: globalColors.bgOrange,),
//               //                                 // child: Image.asset("assets/icons/icon-edit-profile.png", scale: 3.5),
//               //                               ),
//               //                             ),
//               //                           ),
//               //                         )
//               //                       ],
//               //                     ),
//               //                   ],
//               //                 ),
//               //               ],
//               //             ),
//               //           ),
//               //         ],
//               //       ),
//               //       const SizedBox(height: 10),
//               //       const Text(
//               //         "Pasang Foto Terbaik Anda!",
//               //         style: TextStyle(
//               //             fontSize: 11,
//               //             fontWeight: FontWeight.w300
//               //         ),
//               //       ),
//               //       const SizedBox(height: 10),
//               //     ],
//               //   ),
//               // ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Nama Hewan",
//                     textAlign: TextAlign.start,
//                     style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   TextField(
//                     controller: _namePetController,
//                     decoration: InputDecoration(
//                       contentPadding: const EdgeInsets.symmetric(horizontal: 20),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide(color: globalColors.textBlackSmall),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide(color: globalColors.bgOrange),
//                       ),
//                       hintText: "Nama Hewan",
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               //class
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Kelas Hewan",
//                     textAlign: TextAlign.start,
//                     style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   DropdownButtonFormField(
//                     decoration: InputDecoration(
//                       contentPadding: const EdgeInsets.symmetric(horizontal: 20),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide(color: globalColors.textBlackBold),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: const BorderSide(color: Color(0xFFDC822A)),
//                       ),
//                     ),
//                     value: _selectedClass,
//                     hint: const Text('Kelas Hewan'),
//                     items: _classList.map((Classes) {
//                       return DropdownMenuItem<String>(
//                         value: Classes.id_class,
//                         child: Text(Classes.name),
//                       );
//                     }).toList(),
//                     onChanged: (String? value) async {
//                       _onClassSelected(value);
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               //category
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Kategori Hewan",
//                     textAlign: TextAlign.start,
//                     style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   DropdownButtonFormField(
//                     decoration: InputDecoration(
//                       contentPadding: const EdgeInsets.symmetric(horizontal: 20),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide(color: globalColors.textBlackBold),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: const BorderSide(color: Color(0xFFDC822A)),
//                       ),
//                     ),
//                     value: _selectedCategory,
//                     hint: const Text('Kategori Hewan'),
//                     items: _categoryList.map((category) {
//                       return DropdownMenuItem<String>(
//                         value: category.id_category,
//                         child: Text(category.name),
//                       );
//                     }).toList(),
//                     onChanged: (String? value) {
//                       _onCategorySelected(value);
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               //species
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Jenis Hewan",
//                     textAlign: TextAlign.start,
//                     style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   DropdownButtonFormField(
//                     decoration: InputDecoration(
//                       contentPadding: const EdgeInsets.symmetric(horizontal: 20),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide(color: globalColors.textBlackBold),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: const BorderSide(color: Color(0xFFDC822A)),
//                       ),
//                     ),
//                     value: _selectedSpecies ?? speciesData,
//                     hint: const Text('Jenis Hewan'),
//                     items: _speciesList.map((species) {
//                       return DropdownMenuItem<String>(
//                         value: species.id_species,
//                         child: Text(species.name),
//                       );
//                     }).toList(),
//                     onChanged: (String? value) {
//                       setState(() {
//                         _selectedSpecies = value;
//                         temporarySelectedSpecies = value!;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               //gender
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Jenis Kelamin",
//                     textAlign: TextAlign.start,
//                     style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   DropdownButtonFormField(
//                     decoration: InputDecoration(
//                       contentPadding: const EdgeInsets.symmetric(horizontal: 20),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide(color: globalColors.textBlackBold),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: const BorderSide(color: Color(0xFFDC822A)),
//                       ),
//                       hintText: "Jenis Kelamin",
//                     ),
//                     value: _selectedGender ?? genderData,
//                     onChanged: (String? value) {
//                       setState(() {
//                         _selectedGender = value;
//                         temporarySelectedGender = value!;
//                       });
//                     },
//                     items: const [
//                       DropdownMenuItem(
//                         value: "Laki-laki",
//                         child: Text("Laki - Laki"),
//                       ),
//                       DropdownMenuItem(
//                         value: "Perempuan",
//                         child: Text("Perempuan"),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               // //date birth
//               // Column  (
//               //   crossAxisAlignment: CrossAxisAlignment.start,
//               //   children: [
//               //     const Text(
//               //       "Tanggal Lahir",
//               //       textAlign: TextAlign.start,
//               //       style: TextStyle(
//               //           fontSize: 12,
//               //           fontWeight: FontWeight.w600
//               //       ),
//               //     ),
//               //     const SizedBox(height: 5),
//               //     //email
//               //     TextField(
//               //       controller: _birthController,
//               //       decoration: InputDecoration(
//               //         contentPadding: const EdgeInsets.symmetric(horizontal: 20),
//               //         enabledBorder: OutlineInputBorder(
//               //           borderRadius: BorderRadius.circular(8),
//               //           borderSide: BorderSide(color: globalColors.textBlackSmall),
//               //         ),
//               //         focusedBorder: OutlineInputBorder(
//               //           borderRadius: BorderRadius.circular(8),
//               //           borderSide: BorderSide(color: globalColors.bgOrange),
//               //         ),
//               //         hintText: "DD / MM / YYYY",
//               //       ),
//               //     ),
//               //   ],
//               // ),
//               // const SizedBox(height: 16),
//               // Column  (
//               //   crossAxisAlignment: CrossAxisAlignment.start,
//               //   children: [
//               //     const Text(
//               //       "Makanan Kesukaan",
//               //       textAlign: TextAlign.start,
//               //       style: TextStyle(
//               //           fontSize: 12,
//               //           fontWeight: FontWeight.w600
//               //       ),
//               //     ),
//               //     const SizedBox(height: 5),
//               //     //email
//               //     TextField(
//               //       controller: _favFoodController,
//               //       decoration: InputDecoration(
//               //         contentPadding: const EdgeInsets.symmetric(horizontal: 20),
//               //         enabledBorder: OutlineInputBorder(
//               //           borderRadius: BorderRadius.circular(8),
//               //           borderSide: BorderSide(color: globalColors.textBlackSmall),
//               //         ),
//               //         focusedBorder: OutlineInputBorder(
//               //           borderRadius: BorderRadius.circular(8),
//               //           borderSide: BorderSide(color: globalColors.bgOrange),
//               //         ),
//               //         hintText: "Makanan Kesukaan",
//               //       ),
//               //     ),
//               //   ],
//               // ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         height: 9.h,
//         decoration: BoxDecoration(
//             border: Border(
//                 top: BorderSide(color: globalColors.borderLine, width: 0.5)
//             )
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
//           child: GestureDetector(
//             onTap: () async {
//               try {
//                 final pet_id = widget.pets.id_pet;
//                 print(pet_id);
//                 final name_pet = _namePetController.text;
//                 print(name_pet);
//                 final species_id = temporarySelectedSpecies ?? speciesData;
//                 print(species_id);
//                 final user_id = widget.pets.user_id;
//                 print(user_id);
//                 // final gender = _genderController.text;
//                 final gender_pet = temporarySelectedGender! ?? genderData;
//                 // final phone = int.parse(_phoneController.text);
//                 // final email = _emailController.text;
//                 // final address = _addressController.text;
//
//                 // print("Sebelum Submit:" + temporarySelectedGender!);
//
//                 // await ApiService.updatePet(pet_id, name_pet, species_id, user_id, gender_pet);
//                 // if (result != null) {
//                 //   SessionManager.saveToken(result);
//                 //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashboardPageView()));
//                 // }
//
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Center(child: Text('Data berhasil diubah'))),
//                 );
//
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => DashboardPageView()),
//                 );
//               } catch (e) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('$e')),
//                 );
//               }
//             },
//             child: const RectangleOrange(title: "Simpan",),
//           ),
//         ),
//       ),
//     );
//   }
// }
