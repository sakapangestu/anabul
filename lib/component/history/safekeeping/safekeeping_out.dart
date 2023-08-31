// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/component/history/safekeeping/safekeeping_out_list.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:anabul/component/history/safekeeping/safekeeping_out_list.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../../../api/api_service.dart';
import '../../../helper/global_colors.dart';

class SafekeepingOut extends StatefulWidget {
  const SafekeepingOut({Key? key, required this.status}) : super(key: key);
  final String status;

  @override
  State<SafekeepingOut> createState() => _SafekeepingOut();
}

class _SafekeepingOut extends State<SafekeepingOut> {
  GlobalColors globalColors = GlobalColors();

  @override
  Widget build(BuildContext context) {
    String defaultImage = BaseImage.getImageHotel();
    // print("aktive tab: ${widget.status}");
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: History.getHistorySafeKeeping(widget.status),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Map<String, dynamic>> historySafeKeepings = snapshot.data!;
          print("history accept isi apa: $historySafeKeepings");
          if (snapshot.hasData &&
              historySafeKeepings != null &&
              historySafeKeepings.length > 0) {
            return Container(
              child: SafeKeepingOutList(
                  dataOut: historySafeKeepings, status: widget.status),
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
