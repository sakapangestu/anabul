import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../helper/global_colors.dart';

class PetDetail extends StatefulWidget {

  const PetDetail({Key? key, required this.data}) : super(key: key);

  final dynamic data;

  @override
  _PetDetail createState() => _PetDetail();

}

class _PetDetail extends State<PetDetail> {

  GlobalColors globalColors = GlobalColors();
  Color iconColor = Colors.grey;
  bool isMainActive = true;
  bool isImageOnline = false;
  String networkImage = "https://cdn1.iconfinder.com/data/icons/user-pictures/100/female1-512.png";

  @override
  void initState() {
    bool checkUri = Uri.tryParse("")?.hasAbsolutePath ?? false;

    if(checkUri) {
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
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
                "Data Hewan",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Wrap(
            runSpacing: 25,
            children: List.generate(widget.data.length, (index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      widget.data[index]["name"].toString(),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.data[index]["value"].toString(),
                      textAlign: TextAlign.right,
                      // widget.data["statusStaffs"]["name"],
                      style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ],
              );
            }),
          )
        ],
      ),
    );
  }

}