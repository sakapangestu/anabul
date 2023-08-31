// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
// import 'package:anabulhotel/screen/staff/condition/condition_pet_create.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../../../../api/api_service.dart';
import '../../../../component/app_bar/app_bar_tittle.dart';
import '../../../../component/button/rectangle/rectangle_orange.dart';
import '../../../../helper/global_colors.dart';
import '../../../../helper/global_date.dart';
import '../../../tes/Maps.dart';
import '../condition_pet_create.dart';

class DetailConditionStaff extends StatefulWidget {
  const DetailConditionStaff(
      {Key? key,
      required this.pets,
      required this.age,
      required this.idCondition})
      : super(key: key);

  final Map pets;
  final String age;
  final String idCondition;
  // final dynamic data;

  @override
  State<DetailConditionStaff> createState() => _DetailConditionStaff();
}

class _DetailConditionStaff extends State<DetailConditionStaff> {
  GlobalColors globalColors = GlobalColors();

  @override
  void initState() {
    super.initState();
  }

  Expanded setConditionView() {
    // print("isi apa kondisi :${widget.idCondition}");
    Expanded box;
    Widget child = FutureBuilder<List<Map<String, dynamic>>>(
      future: TesSpecies.getPetConditions(widget.idCondition),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final petConditions = snapshot.data!;
          // print("pet isi pa: $petConditions");
          return ListView.builder(
            itemCount: petConditions.length,
            itemBuilder: (context, index) {
              final petCondition = petConditions[index];
              // print("object condition: $petCondition");
              final createdAt = petCondition['CreatedAt'];
              final condition = petCondition['condition'];
              // print("object tes: $tes");
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 10),
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: Colors.black, width: 0.5)),
                        // color: Colors.red,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                            const SizedBox(height: 10),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Ionicons.happy_sharp,
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
                              "${condition['name']} ${petCondition['description']}",
                              maxLines: 2,
                              textAlign: TextAlign.justify,
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

    box = Expanded(
      child: child,
    );

    return box;
  }

  @override
  Widget build(BuildContext context) {
    // print("isi apa: ${widget.idCondition}");
    // print("isi apa ya: ${widget.pets}");
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
            title: "Detail Aktifitas",
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
              child: SizedBox(
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
                                fit: BoxFit.cover)),
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
      bottomNavigationBar: Container(
        height: 9.h,
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: globalColors.borderLine, width: 0.5))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ConditionPetCreate(
                          idCondition: widget.idCondition,
                        )),
              );
            },
            child: const RectangleOrange(
              title: "Tambahkan Aktifitas",
            ),
          ),
        ),
      ),
    );
  }
}
