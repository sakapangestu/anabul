import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../../api/api_service.dart';
import '../../../../helper/global_colors.dart';

class DetailPet extends StatelessWidget {
  const DetailPet({
    Key? key,
    required this.name,
    required this.age,
    required this.image,
  }) : super(key: key);
  final String name;
  final String age;
  final String image;

  @override
  Widget build(BuildContext context) {
    print("object imgae : $image");
    String defaultImagePet = BaseImage.getImagePet();
    GlobalColors globalColors = GlobalColors();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: globalColors.bgOrange, width: 0.3),
      )),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    color: globalColors.bgOrangeDisabled,
                    image: DecorationImage(
                        image: (image != defaultImagePet)
                            ? NetworkImage(image)
                            : NetworkImage("${defaultImagePet}default_pet.png"),
                        fit: BoxFit.cover)),
                // child: image != null ? null : Image(image: NetworkImage(image2))
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      age,
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
    );
  }
}
