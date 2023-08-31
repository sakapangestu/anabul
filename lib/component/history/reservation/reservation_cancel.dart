import 'package:anabul/component/history/reservation/reservation_cancel_list.dart';
// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/component/history/reservation/reservation_cancel_list.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../../../api/api_service.dart';
import '../../../helper/global_colors.dart';

class ReservationCancel extends StatefulWidget {
  const ReservationCancel({Key? key, required this.status}) : super(key: key);
  final String status;

  @override
  State<ReservationCancel> createState() => _ReservationCancel();
}

class _ReservationCancel extends State<ReservationCancel> {
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
          List<Map<String, dynamic>> cancel = snapshot.data!;
          // print("history accept isi apa: $historyCancels");
          if (snapshot.hasData && cancel != null && cancel.length > 0) {
            return Container(
              child: ReservationCancelList(
                  dataCancel: cancel, status: widget.status),
            );
          } else {
            return const Center(
                child: Text(
                    'Tidak Ada Data')); // Menampilkan pesan "Tidak ada data" jika daftar kosong atau tidak ada data
          }
        }
      },
    );
  }
}
