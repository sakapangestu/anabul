import 'dart:ffi';

// import 'package:anabulhotel/component/app_bar/app_bar_tittle.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sizer/sizer.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../helper/global_colors.dart';

class HotelPetMaps extends StatefulWidget {
  const HotelPetMaps({Key? key, required this.hotels}) : super(key: key);
  final Map hotels;

  @override
  State<HotelPetMaps> createState() => _HotelPetMaps();
}

class _HotelPetMaps extends State<HotelPetMaps> {
  GlobalColors globalColors = GlobalColors();

  void _launchURL() async {
    final String maps = widget.hotels['map_link'];
    final Uri url = Uri.parse(maps.toString());
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    double lat = double.parse(widget.hotels['latitude'].toString());
    double long = double.parse(widget.hotels['longitude'].toString());
    LatLng location = LatLng(lat, long);
    return SizedBox(
      height: 250,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Lokasi",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.red),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.red),
                  child: FlutterMap(
                    options: MapOptions(
                      center: location,
                      zoom: 12.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: const ['a', 'b', 'c'],
                        userAgentPackageName: 'com.example.app',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                              width: 100.0,
                              height: 100.0,
                              point: location,
                              builder: (ctx) => const Icon(
                                    Icons.location_on_rounded,
                                    color: Colors.red,
                                    size: 30,
                                  )),
                        ],
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: _launchURL,
                      child: Container(
                        margin: const EdgeInsets.only(
                            right: 65, left: 65, bottom: 5),
                        alignment: Alignment.bottomCenter,
                        height: 50,
                        decoration: BoxDecoration(
                            color: globalColors.bgOrangeDisabled,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                width: 0.5, color: globalColors.bgOrange)),
                        child: Center(
                          child: Text(
                            'Lihat Lokasi di Maps',
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: globalColors.bgOrange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
