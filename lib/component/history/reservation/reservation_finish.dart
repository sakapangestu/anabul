import 'package:anabul/component/history/reservation/reservation_finish_list.dart';
// import 'package:anabulhotel/component/history/reservation/reservation_finish_list.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
// import 'package:anabulhotel/screen/tes/rating_tes.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../../../api/api_service.dart';
import '../../../helper/global_colors.dart';

class ReservationFinish extends StatefulWidget {
  const ReservationFinish({Key? key, required this.status}) : super(key: key);
  final String status;

  @override
  State<ReservationFinish> createState() => _ReservationFinish();
}

class _ReservationFinish extends State<ReservationFinish> {
  GlobalColors globalColors = GlobalColors();

  @override
  Widget build(BuildContext context) {
    String defaultImage = BaseImage.getImageHotel();
    // print("aktive tab: ${widget.status}");
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: History.getHistoryReservation(widget.status),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Map<String, dynamic>> historyFinish = snapshot.data!;
          if (snapshot.hasData &&
              historyFinish != null &&
              historyFinish.length > 0) {
            return Container(
              child: ReservationFinishList(
                  dataFinish: historyFinish, status: widget.status),
            );
          } else {
            return const Center(
                child: Text(
                    'Tidak Ada Data')); // Menampilkan pesan "Tidak ada data" jika daftar kosong atau tidak ada data
          }
          // print("history accept isi apa: $historyFinish");
          // return ListView.builder(
          //   itemCount: historyFinish.length,
          //   itemBuilder: (context, index) {
          //     final history = historyFinish[index];
          //     print("history tes data: $history");
          //     final idReservation = history['id_reservation'];
          //     final hotel = history['hotel'];
          //     ImageProvider imageProvider;
          //     if (hotel['image'] != null) {
          //       imageProvider = NetworkImage(defaultImage + hotel['image']);
          //     } else {
          //       imageProvider = const AssetImage("assets/splash/app_logo.png");
          //     }
          //     // print("data hotel: $hotel");
          //     return SingleChildScrollView(
          //       child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children:[
          //             Container(
          //                 width: MediaQuery.of(context).size.width,
          //                 padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
          //                 child: Container(
          //                   margin: const EdgeInsets.only(top:10, bottom: 10),
          //                   padding: const EdgeInsets.symmetric(horizontal: 20),
          //                   height: 200,
          //                   decoration: BoxDecoration(
          //                     color: Colors.white,
          //                     borderRadius: BorderRadius.circular(15),
          //                     boxShadow: [BoxShadow(
          //                       offset: const Offset(0, 7),
          //                       blurRadius: 10,
          //                       color: Colors.black.withOpacity(0.3),
          //                     )],
          //                   ),
          //                   child: Column(
          //                     children: [
          //                       Expanded(
          //                         flex: 2,
          //                         child: Container(
          //                           padding: const EdgeInsets.symmetric(vertical: 10),
          //                           decoration: BoxDecoration(
          //                             // color: Colors.blue,
          //                             border: Border(bottom: BorderSide(width: 1, color: globalColors.borderLine)),
          //                           ),
          //                           child: Row(
          //                             children: [
          //                               Expanded(
          //                                 flex: 1,
          //                                 child: Container(
          //                                   decoration: BoxDecoration(
          //                                     color: globalColors.bgOrangeDisabled,
          //                                     borderRadius: BorderRadius.circular(15),
          //                                     image: DecorationImage(
          //                                       image: imageProvider,
          //                                       fit: BoxFit.cover,
          //                                     ),
          //                                   ),
          //                                 ),
          //                               ),
          //                               Expanded(
          //                                 flex: 2,
          //                                 child: Container(
          //                                   padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          //                                   // color: Colors.white,
          //                                   child: Column(
          //                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //                                     crossAxisAlignment: CrossAxisAlignment.start,
          //                                     children: [
          //                                       Container(
          //                                         alignment: Alignment.centerLeft,
          //                                         width: MediaQuery.of(context).size.width,
          //                                         child: Text(
          //                                           hotel['name'],
          //                                           style: const TextStyle(
          //                                             fontSize: 18,
          //                                             fontWeight: FontWeight.bold,
          //                                           ),
          //                                         ),
          //                                       ),
          //                                       Container(
          //                                         // color: Colors.red,
          //                                         alignment: Alignment.centerLeft,
          //                                         width: MediaQuery.of(context).size.width,
          //                                         child: Row(
          //                                           crossAxisAlignment: CrossAxisAlignment.end,
          //                                           children: [
          //                                             Icon(Ionicons.location, size: 10.sp, color: globalColors.bgOrange,),
          //                                             const SizedBox(width: 8,),
          //                                             Text(
          //                                               hotel['city']['name'],
          //                                               style: const TextStyle(
          //                                                 fontSize: 12,
          //                                                 fontWeight: FontWeight.bold,
          //                                               ),
          //                                             ),
          //                                           ],
          //                                         ),
          //                                       ),
          //                                       Container(
          //                                         padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          //                                         decoration: BoxDecoration(
          //                                             color: globalColors.bgSuccess,
          //                                             borderRadius: BorderRadius.circular(100),
          //                                             border: Border.all(width: 0.5, color: globalColors.borderSuccess)
          //                                         ),
          //                                         child: Text(
          //                                           widget.status,
          //                                           style: TextStyle(
          //                                             fontWeight: FontWeight.bold,
          //                                             fontSize: 8.sp,
          //                                             color: globalColors.textSuccess,
          //                                           ),
          //                                         ),
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                       ),
          //                       Expanded(
          //                         flex: 1,
          //                         child: Container(
          //                           padding: const EdgeInsets.symmetric(vertical: 15),
          //                           child: Row(
          //                             mainAxisAlignment: MainAxisAlignment.center,
          //                             children: [
          //                               Expanded(
          //                                 child: GestureDetector(
          //                                   onTap: (){
          //                                     Navigator.push(
          //                                       context,
          //                                       MaterialPageRoute(builder: (context) => RatingTes(idReservation: idReservation,)),
          //                                     );
          //                                   },
          //                                   child: Container(
          //                                     decoration: BoxDecoration(
          //                                         color: globalColors.bgOrangeDisabled,
          //                                         borderRadius: BorderRadius.circular(100),
          //                                         border: Border.all(width: 0.5, color: globalColors.bgOrange)
          //                                     ),
          //                                     alignment: Alignment.center,
          //                                     padding: const EdgeInsets.all(10),
          //                                     child: Text(
          //                                       "Berikan Penilai",
          //                                       style: TextStyle(
          //                                         fontWeight: FontWeight.bold,
          //                                         fontSize: 12,
          //                                         color: globalColors.bgOrange,
          //                                       ),
          //                                     ),
          //                                   ),
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 )
          //             ),
          //           ]
          //       ),
          //     );
          //   },
          // );
        }
      },
    );
  }
}
