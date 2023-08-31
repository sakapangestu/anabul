import 'package:anabul/component/history/reservation/reservation_reject_list.dart';
// import 'package:anabulhotel/component/history/reservation/reservation_reject_list.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../../../api/api_service.dart';
import '../../../helper/global_colors.dart';

class ReservationReject extends StatefulWidget {
  const ReservationReject({Key? key, required this.status}) : super(key: key);
  final String status;

  @override
  State<ReservationReject> createState() => _ReservationReject();
}

class _ReservationReject extends State<ReservationReject> {
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
          List<Map<String, dynamic>> historyRejects = snapshot.data!;
          // print("history accept isi apa: $historyRejects");
          if (snapshot.hasData &&
              historyRejects != null &&
              historyRejects.length > 0) {
            return Container(
              child: ReservationRejectList(
                  dataReject: historyRejects, status: widget.status),
            );
          } else {
            return const Center(
                child: Text(
                    'Tidak ada data')); // Menampilkan pesan "Tidak ada data" jika daftar kosong atau tidak ada data
          }
        }
      },
    );
  }
}
