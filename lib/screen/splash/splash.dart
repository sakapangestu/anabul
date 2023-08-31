import 'dart:async';
import 'package:flutter/material.dart';

import '../../helper/session.dart';
import '../dashboard/dashboard_pageview.dart';
import '../dashboard/dashboard_pageview_staff.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();

}

class InitState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  startTimer() async {
    var durtion = Duration (seconds: 5);
    return new Timer(durtion, loginRoute);
  }

  // loginRoute() async {
  //   Map? session = await SessionManager.getData();
  //   if (session != null) {
  //     Navigator.pushNamed(context, '/dashboardPageView');
  //   } else {
  //     Navigator.pushNamed(context, '/intro');
  //   }
  // }

  loginRoute() async {
    Map? session = await SessionManager.getData();
    if (session != null) {
      String role = session['data']['role']; // Mendapatkan nilai peran dari sesi
      print(role);
      if (role == 'Customer') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardPageView()),
        );
      } else if (role == 'Staff'){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardPageViewStaff()),
        );// Ganti '/dashboardStaff' dengan rute yang sesuai untuk dashboard staff
      }
    } else {
      Navigator.pushNamed(context, '/intro');
    }
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget () {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/background/splash-background.png"),
                  fit: BoxFit.cover,
                )
            ),
          ),
          Center(
            child: Container(
              child: Image.asset("assets/splash/app_logos.png", scale: 6,)
            ),
          )
        ],
      ),
    );
  }
}
