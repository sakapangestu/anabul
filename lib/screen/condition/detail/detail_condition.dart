// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/component/condition/condition_pet.dart';
// import 'package:anabulhotel/component/pet/pet_detail.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../api/api_service.dart';
import '../../../component/app_bar/app_bar_tittle.dart';
import '../../../component/condition/condition_pet.dart';
import '../../../helper/global_colors.dart';
import '../../../model/data.dart';

class DetailCondition extends StatefulWidget {
  const DetailCondition(
      {Key? key,
      required this.pets,
      required this.age,
      required this.idCondition})
      : super(key: key);
  final Map pets;
  final String age;
  final String idCondition;

  @override
  State<DetailCondition> createState() => _DetailCondition();
}

class _DetailCondition extends State<DetailCondition> {
  int activePage = 0;
  GlobalColors globalColors = GlobalColors();
  // bool isImageOnline = false;
  // String networkImage = "https://cdn1.iconfinder.com/data/icons/user-pictures/100/female1-512.png";

  Expanded setConditionView() {
    print("isi apa kondisi :${widget.pets}");
    Expanded box;
    Widget child = Container(
      child: ConditionPet(
        idCondition: widget.idCondition,
        dataPet: widget.pets,
      ),
    );

    box = Expanded(
      child: child,
    );

    return box;
  }

  @override
  Widget build(BuildContext context) {
    String defaultImagePet = BaseImage.getImagePet();
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
            title: "Detail Kondisi",
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                  right: 24, left: 24, top: 15, bottom: 15),
              decoration: BoxDecoration(
                  // color: Colors.red,
                  //   color: Colors.green,
                  border: Border(
                      bottom: BorderSide(
                          width: 1, color: globalColors.borderLine))),
              child: Container(
                height: 50,
                // color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              width: 1, color: globalColors.borderLine),
                          image: DecorationImage(
                              image: (widget.pets['image'] != defaultImagePet)
                                  ? NetworkImage(
                                      defaultImagePet + widget.pets['image'])
                                  : NetworkImage(
                                      "${defaultImagePet}default_pet.png"),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.pets['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.age,
                            style: TextStyle(
                              color: globalColors.textGray,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            setConditionView(),
          ],
        ),
      ),
    );
  }
}
