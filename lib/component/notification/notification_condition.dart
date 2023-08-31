// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';

import '../../api/api_service.dart';
import '../../helper/global_colors.dart';
import '../../helper/global_date.dart';
import '../../screen/dashboard/dashboard_pageview.dart';

class NotificationCondition extends StatefulWidget {
  const NotificationCondition({Key? key}) : super(key: key);

  @override
  State<NotificationCondition> createState() => _NotificationCondition();
}

class _NotificationCondition extends State<NotificationCondition> {
  GlobalColors globalColors = GlobalColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: History.getNotificationConditions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final conditionNotification = snapshot.data!;
              // print("notif isi pa: $conditionNotification");
              // return Text("data");
              return ListView.builder(
                itemCount: conditionNotification.length,
                itemBuilder: (context, index) {
                  final dataNotif = conditionNotification[index];
                  final createdAt = dataNotif['CreatedAt'];
                  final splitDateTime = createdAt.split('T');
                  final date = splitDateTime[0];
                  final time = splitDateTime[1].substring(0, 8);

                  final splitDate = date.split('-');
                  final year = splitDate[0];
                  final month = DateHelpers.getIndonesianMonthName(
                      int.parse(splitDate[1]));
                  final day = splitDate[2];

                  final splitTime = time.split(':');
                  final hour = splitTime[0];
                  final minute = splitTime[1];

                  final formattedDate = '$day $month $year';
                  // print("date: $formattedDate");
                  // final dateTime = DateTime.parse(createdAt);
                  // final dayOfWeek = DateHelpers.getIndonesianDayName(dateTime.weekday);

                  String times = "$hour:$minute";
                  // String dates = "$dayOfWeek, $formattedDate";

                  // print('Date: $dates');
                  // print('Time: $times');
                  // Render the pet condition data as needed
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashboardPageView(
                                    initialIndex: 2,
                                  )));
                    },
                    child: Column(children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: globalColors.borderLine))),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    dataNotif['title'],
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    dataNotif['description'],
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Text(
                                  "$formattedDate, $times WIB",
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w200),
                                ),
                              ],
                            )),
                      ),
                    ]),
                  );
                },
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
