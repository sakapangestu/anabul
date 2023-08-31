// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/component/button/rectangle/rectangle_orange.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../api/api_service.dart';
// import '../../model/data.dart';
// import '../dashboard/dashboard_pageview.dart';
//
// class DropdownTes extends StatefulWidget {
//   const DropdownTes({Key? key}) : super(key: key);
//
//   @override
//   State<DropdownTes> createState() => _DropdownTes();
// }
//
// class _DropdownTes extends State<DropdownTes> {
//
//   GlobalColors globalColors = GlobalColors();
//   bool isMainActive = true;
//   bool isImageOnline = false;
//   String networkImage = "https://3796-182-2-41-173.ap.ngrok.io/pet/profile/default_pet.png";
//
//   TextEditingController _namePetController = TextEditingController();
//   String? _selectedClass;
//   String? _selectedCategory;
//   String? _selectedSpecies;
//   String? temporarySelectedClass; //menyimpan data class yang dipilih
//   String? temporarySelectedCategory; //menyimpan data category yang dipilih
//   String? temporarySelectedSpecies; //menyimpan data species yang dipilih
//   TextEditingController _birthController = TextEditingController();
//   String? _selectedGender;
//   String? temporarySelectedGender;
//   TextEditingController _favFoodController = TextEditingController();
//
//   List<Classes> _classList = [];
//   List<Category> _categoryList = [];
//   List<Species> _speciesList = [];
//
//   @override
//   void initState() {
//     bool checkUri = Uri.tryParse("")?.hasAbsolutePath ?? false;
//
//     if(checkUri) {
//       isImageOnline = true;
//       networkImage = "";
//     }
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
//       _selectedCategory = null;
//       _categoryList = [];
//       _selectedSpecies = null;
//       _speciesList = [];
//     });
//
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
//           },
//         ),
//         backgroundColor: const Color(0xffDC822A),
//         flexibleSpace: const SafeArea(
//           child: AppBarTitle(
//             title: "Tambah Hewan",
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
//               //                   backgroundImage: NetworkImage(networkImage),
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
//                     onChanged: (String? value) {
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
//                     value: _selectedSpecies,
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
//                     value: _selectedGender,
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
//               //date birth
//               Column  (
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Tanggal Lahir",
//                     textAlign: TextAlign.start,
//                     style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   //email
//                   TextField(
//                     controller: _birthController,
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
//                       hintText: "DD / MM / YYYY",
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Column  (
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Makanan Kesukaan",
//                     textAlign: TextAlign.start,
//                     style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   //email
//                   TextField(
//                     controller: _favFoodController,
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
//                       hintText: "Makanan Kesukaan",
//                     ),
//                   ),
//                 ],
//               ),
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
//                 final id_pet = 0;
//                 final name_pet = _namePetController.text.trim();
//                 // final class_name = temporarySelectedClass!.trim();
//                 // final category_name = temporarySelectedCategory!.trim();
//                 // final species_name = temporarySelectedSpecies!.trim();
//                 // final gender_pet = temporarySelectedGender!.trim();
//                 // final birth_pet = null;
//                 // final fav_food = _favFoodController.text.trim();
//
//                 print(id_pet);
//                 print(name_pet);
//                 // print(class_name);
//                 // print(category_name);
//                 // print(species_name);
//                 // print(gender_pet);
//                 // print(birth_pet);
//                 // print(fav_food);
//
//                 await ApiService.createPet(id_pet, name_pet);
//                 // if (result != null) {
//                 //   SessionManager.saveToken(result);
//                 //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashboardPageView()));
//                 // }
//
//                 //   ScaffoldMessenger.of(context).showSnackBar(
//                 //     const SnackBar(content: Center(child: Text('Data berhasil diubah'))),
//                 //   );
//                 //
//                 //   Navigator.push(
//                 //     context,
//                 //     MaterialPageRoute(builder: (context) => DashboardPageView()),
//                 //   );
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
