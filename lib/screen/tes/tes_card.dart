// import 'package:anabulhotel/screen/staff/condition/detail/detail_condition_staff.dart';
import 'package:flutter/material.dart';

import '../../api/api_service.dart';
import '../../helper/global_colors.dart';
import '../../model/data.dart';
import '../../screen/dashboard/dashboard_pageview.dart';
import '../../screen/pet/detail/detail_pet.dart';
import '../condition/detail/detail_condition.dart';

class ConditionListTes extends StatelessWidget {
  const ConditionListTes({Key? key, required this.pets, required this.age})
      : super(key: key);
  final Map pets;
  final String age;

  @override
  Widget build(BuildContext context) {
    print("object: ${pets['image']}");
    String defaultImagePet = BaseImage.getImagePet();
    GlobalColors globalColors = GlobalColors();
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: ((context) {
        //       return DetailCondition(pets: pets, age: age,);
        //     }),
        //   ),
        // );
      },
      child: Container(
        height: 80,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100)),
                      color: globalColors.bgOrangeDisabled,
                      image: DecorationImage(
                          image: (pets['image'] != defaultImagePet)
                              ? NetworkImage(defaultImagePet + pets['image'])
                              : NetworkImage(
                                  "${defaultImagePet}default_pet.png"),
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
                        // "gg",
                        pets['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        age,
                        // "ff",
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
  }
}
