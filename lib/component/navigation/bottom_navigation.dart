import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({Key? key,}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: BottomNavigationBar(
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
                color: _currentIndex == 0 ? Colors.redAccent.shade100 : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.home,
                color: _currentIndex == 0 ? Colors.redAccent : Colors.grey,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _currentIndex == 1 ? Colors.redAccent.shade100 : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.home,
                color: _currentIndex == 1 ? Colors.redAccent : Colors.grey,
              ),
            ),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _currentIndex == 2 ? Colors.redAccent.shade100 : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.home,
                color: _currentIndex == 2 ? Colors.redAccent : Colors.grey,
              ),
            ),
            label: 'Kondisi',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _currentIndex == 3 ? Colors.redAccent.shade100 : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.supervised_user_circle_rounded,
                color: _currentIndex == 3 ? Colors.redAccent : Colors.grey,
              ),
            ),
            label: 'User',
          ),
        ],
      ),
    );
  }
}
