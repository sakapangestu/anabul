// import 'package:anabulhotel/screen/condition/detail/detail_condition.dart';
// import 'package:anabulhotel/screen/staff/condition/detail/detail_condition_staff.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../helper/global_colors.dart';

class ConditionStaffListPet extends StatefulWidget {
  const ConditionStaffListPet({Key? key, required this.data}) : super(key: key);

  final dynamic data;

  @override
  _ConditionStaffListPet createState() => _ConditionStaffListPet();
}

class _ConditionStaffListPet extends State<ConditionStaffListPet> {
  GlobalColors globalColors = GlobalColors();
  Color iconColor = Colors.grey;
  bool isMainActive = true;
  bool isImageOnline = false;
  String networkImage =
      "https://cdn1.iconfinder.com/data/icons/user-pictures/100/female1-512.png";

  @override
  void initState() {
    bool checkUri = Uri.tryParse("")?.hasAbsolutePath ?? false;

    if (checkUri) {
      isImageOnline = true;
      networkImage = "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Wrap(
            // runSpacing: 25,
            children: List.generate(widget.data.length, (index) {
              return GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const DetailConditionStaff()),
                  // );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 2),
                  // color: Colors.red,
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            padding:
                                EdgeInsets.only(top: 10, bottom: 10, right: 10),
                            child: Container(
                              child: CircleAvatar(
                                radius: 80,
                                backgroundImage: NetworkImage(networkImage),
                                backgroundColor: Colors.black,
                              ),
                            ),
                            //
                          )),
                      Expanded(
                          flex: 4,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 50,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.data[index]["name"].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "Umur " +
                                      widget.data[index]["value"].toString() +
                                      " bulan",
                                  style: TextStyle(
                                    color: globalColors.textGray,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
