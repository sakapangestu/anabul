// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/component/notification/notification_condition.dart';
// import 'package:anabulhotel/component/notification/notification_history.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../component/app_bar/app_bar_tittle.dart';
import '../../component/notification/notification_condition.dart';
import '../../component/notification/notification_history.dart';
import '../../helper/global_colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenstate();
}

class _NotificationScreenstate extends State<NotificationScreen> {
  int activePage = 0;
  GlobalColors globalColors = GlobalColors();
  bool isMainActive = true;
  ScrollController controller = ScrollController();
  List<bool> indicator = [];
  List<String> tabs = ["Notifikasi Riwayat", "Notifikasi Aktifitas"];
  String activeTab = "Notifikasi Riwayat";
  // String notificationsCounter = "";
  // String announcementCounter = "";

  @override
  void initState() {
    indicator = [true, false];
    super.initState();
  }

  List<bool> resetIndicator() {
    List<bool> tempIndicator = indicator;
    tempIndicator = List.generate(
        indicator.length, (index) => tempIndicator[index] = false);

    return tempIndicator;
  }

  Expanded setListView() {
    Expanded box;
    Widget child = Container();

    if (activeTab == "Notifikasi Riwayat") {
      child = const NotificationHistory();
    } else if (activeTab == "Notifikasi Kondisi") {
      child = const NotificationCondition();
    }

    box = Expanded(
      child: child,
    );

    return box;
  }

  @override
  Widget build(BuildContext context) {
    // print(indicator);
    // print(tabs);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: const Color(0xffDC822A),
          flexibleSpace: const SafeArea(
            child: AppBarTitle(
              title: "Notifikasi",
            ),
          ),
        ),
        // backgroundColor: Colors.white,
        body: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // width: 3000,
                height: 110,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: globalColors.borderLine))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 15, left: 20, right: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(tabs.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                indicator = resetIndicator();
                                indicator[index] = true;
                                activeTab = tabs[index];
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  right: 8, top: 2, bottom: 2),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 25),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100)),
                                color: indicator[index]
                                    ? globalColors.bgOrange
                                    : const Color(0x0fff7ddc),
                                border: Border.all(
                                  color: indicator[index]
                                      ? globalColors.textWhite
                                      : globalColors.bgOrange,
                                ),
                              ),
                              child: Text(
                                tabs[index],
                                // "Notifikasi " + indicatorTotalNotifications,
                                style: TextStyle(
                                    color: indicator[index]
                                        ? globalColors.textWhite
                                        : globalColors.bgOrange,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          );
                        }),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: globalColors.textWhite,
                              onTap: () {},
                              child: Text(
                                "Tandai Semua Telah Dibaca",
                                style: TextStyle(
                                    color: globalColors.textBlackBold,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              setListView(),
              // Expanded(child: Row())
            ],
          ),
        ));
  }
}
