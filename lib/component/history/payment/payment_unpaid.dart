import 'package:anabul/component/history/payment/payment_unpaid_list.dart';
// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/component/history/payment/payment_unpaid_list.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
// import 'package:anabulhotel/screen/reservation/reservation_bill.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../api/api_service.dart';
import '../../../helper/global_colors.dart';
import '../reservation/slidding/slidding_up_payment_bill.dart';

class PaymentUnpaid extends StatefulWidget {
  const PaymentUnpaid({Key? key, required this.status}) : super(key: key);
  final String status;

  @override
  State<PaymentUnpaid> createState() => _PaymentUnpaid();
}

class _PaymentUnpaid extends State<PaymentUnpaid> {
  GlobalColors globalColors = GlobalColors();

  @override
  Widget build(BuildContext context) {
    String defaultImage = BaseImage.getImageHotel();
    print("aktive tab: ${widget.status}");
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: History.getHistoryPayment(widget.status),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Map<String, dynamic>> historyPayments = snapshot.data!;
          // print("history accept isi apa: $historyPayments");
          if (snapshot.hasData &&
              historyPayments != null &&
              historyPayments.length > 0) {
            return Container(
              child: PaymentUnpaidList(
                  dataUnpaid: historyPayments, status: widget.status),
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
