// import 'package:anabulhotel/screen/dashboard/dashboard_staff.dart';
// import 'package:anabulhotel/screen/staff/condition/condition_staff.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../helper/global_colors.dart';
import '../staff/condition/condition_staff.dart';
import '../staff/user_staff.dart';
import 'dashboard_staff.dart';

class DashboardPageViewStaff extends StatefulWidget {
  final int initialIndex;

  const DashboardPageViewStaff({super.key, this.initialIndex = 0});

  @override
  _DashboardPageViewStaffState createState() =>
      _DashboardPageViewStaffState(initialIndex: initialIndex);
}

class _DashboardPageViewStaffState extends State<DashboardPageViewStaff> {
  int _currentIndex = 0;
  _DashboardPageViewStaffState({int initialIndex = 0}) {
    _currentIndex = initialIndex;
  }
  GlobalColors globalColors = GlobalColors();
  final List<Widget> _children = [
    const DashboardStaff(),
    const ConditionStaff(),
    const UserStaff(),
  ];

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
        selectedItemColor: Colors.red,
        showSelectedLabels: true,
        showUnselectedLabels: false,
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
                _currentIndex == 1
                    ? Ionicons.fitness
                    : Ionicons.fitness_outline,
                color: globalColors.bgOrange,
              ),
            ),
            label: 'Aktifitas',
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
                _currentIndex == 2 ? Ionicons.person : Ionicons.person_outline,
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
