import 'dart:async';

// import 'package:anabulhotel/component/button/rounded/rounded_orange.dart';
// import 'package:anabulhotel/component/button/rounded/rounded_orange_disabled.dart';
// import 'package:anabulhotel/component/onboarding/onboarding_item.dart';
// import 'package:anabulhotel/screen/login/login.dart';
import 'package:flutter/material.dart';

import '../../component/button/rounded/rounded_orange.dart';
import '../../component/button/rounded/rounded_orange_disabled.dart';
import '../../component/onboarding/onboarding_item.dart';
import '../login/login.dart';

class Onboarding extends StatefulWidget {
  @override
  _Onboarding createState() => _Onboarding();
}

class _Onboarding extends State<Onboarding> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_currentPage != 2) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _resetTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_currentPage != 2) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
              _resetTimer();
            },
            children: [
              // Halaman pertama
              OnboardingItem(
                imageAsset: 'assets/onboarding/hotel.jpg',
                title: 'Selamat Datang di Anabul Hotel',
                subtitle:
                    'Aplikasi Penginapan Hewan Peliharaan kami adalah tempat yang tepat bagi Anda yang ingin meninggalkan hewan peliharaan Anda ketika sedang pergi.',
              ),
              // Halaman kedua
              OnboardingItem(
                imageAsset: 'assets/onboarding/onboarding_2.jpeg',
                title: 'Kami Menyediakan Tempat yang Aman dan Nyaman',
                subtitle:
                    'Kami menyediakan tempat yang aman dan nyaman untuk hewan peliharaan Anda. Fasilitas yang kami sediakan dapat memenuhi kebutuhan hewan peliharaan Anda.',
              ),
              // Halaman ketiga
              OnboardingItem(
                imageAsset: 'assets/onboarding/onboarding_3.jpeg',
                title:
                    'Hewan Peliharaan Anda Akan Merasa Seperti di Rumah Sendiri',
                subtitle:
                    'Hewan peliharaan Anda akan merasa seperti di rumah sendiri ketika menginap di Penginapan Hewan Peliharaan kami. Dapatkan pengalaman menginap yang tidak terlupakan.',
              ),
            ],
          ),
          Positioned(
            bottom: 15,
            right: 30,
            left: 30,
            child: Column(
              children: [
                // Tombol Next
                if (_currentPage != 2)
                  GestureDetector(
                    onTap: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                      _timer?.cancel();
                    },
                    child: Container(
                      height: 50,
                      child: const RoundedOrange(
                        title: "Selanjutnya",
                      ),
                    ),
                    // child: Text('Next'),
                  ),
                const SizedBox(height: 8),
                // Tombol Skip
                if (_currentPage != 2)
                  GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        2,
                        duration: const Duration(milliseconds: 30),
                        curve: Curves.easeInOut,
                      );
                      _timer?.cancel();
                    },
                    child: Container(
                      height: 50,
                      child: const RoundedOrangeDisabled(
                        title: "Lewati",
                      ),
                    ),
                  ),
                // Tombol Mulai
                if (_currentPage == 2)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Container(
                      height: 50,
                      child: const RoundedOrange(
                        title: "Mulai",
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
