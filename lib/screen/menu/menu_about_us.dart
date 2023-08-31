// import 'package:anabulhotel/api/api_service.dart';
// import 'package:anabulhotel/helper/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api/api_service.dart';
import '../../component/app_bar/app_bar_tittle.dart';
import '../../helper/global_colors.dart';

class MenuAboutUs extends StatefulWidget {
  const MenuAboutUs({super.key});

  @override
  _MenuAboutUsState createState() => _MenuAboutUsState();
}

class _MenuAboutUsState extends State<MenuAboutUs> {
  GlobalColors globalColors = GlobalColors();

  @override
  void initState() {
    super.initState();
  }

  void _launchWhatsApp() async {
    final url =
        'https://wa.me/6285872772318'; // Ganti dengan nomor telepon penerima yang dituju
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka WhatsApp.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
            title: "Tentang Anabul Hotel",
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 24, left: 24, top: 15),
          child: Column(
            children: [
              Container(
                height: 50,
                margin: const EdgeInsets.only(bottom: 25),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/splash/app_logos_horizontal.png"),
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "Selamat datang di Anabul Hotel rumah kedua untuk hewan peliharaan Anda!",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: Menu.getMenuAbout(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      if (snapshot.hasData) {
                        List<Map<String, dynamic>> data = snapshot.data!;
                        return Column(
                          children: List.generate(data.length, (index) {
                            final aboutData = data[index];
                            final description = aboutData['description'];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                description,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            );
                          }),
                        );
                      } else {
                        // Tidak ada data tagihan yang diterima
                        return const Text('Tidak ada data rating.');
                      }
                    }
                  },
                ),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Terima kasih telah mempercayakan hewan peliharaan Anda kepada Anabul Hotel - pilihan terbaik untuk liburan mereka!",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}
