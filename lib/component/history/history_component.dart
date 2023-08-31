// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../helper/global_colors.dart';

class HistoryComponent extends StatelessWidget {
  const HistoryComponent(
      {Key? key,
      required this.hotel,
      required this.imageProvider,
      required this.status})
      : super(key: key);
  final Map hotel;
  final ImageProvider imageProvider;
  final String status;

  Widget buildWidget() {
    GlobalColors globalColors = GlobalColors();
    if (status == "Proses" || status == "Belum Dibayar") {
      return Container(
        decoration: BoxDecoration(
          color: globalColors.bgWarning,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(width: 0.5, color: globalColors.bgWarning),
        ),
        child: Text(
          status,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 8.sp,
            color: globalColors.bgWarning,
          ),
        ),
      );
    } else if (status == "Diterima" ||
        status == "Selesai" ||
        status == "Masuk" ||
        status == "Dibayar") {
      return Container(
        decoration: BoxDecoration(
          color: globalColors.bgSuccess,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(width: 0.5, color: globalColors.bgSuccess),
        ),
        child: Text(
          status,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 8.sp,
            color: globalColors.bgSuccess,
          ),
        ),
      );
    } else if (status == "Ditolak" ||
        status == "Dibatalkan" ||
        status == "Keluar") {
      return Container(
        decoration: BoxDecoration(
          color: globalColors.bgDanger,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(width: 0.5, color: globalColors.bgDanger),
        ),
        child: Text(
          status,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 8.sp,
            color: globalColors.bgDanger,
          ),
        ),
      );
    } else {
      // Default widget jika tidak ada kondisi yang sesuai
      return Container(
        child: Text("Default Widget"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalColors globalColors = GlobalColors();
    return Expanded(
      flex: 2,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          // color: Colors.blue,
          border: Border(
              bottom: BorderSide(width: 1, color: globalColors.borderLine)),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: globalColors.bgOrangeDisabled,
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                // color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        hotel['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 16,
                            color: globalColors.bgOrange,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            hotel['address'],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text("text"),
                    buildWidget(),
                    Text("text"),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      decoration: () {
                        if (status == "Proses") {
                          return BoxDecoration(
                            color: globalColors.bgSuccess,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                width: 0.5, color: globalColors.borderSuccess),
                          );
                        } else if (status == "Diterima") {
                          return BoxDecoration(
                            color: globalColors.bgSuccess,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                width: 0.5, color: globalColors.borderSuccess),
                          );
                        }
                      }(),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 8.sp,
                          color: globalColors.textSuccess,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
