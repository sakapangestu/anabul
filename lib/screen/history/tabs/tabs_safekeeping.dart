// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/component/history/safekeeping/safekeeping_in.dart';
// import 'package:anabulhotel/component/history/safekeeping/safekeeping_out.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../component/history/safekeeping/safekeeping_in.dart';
import '../../../component/history/safekeeping/safekeeping_out.dart';
import '../../../helper/global_colors.dart';

class TabsSafekeeping extends StatefulWidget {
  const TabsSafekeeping({Key? key}) : super(key: key);

  @override
  State<TabsSafekeeping> createState() => _TabsSafekeeping();
}

class _TabsSafekeeping extends State<TabsSafekeeping> {
  int activePage = 0;
  GlobalColors globalColors = GlobalColors();
  bool isMainActive = true;
  List<bool> indicator = [];
  List<String> tabs = ["Masuk", "Keluar"];
  String activeTab = "Masuk";

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

  Expanded setSafeKeepingView() {
    Expanded box;
    Widget child = Container();

    if (activeTab == "Masuk") {
      child = const SafekeepingIn(
        status: "Masuk",
      );
    } else if (activeTab == "Keluar") {
      child = const SafekeepingOut(
        status: "Keluar",
      );
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
                        indicator = resetIndicator();
                        indicator[index] = true;
                        activeTab = tabs[index];
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 8),
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 30),
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
        setSafeKeepingView()
      ],
    );
  }
}
