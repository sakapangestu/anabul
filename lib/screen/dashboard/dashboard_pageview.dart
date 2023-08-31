// import 'package:anabulhotel/helper/global_colors.dart';
// import 'package:anabulhotel/screen/condition/condition.dart';
import 'package:anabul/screen/dashboard/dashboard.dart';
import 'package:anabul/screen/history/history.dart';
// import 'package:anabulhotel/screen/user/user.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter/material.dart';

import '../../api/api_service.dart';
import '../../helper/global_colors.dart';
import '../condition/condition.dart';
import '../user/user.dart';

class DashboardPageView extends StatefulWidget {
  final int initialIndex;

  DashboardPageView({this.initialIndex = 0});

  @override
  _DashboardPageViewState createState() =>
      _DashboardPageViewState(initialIndex: initialIndex);
}

class _DashboardPageViewState extends State<DashboardPageView> {
  int _currentIndex = 0;
  _DashboardPageViewState({int initialIndex = 0}) {
    _currentIndex = initialIndex;
  }

  final List<Widget> _children = [
    const DashboardCustomer(),
    const HistoryScreen(),
    const Condition(),
    const User(),
  ];

  GlobalColors globalColors = GlobalColors();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: globalColors.bgOrange,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _currentIndex == 0
                    ? globalColors.bgOrangeDisabled
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _currentIndex == 0 ? Ionicons.home : Ionicons.home_outline,
                color: globalColors.bgOrange,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _currentIndex == 1
                    ? globalColors.bgOrangeDisabled
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _currentIndex == 1 ? Ionicons.reader : Ionicons.reader_outline,
                color: globalColors.bgOrange,
              ),
            ),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _currentIndex == 2
                    ? globalColors.bgOrangeDisabled
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _currentIndex == 2
                    ? Ionicons.fitness
                    : Ionicons.fitness_outline,
                color: globalColors.bgOrange,
              ),
            ),
            label: 'Aktivitas',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _currentIndex == 3
                    ? globalColors.bgOrangeDisabled
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _currentIndex == 3 ? Ionicons.person : Ionicons.person_outline,
                color: globalColors.bgOrange,
              ),
            ),
            label: 'User',
          ),
        ],
      ),
    );
  }
}
