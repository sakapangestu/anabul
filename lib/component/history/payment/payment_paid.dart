import 'package:anabul/component/history/payment/payment_paid_list.dart';
// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/component/history/payment/payment_paid_list.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../../../api/api_service.dart';
import '../../../helper/global_colors.dart';
import '../../../screen/reservation/reservation_bill.dart';

class PaymentPaid extends StatefulWidget {
  const PaymentPaid({Key? key, required this.status}) : super(key: key);
  final String status;

  @override
  State<PaymentPaid> createState() => _PaymentPaid();
}

class _PaymentPaid extends State<PaymentPaid> {
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
              child: PaymentPaidList(
                  dataPaid: historyPayments, status: widget.status),
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
