// import 'package:anabulhotel/helper/global_colors.dart';
// import 'package:anabulhotel/screen/history/tabs/tabs_payment.dart';
// import 'package:anabulhotel/screen/history/tabs/tabs_reservation.dart';
// import 'package:anabulhotel/screen/history/tabs/tabs_safekeeping.dart';
import 'package:anabul/screen/history/tabs/tabs_payment.dart';
import 'package:anabul/screen/history/tabs/tabs_reservation.dart';
import 'package:anabul/screen/history/tabs/tabs_safekeeping.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ionicons/ionicons.dart';

import '../../component/app_bar/app_bar_tittle_menu_bar.dart';
import '../../helper/global_colors.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreen();
}

class _HistoryScreen extends State<HistoryScreen> {
  int activePage = 0;
  GlobalColors globalColors = GlobalColors();
  bool isMainActive = true;
  List<bool> indicator = [];
  List<String> tabs = ["Reservasi", "Penitipan", "Pembayaran"];
  String activeTab = "Reservasi";

  @override
  void initState() {
    indicator = [true, false, false];
    super.initState();
  }

  List<bool> resetIndicator() {
    List<bool> tempIndicator = indicator;
    print("indikator: $indicator");
    tempIndicator = List.generate(
        indicator.length, (index) => tempIndicator[index] = false);

    return tempIndicator;
  }

  Expanded setSubTabsHistory() {
    Expanded box;
    Widget child = Container();

    if (activeTab == "Reservasi") {
      child = const TabsReservation();
    } else if (activeTab == "Penitipan") {
      child = const TabsSafekeeping();
    } else if (activeTab == "Pembayaran") {
      child = const TabsPayment();
    }
    print("asktif tab: $activeTab");

    box = Expanded(
      child: child,
    );

    return box;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        // leading: Icon(Ionicons.reorder_four, color: globalColors.iconOrange),
        backgroundColor: Colors.white,
        flexibleSpace: const SafeArea(
          child: AppBarTitleMenuBar(
            title: "Riwayat",
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 10.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1, color: globalColors.borderLine))),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
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
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
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
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    })),
              ),
            ),
            setSubTabsHistory()
          ],
        ),
      ),
    );
  }
}
