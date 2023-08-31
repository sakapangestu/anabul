// import 'package:anabulhotel/api/api_service.dart';
// import 'package:anabulhotel/screen/hotel_pet/hotel_pet.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../../api/api_service.dart';
import '../../helper/global_colors.dart';
import '../../screen/reservation/reservation.dart';

class DashboardPetStaffIn extends StatelessWidget {
  const DashboardPetStaffIn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalColors globalColors = GlobalColors();
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hewan Yang Akan Masuk",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Hewan",
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: globalColors.textBlackBold,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Pemilik Hewan",
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: globalColors.textBlackBold,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: Dashboard.getDashboardStaffStatus("Masuk"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<Map<String, dynamic>> dataDashboard = snapshot.data!;
                      // final listPet = dataDashboard['TotalByCategory'];
                      print("list : $dataDashboard");
                      // print("petlistdash: ${listPet.length}");
                      if (snapshot.hasData && dataDashboard.isNotEmpty) {
                        return Column(
                          children:
                              List.generate(dataDashboard.length, (index) {
                            var petData = dataDashboard[index];
                            var pet = petData['name'];
                            var user = petData['user'];
                            // print("object pet: $pet");
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(0, 2),
                                            blurRadius: 8,
                                            color:
                                                Colors.black.withOpacity(0.3),
                                          )
                                        ],
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.pets_rounded,
                                            color: globalColors.bgOrange,
                                            size: 12.sp,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            pet,
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              color: globalColors.bgOrange,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(0, 2),
                                            blurRadius: 8,
                                            color:
                                                Colors.black.withOpacity(0.3),
                                          )
                                        ],
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.person_2_rounded,
                                            color: globalColors.bgOrange,
                                            size: 12.sp,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            user['name'],
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              overflow: TextOverflow.ellipsis,
                                              color: globalColors.bgOrange,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        );
                      } else {
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(0, 2),
                                        blurRadius: 8,
                                        color: Colors.black.withOpacity(0.3),
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.pets_rounded,
                                        color: globalColors.textBlackBold,
                                        size: 12.sp,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Kosong",
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: globalColors.textBlackBold,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(0, 2),
                                        blurRadius: 8,
                                        color: Colors.black.withOpacity(0.3),
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.person_2_rounded,
                                        color: globalColors.textBlackBold,
                                        size: 12.sp,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Kosong",
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: globalColors.textBlackBold,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                ),
                // FutureBuilder<List<Map<String, dynamic>>>(
                //   future: Dashboard.getDashboardStaffStatus("Masuk"),
                //   builder: (context, snapshot) {
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return const CircularProgressIndicator();
                //     } else if (snapshot.hasError) {
                //       return Text('Error: ${snapshot.error}');
                //     } else {
                //       if (snapshot.hasData) {
                //         List<Map<String, dynamic>> data = snapshot.data!;
                //         // print("datapet: $data");
                //         // var pet = data['pet'];
                //         return Column(
                //           children: List.generate(data.length, (index) {
                //             var petData = data[index];
                //             var pet = petData['pet'];
                //             // print("object pet: $pet");
                //             return data.isNotEmpty
                //                 ? Row(
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.spaceBetween,
                //                     children: [
                //                       Expanded(
                //                         flex: 2,
                //                         child: Container(
                //                           padding: const EdgeInsets.symmetric(
                //                               vertical: 8, horizontal: 5),
                //                           decoration: BoxDecoration(
                //                             color: Colors.white,
                //                             borderRadius:
                //                                 BorderRadius.circular(6),
                //                             boxShadow: [
                //                               BoxShadow(
                //                                 offset: const Offset(0, 2),
                //                                 blurRadius: 8,
                //                                 color: Colors.black
                //                                     .withOpacity(0.3),
                //                               )
                //                             ],
                //                           ),
                //                           child: Row(
                //                             crossAxisAlignment:
                //                                 CrossAxisAlignment.center,
                //                             children: [
                //                               Icon(
                //                                 Icons.pets_rounded,
                //                                 color:
                //                                     globalColors.textBlackBold,
                //                                 size: 12.sp,
                //                               ),
                //                               const SizedBox(width: 10),
                //                               Text(
                //                                 "Kosong",
                //                                 style: TextStyle(
                //                                   fontSize: 11.sp,
                //                                   color: globalColors
                //                                       .textBlackBold,
                //                                   fontWeight: FontWeight.w500,
                //                                 ),
                //                               ),
                //                             ],
                //                           ),
                //                         ),
                //                       ),
                //                       const SizedBox(width: 10),
                //                       Expanded(
                //                         flex: 3,
                //                         child: Container(
                //                           padding: const EdgeInsets.symmetric(
                //                               vertical: 8, horizontal: 5),
                //                           decoration: BoxDecoration(
                //                             color: Colors.white,
                //                             borderRadius:
                //                                 BorderRadius.circular(6),
                //                             boxShadow: [
                //                               BoxShadow(
                //                                 offset: const Offset(0, 2),
                //                                 blurRadius: 8,
                //                                 color: Colors.black
                //                                     .withOpacity(0.3),
                //                               )
                //                             ],
                //                           ),
                //                           child: Row(
                //                             crossAxisAlignment:
                //                                 CrossAxisAlignment.center,
                //                             children: [
                //                               Icon(
                //                                 Icons.person_2_rounded,
                //                                 color:
                //                                     globalColors.textBlackBold,
                //                                 size: 12.sp,
                //                               ),
                //                               const SizedBox(width: 10),
                //                               Text(
                //                                 "Kosong",
                //                                 style: TextStyle(
                //                                   fontSize: 11.sp,
                //                                   overflow:
                //                                       TextOverflow.ellipsis,
                //                                   color: globalColors
                //                                       .textBlackBold,
                //                                   fontWeight: FontWeight.w500,
                //                                 ),
                //                               ),
                //                             ],
                //                           ),
                //                         ),
                //                       ),
                //                     ],
                //                   )
                //                 : Container(
                //               padding: const EdgeInsets.symmetric(vertical: 2),
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                 children: [
                //                   Expanded(
                //                     flex: 2,
                //                     child: Container(
                //                       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                //                       decoration: BoxDecoration(
                //                         color: Colors.white,
                //                         borderRadius: BorderRadius.circular(6),
                //                         boxShadow: [BoxShadow(
                //                           offset: const Offset(0, 2),
                //                           blurRadius: 8,
                //                           color: Colors.black.withOpacity(0.3),
                //                         )],
                //                       ),
                //                       child: Row(
                //                         crossAxisAlignment: CrossAxisAlignment.center,
                //                         children: [
                //                           Icon(Icons.pets_rounded,color: globalColors.bgOrange, size: 12.sp,),
                //                           const SizedBox(width: 10),
                //                           Text(
                //                             pet['name'],
                //                             style: TextStyle(
                //                               fontSize: 11.sp,
                //                               color: globalColors.bgOrange,
                //                               fontWeight: FontWeight.w500,
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ),
                //                   ),
                //                   const SizedBox(width: 10),
                //                   Expanded(
                //                     flex: 3,
                //                     child: Container(
                //                       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                //                       decoration: BoxDecoration(
                //                         color: Colors.white,
                //                         borderRadius: BorderRadius.circular(6),
                //                         boxShadow: [BoxShadow(
                //                           offset: const Offset(0, 2),
                //                           blurRadius: 8,
                //                           color: Colors.black.withOpacity(0.3),
                //                         )],
                //                       ),
                //                       child: Row(
                //                         crossAxisAlignment: CrossAxisAlignment.center,
                //                         children: [
                //                           Icon(Icons.person_2_rounded,color: globalColors.bgOrange, size: 12.sp,),
                //                           const SizedBox(width: 10),
                //                           Text(
                //                             pet['user']['name'],
                //                             style: TextStyle(
                //                               fontSize: 11.sp,
                //                               color: globalColors.bgOrange,
                //                               fontWeight: FontWeight.w500,
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             );
                //           }),
                //         );
                //       } else {
                //         // Tidak ada data tagihan yang diterima
                //         return const Text('Tidak ada data tagihan.');
                //       }
                //     }
                //   },
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
