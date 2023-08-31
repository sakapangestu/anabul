import 'package:anabul/api/api_service.dart';
// import 'package:anabulhotel/component/dashboard/dashboard_pet_staff_out.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
// import 'package:anabulhotel/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../component/dashboard/dashboard_pet_staff.dart';
import '../../component/dashboard/dashboard_pet_staff_in.dart';
import '../../component/dashboard/dashboard_pet_staff_out.dart';
import '../../component/dashboard/dashboard_pet_total.dart';
import '../../helper/global_colors.dart';

class DashboardStaff extends StatefulWidget {
  const DashboardStaff({
    Key? key,
  }) : super(key: key);

  @override
  State<DashboardStaff> createState() => _DashboardStaff();
}

class _DashboardStaff extends State<DashboardStaff> {
  List<Map<String, dynamic>> provinceList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalColors globalColors = GlobalColors();
    return Scaffold(
      backgroundColor: globalColors.textWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 24, left: 24, top: 15),
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  height: 65,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            // color: Colors.red,
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/splash/app_logos_horizontal.png"),
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                      FutureBuilder<Map<String, dynamic>?>(
                        future: ApiService.getDataUser(),
                        builder: (BuildContext context,
                            AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData) {
                            return const Center(
                                child: Text('tidak mendapatkan data'));
                          } else {
                            Map<String, dynamic>? data = snapshot.data!;
                            return Text(
                              data['hotel']['name'],
                              style: TextStyle(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold,
                                color: globalColors.bgOrange,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  )),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder<Map<String, dynamic>?>(
                          future: ApiService.getDataUser(),
                          builder: (BuildContext context,
                              AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (!snapshot.hasData) {
                              return const Center(
                                  child: Text('tidak mendapatkan data'));
                            } else {
                              Map<String, dynamic>? data = snapshot.data!;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hai, ${data['name']}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "Semangat bekerja ya hari ini :)",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Catatan Hari ini",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const DashboardPetTotal(),
                        Column(
                          children: [
                            DashboardPetStaff(),
                            DashboardPetStaffIn(),
                            DashboardPetStaffOut(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
