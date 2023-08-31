// import 'package:anabulhotel/component/user/user_panel/user_panel_logout.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
// import 'package:anabulhotel/api/api_service.dart';
// import 'package:anabulhotel/screen/user/detail/detail_user.dart';
// import 'package:anabulhotel/screen/user/detail/detail_user_tes.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../api/api_service.dart';
import '../../component/app_bar/app_bar_tittle_menu_bar.dart';
import '../../component/button/rounded/rounded_logout.dart';
import '../../component/user/user_panel/user_panel_logout.dart';
import '../../component/user/user_setting_item.dart';
import '../../helper/global_colors.dart';
import '../../helper/session.dart';
import 'condition/detail/detail_staff.dart';

class UserStaff extends StatefulWidget {
  const UserStaff({Key? key}) : super(key: key);
  @override
  State<UserStaff> createState() => _UserStaff();
}

class _UserStaff extends State<UserStaff> {
  GlobalColors globalColors = GlobalColors();
  PanelController pc = PanelController();
  String defaultImage = BaseImage.getImageUser();
  List<Map<String, dynamic>> menuInfoProfile = [];
  String? imageDefault;

  @override
  void initState() {
    menuInfoProfile.add({
      "name": "Keamanan",
      "route": "/menuSecurity",
      "icon": Ionicons.shield
    });
    menuInfoProfile.add({
      "name": "Bantuan",
      "route": "/menuHelp",
      "icon": Ionicons.help_circle_sharp
    });
    // menuInfoProfile.add({"name": "Mode Tampilan", "route": "", "icon": Ionicons.color_palette});
    menuInfoProfile.add({
      "name": "Tentang Anabul Hotel",
      "route": "/menuAboutUs",
      "icon": Ionicons.information_circle
    });
    menuInfoProfile.add(
        {"name": "Keluar Akun", "route": "", "icon": Ionicons.log_out_outline});
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("ini isi apa: $defaultImage");
    // setState(() {
    //   userImage = userImage + data['image'];
    // });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Icon(Ionicons.reorder_four, color: globalColors.iconOrange),
        backgroundColor: Colors.white,
        flexibleSpace: const SafeArea(
          child: AppBarTitleMenuBar(
            title: "Profil",
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SlidingUpPanel(
          panelBuilder: (ScrollController sc) => UserPanelLogout(pc: pc),
          controller: pc,
          isDraggable: true,
          maxHeight: 30.h,
          minHeight: 0,
          backdropEnabled: true,
          backdropTapClosesPanel: true,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    // border: Border(bottom: BorderSide(width: 1, color: globalColors.borderLine)),
                    // color: Colors.red,
                    ),
                child: Column(
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
                          return const Center(child: Text('No data'));
                        } else {
                          Map<String, dynamic>? data = snapshot.data!;
                          print("data : $data");
                          String? imageTes = data['image'];
                          Map hotel = data['hotel'];
                          String hotelName = hotel['name'];
                          // print("isi apa : ${data['image']}");
                          return Column(
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
                                          backgroundImage: (imageTes!.isEmpty)
                                              ? Image.asset(
                                                      'assets/background/default_user.png')
                                                  .image
                                              : NetworkImage(
                                                  defaultImage + imageTes),
                                          backgroundColor:
                                              globalColors.bgOrangeDisabled,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    DetailStaff(
                                                                      user:
                                                                          data,
                                                                    )),
                                                      );
                                                    },
                                                    child: Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color:
                                                                  globalColors
                                                                      .bgOrange,
                                                              width: 1),
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          100))),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2),
                                                        child: Icon(
                                                          Icons.edit,
                                                          size: 20,
                                                          color: globalColors
                                                              .bgOrange,
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
                                data['name'],
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                data['role'] + " (${hotelName})",
                                style: TextStyle(
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "General Akun",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp),
                    ),
                    Column(
                      children: List.generate(menuInfoProfile.length, (index) {
                        return UserSettingItem(
                            data: menuInfoProfile[index], pc: pc);
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
// Wrap setMenuProfile() {
//   return Wrap(
//     children: List.generate(menuInfoProfile.length, (index) => UserSettingItem(data: menuInfoProfile[index])),
//   );
// }
}
