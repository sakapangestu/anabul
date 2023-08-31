// import 'package:anabulhotel/screen/tes/dropdown_tes.dart';
// import 'package:anabulhotel/screen/tes/nested_dropdown.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../api/api_service.dart';
// import '../../component/button/rectangle/rectangle_orange_disabled.dart';
// import '../../helper/global_colors.dart';
// import '../../model/data.dart';
//
// class TesPage extends StatelessWidget {
//   // DetailPage({Key? key, required Posts posts}) : super(key: key);
//
//   final Pets pets;
//
//   TesPage({Key? key, required this.pets}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     GlobalColors globalColors = GlobalColors();
//     String image = "https://3796-182-2-41-173.ap.ngrok.io/user/profile/${pets.image}";
//     String image2 = "https://3796-182-2-41-173.ap.ngrok.io/user/profile/default_pet.png";
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Detail Page'),
//       ),
//       body: SafeArea(
//           child:
//           Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text(
//               'id: ${pets.id_pet}',
//             ),
//             Text('name: ${pets.name}'),
//             Text('kelamin: ${pets.gender}'),
//
//             const SizedBox(
//               height: 20,
//             ),
//             SizedBox(width: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   width: 100,
//                   height: 100,
//                   child: Stack(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(100)),
//                             color: globalColors.bgOrangeDisabled,
//                             image: DecorationImage(
//                                 image: NetworkImage(image),
//                                 fit: BoxFit.cover
//                             )
//                         ),
//                         child: image != null ? null : Image(image: NetworkImage(image2))
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Material(
//                                 color: Colors.transparent,
//                                 child: InkWell(
//                                   onTap: () {
//                                     // Navigator.push(
//                                     //   context,
//                                     //   // MaterialPageRoute(builder: (context) => DetailUser()),
//                                     //   MaterialPageRoute(builder: (context) => DetailUser()),
//                                     // );
//                                   },
//                                   borderRadius: const BorderRadius.all(Radius.circular(8)),
//                                   splashColor: globalColors.bgOrangeDisabled,
//                                   child: Container(
//                                     width: 30,
//                                     height: 30,
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         border: Border.all(color: globalColors.bgOrange, width: 1),
//                                         borderRadius: const BorderRadius.all(Radius.circular(100))
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2),
//                                       child: Icon(Icons.edit, size: 20, color: globalColors.bgOrange,),
//                                       // child: Image.asset("assets/icons/icon-edit-profile.png", scale: 3.5),
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Container(
//               height: 100,
//               width: 100,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(100)),
//                   color: globalColors.bgOrangeDisabled,
//                   image: DecorationImage(
//                       image: NetworkImage(image),
//                       fit: BoxFit.cover
//                   )
//               ),
//               child: image != null ? null : Center(
//                 child: Icon(
//                   Icons.pets_sharp,
//                   size: 50,
//                   color: globalColors.bgOrange,
//                 ),
//               ),
//             )
//           ])
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
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => TesEdit(pets: pets)),
//               );
//             },
//             child: RectangleOrangeDisabled(title: "Ubah",),
//           ),
//         ),
//       ),
//     );
//   }
// }