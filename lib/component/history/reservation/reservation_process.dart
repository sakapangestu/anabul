import 'package:anabul/component/history/reservation/reservation_process_list.dart';
// import 'package:anabulhotel/api/api_service.dart';
// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/component/history/reservation/reservation_process_list.dart';
// import 'package:anabulhotel/component/history/reservation/slidding/slidding_up_ticket_reservation.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
// import 'package:anabulhotel/screen/reservation/reservation_ticket.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../api/api_service.dart';
import '../../../helper/global_colors.dart';

class ReservationProcess extends StatefulWidget {
  const ReservationProcess({Key? key, required this.status}) : super(key: key);
  final String status;

  @override
  State<ReservationProcess> createState() => _ReservationProcess();
}

class _ReservationProcess extends State<ReservationProcess> {
  GlobalColors globalColors = GlobalColors();

  @override
  Widget build(BuildContext context) {
    String defaultImage = BaseImage.getImageHotel();
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: History.getHistoryReservation(widget.status),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Map<String, dynamic>> historyProcesses = snapshot.data!;
          print("pet isi pa: $historyProcesses");
          if (snapshot.hasData &&
              historyProcesses != null &&
              historyProcesses.isNotEmpty) {
            return Container(
              child: ReservationProcessList(
                  dataProcess: historyProcesses, status: widget.status),
            );
          } else {
            return const Center(
                child: Text(
                    'Tidak Ada Data')); // Menampilkan pesan "Tidak ada data" jika daftar kosong atau tidak ada data
          }
        }
        // } else {
        //   return const Center(child: Text('No data available'));
        // }
      },
    );
  }
}
