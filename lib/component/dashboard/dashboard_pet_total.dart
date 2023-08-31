// import 'package:anabulhotel/api/api_service.dart';
// import 'package:anabulhotel/screen/hotel_pet/hotel_pet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../../api/api_service.dart';
import '../../helper/global_colors.dart';
import '../../screen/reservation/reservation.dart';

class DashboardPetTotal extends StatelessWidget {
  const DashboardPetTotal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalColors globalColors = GlobalColors();
    List<String> defaultListTotal = ['Hewan', 'Anjing', 'Kucing'];
    // List<Map<String, dynamic>> listPet = [];
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, d MMMM yyyy').format(now);
    formattedDate = formattedDate.replaceAll('Thursday', 'Kamis');
    formattedDate = formattedDate.replaceAll('Friday', 'Jumat');
    formattedDate = formattedDate.replaceAll('Saturday', 'Sabtu');
    formattedDate = formattedDate.replaceAll('Sunday', 'Minggu');
    formattedDate = formattedDate.replaceAll('Monday', 'Senin');
    formattedDate = formattedDate.replaceAll('Tuesday', 'Selasa');
    formattedDate = formattedDate.replaceAll('Wednesday', 'Rabu');
    formattedDate = formattedDate.replaceAll('January', 'Januari');
    formattedDate = formattedDate.replaceAll('February', 'Februari');
    formattedDate = formattedDate.replaceAll('March', 'Maret');
    formattedDate = formattedDate.replaceAll('April', 'April');
    formattedDate = formattedDate.replaceAll('May', 'Mei');
    formattedDate = formattedDate.replaceAll('June', 'Juni');
    formattedDate = formattedDate.replaceAll('July', 'Juli');
    formattedDate = formattedDate.replaceAll('August', 'Agustus');
    formattedDate = formattedDate.replaceAll('September', 'September');
    formattedDate = formattedDate.replaceAll('October', 'Oktober');
    formattedDate = formattedDate.replaceAll('November', 'November');
    formattedDate = formattedDate.replaceAll('December', 'Desember');

    return Container(
        width: MediaQuery.of(context).size.width,
        // color: Colors.amber,
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              formattedDate,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Total Hewan yang ditangani",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 10),
              // color: Colors.blue,
              child: FutureBuilder<Map<String, dynamic>>(
                future: Dashboard.getDashboardTotalPet(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    Map<String, dynamic> dataDashboard = snapshot.data!;
                    final List<dynamic> listPet =
                        dataDashboard['TotalByCategory'];
                    print("list : $listPet");
                    print("petlistdash: ${listPet.length}");
                    if (snapshot.hasData && listPet != null) {
                      // print("dashboard data: $dataDashboard");
                      final totalPet = dataDashboard['total_pet'].toString();
                      // print("total by category : $listPet");
                      // return Text("haloo");
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 20.w,
                            height: 20.w,
                            decoration: BoxDecoration(
                              color: globalColors.bgOrange,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Text(
                                      totalPet,
                                      style: TextStyle(
                                        fontSize: 24.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      "Hewan",
                                      style: TextStyle(
                                        fontSize: 8.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: listPet.map((pets) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                width: 20.w,
                                height: 20.w,
                                decoration: BoxDecoration(
                                  color: globalColors.bgOrange,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Text(
                                          pets['total'].toString(),
                                          style: TextStyle(
                                            fontSize: 24.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          pets['name'],
                                          style: TextStyle(
                                            fontSize: 8.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          )
                        ],
                      );
                    } else if (listPet == null) {
                      // Tidak ada data tagihan yang diterima
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: defaultListTotal.map((hewan) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            width: 20.w,
                            height: 20.w,
                            decoration: BoxDecoration(
                              color: globalColors.bgOrange,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Text(
                                      "0",
                                      style: TextStyle(
                                        fontSize: 24.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      hewan,
                                      style: TextStyle(
                                        fontSize: 8.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      return Container();
                    }
                  }
                },
              ),
            ),
          ],
        ));
  }
}
