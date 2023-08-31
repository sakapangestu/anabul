// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/component/history/reservation/reservation_accept.dart';
// import 'package:anabulhotel/component/history/reservation/reservation_cancel.dart';
// import 'package:anabulhotel/component/history/reservation/reservation_finish.dart';
// import 'package:anabulhotel/component/history/reservation/reservation_process.dart';
// import 'package:anabulhotel/component/history/reservation/reservation_reject.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../component/history/reservation/reservation_accept.dart';
import '../../../component/history/reservation/reservation_cancel.dart';
import '../../../component/history/reservation/reservation_finish.dart';
import '../../../component/history/reservation/reservation_process.dart';
import '../../../component/history/reservation/reservation_reject.dart';
import '../../../helper/global_colors.dart';

class TabsReservation extends StatefulWidget {
  const TabsReservation({Key? key}) : super(key: key);

  @override
  State<TabsReservation> createState() => _TabsReservation();
}

class _TabsReservation extends State<TabsReservation> {
  int activePage = 0;
  GlobalColors globalColors = GlobalColors();
  bool isMainActive = true;
  List<bool> indicator = [];
  List<String> tabs = [
    "Proses",
    "Diterima",
    "Selesai",
    "Ditolak",
    "Dibatalkan"
  ];
  String activeTab = "Proses";

  @override
  void initState() {
    indicator = [true, false, false, false, false];
    super.initState();
  }

  List<bool> resetIndicator() {
    List<bool> tempIndicator = indicator;
    tempIndicator = List.generate(
        indicator.length, (index) => tempIndicator[index] = false);

    return tempIndicator;
  }

  Expanded setReservationView() {
    Expanded box;
    Widget child = Container();

    if (activeTab == "Proses") {
      child = const ReservationProcess(status: "Proses");
    } else if (activeTab == "Diterima") {
      child = const ReservationAccept(
        status: "Diterima",
      );
    } else if (activeTab == "Selesai") {
      child = const ReservationFinish(status: "Selesai");
    } else if (activeTab == "Ditolak") {
      child = const ReservationReject(status: "Ditolak");
    } else if (activeTab == "Dibatalkan") {
      child = const ReservationCancel(status: "Dibatalkan");
    }

    box = Expanded(
      child: child,
    );

    return box;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            padding:
                const EdgeInsets.only(right: 24, left: 24, top: 10, bottom: 10),
            decoration: BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(width: 1, color: globalColors.borderLine))),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(tabs.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        print("tabs: $tabs");
                        print("tabs length: ${tabs.length}");
                        indicator = resetIndicator();
                        indicator[index] = true;
                        activeTab = tabs[index];
                        print("aktif tab: $activeTab");
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 30),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
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
                        style: TextStyle(
                            color: indicator[index]
                                ? globalColors.textWhite
                                : globalColors.bgOrange,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  );
                }),
              ),
            )),
        setReservationView()
        //
      ],
    );
  }
}
