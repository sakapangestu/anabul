// import 'package:anabulhotel/helper/session.dart';
// import 'package:anabulhotel/screen/staff/condition/detail/detail_condition_staff.dart';
import 'package:flutter/material.dart';

import '../../api/api_service.dart';
import '../../helper/global_colors.dart';
import '../../helper/session.dart';
import '../staff/condition/detail/detail_condition_staff.dart';
import 'detail/detail_condition.dart';

class ConditionList extends StatelessWidget {
  const ConditionList(
      {Key? key,
      required this.pets,
      required this.age,
      required this.idCondition})
      : super(key: key);
  final Map pets;
  final String age;
  final String idCondition;

  @override
  Widget build(BuildContext context) {
    String defaultImagePet = BaseImage.getImagePet();
    GlobalColors globalColors = GlobalColors();
    return InkWell(
      onTap: () async {
        final data = await SessionManager.getData();
        final role = data!['data']['role'];
        print("objectku : $role");
        if (role == "Staff") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) {
                return DetailConditionStaff(
                  pets: pets,
                  age: age,
                  idCondition: idCondition,
                );
              }),
            ),
          );
        } else if (role == "Customer") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) {
                return DetailCondition(
                  pets: pets,
                  age: age,
                  idCondition: idCondition,
                );
              }),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
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
                        pets['name'],
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
      ),
    );
  }
}
