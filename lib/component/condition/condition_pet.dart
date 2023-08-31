// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../api/api_service.dart';
import '../../helper/global_colors.dart';
import '../../helper/global_date.dart';

class ConditionPet extends StatefulWidget {
  const ConditionPet(
      {Key? key, required this.idCondition, required this.dataPet})
      : super(key: key);

  final String idCondition;
  final Map dataPet;

  @override
  State<ConditionPet> createState() => _ConditionPet();
}

class _ConditionPet extends State<ConditionPet> {
  GlobalColors globalColors = GlobalColors();
  DateHelpers dateGlobal = DateHelpers();
  String defaultImageCondition = BaseImage.getImageCondition();

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

              print('Date: $dates');
              print('Time: $times');
              // Render the pet condition data as needed
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // bermain
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              "$dates $times WIB",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 8.sp,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, 7),
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.3))
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: globalColors.bgOrangeDisabled,
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: (petCondition['image'] != null)
                                            ? NetworkImage(
                                                defaultImageCondition +
                                                    petCondition['image'])
                                            : const AssetImage(
                                                    "assets/splash/app_logos.png")
                                                as ImageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      // padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                (petCondition['condition'] ==
                                                        "Makan")
                                                    ? Icons.food_bank_rounded
                                                    : Icons
                                                        .sports_baseball_rounded,
                                                color: globalColors.bgOrange,
                                                size: 12.sp,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(petCondition['title'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 10.sp,
                                                      color: Colors.black)),
                                            ],
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                              '"' +
                                                  " ${petCondition['description']} " +
                                                  '"',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.sp,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
