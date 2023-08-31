// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../api/api_service.dart';
import '../../helper/global_colors.dart';
import '../../helper/global_date.dart';

class ConditionStaffPet extends StatefulWidget {
  const ConditionStaffPet(
      {Key? key, required this.idCondition, required this.dataPet})
      : super(key: key);

  final String idCondition;
  final Map dataPet;

  @override
  State<ConditionStaffPet> createState() => _ConditionStaffPet();
}

class _ConditionStaffPet extends State<ConditionStaffPet> {
  GlobalColors globalColors = GlobalColors();
  DateHelpers dateGlobal = DateHelpers();
  String defaultImageCondition = BaseImage.getImageCondition();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: TesSpecies.getPetConditions(widget.idCondition),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final petConditions = snapshot.data!;
          print("pet isi pa: $petConditions");
          return ListView.builder(
            itemCount: petConditions.length,
            itemBuilder: (context, index) {
              final petCondition = petConditions[index];
              final createdAt = petCondition['CreatedAt'];
              final splitDateTime = createdAt.split('T');
              final date = splitDateTime[0];
              final time = splitDateTime[1].substring(0, 8);

              final splitDate = date.split('-');
              final year = splitDate[0];
              final month =
                  DateHelpers.getIndonesianMonthName(int.parse(splitDate[1]));
              final day = splitDate[2];

              final splitTime = time.split(':');
              final hour = splitTime[0];
              final minute = splitTime[1];

              final formattedDate = '$day $month $year';
              final dateTime = DateTime.parse(createdAt);
              final dayOfWeek =
                  DateHelpers.getIndonesianDayName(dateTime.weekday);

              String times = "$hour:$minute";
              String dates = "$dayOfWeek, $formattedDate";

              // Render the pet condition data as needed
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: Colors.black, width: 0.5)),
                        // color: Colors.red,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                dates,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 8.sp,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    (petCondition['condition'] == "Makan")
                                        ? Icons.food_bank_rounded
                                        : Icons.sports_baseball_rounded,
                                    color: globalColors.bgOrange,
                                    size: 12.sp,
                                  ),
                                  const SizedBox(width: 7),
                                  Text(petCondition['title'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10.sp,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                            Text(
                              petCondition['description'],
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(times,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 6.sp,
                                        color: Colors.black)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
