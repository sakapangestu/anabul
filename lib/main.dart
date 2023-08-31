import 'package:anabul/provider/app_provider.dart';
import 'package:anabul/screen/condition/condition.dart';
import 'package:anabul/screen/dashboard/dashboard.dart';
import 'package:anabul/screen/dashboard/dashboard_pageview_staff.dart';
import 'package:anabul/screen/forgot/forgot_email.dart';
import 'package:anabul/screen/history/history.dart';
import 'package:anabul/screen/hotel_pet/hotel_search.dart';
import 'package:anabul/screen/intro/onboarding.dart';
import 'package:anabul/screen/login/login.dart';
import 'package:anabul/screen/login/signup.dart';
import 'package:anabul/screen/menu/menu_about_us.dart';
import 'package:anabul/screen/menu/menu_help.dart';
import 'package:anabul/screen/menu/menu_security.dart';
import 'package:anabul/screen/notification/notification.dart';
import 'package:anabul/screen/pet/pet.dart';
import 'package:anabul/screen/splash/splash.dart';
// import 'package:anabul/screen/staff/condition/condition_pet_create.dart';
import 'package:anabul/screen/tes/nested_tes.dart';
import 'package:anabul/screen/tes/tes.dart';
import 'package:anabul/screen/user/detail/detail_user.dart';
import 'package:anabul/screen/user/user.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:anabulhotel/provider/app_provider.dart';
// import 'package:anabulhotel/screen/dashboard/dashboard_pageview_staff.dart';
// import 'package:anabulhotel/screen/menu/menu_about_us.dart';
// import 'package:anabulhotel/screen/menu/menu_help.dart';
// import 'package:anabulhotel/screen/menu/menu_security.dart';
// import 'package:anabulhotel/screen/tes/Maps.dart';
// import 'package:anabulhotel/screen/hotel_pet/hotel_search.dart';
// import 'package:anabulhotel/screen/tes/nested_tes.dart';
// import 'package:anabulhotel/screen/tes/tes.dart';
// import 'package:anabulhotel/screen/condition/condition.dart';
// import 'package:anabulhotel/screen/dashboard/dashboard.dart';
// import 'package:anabulhotel/screen/forgot/forgot_email.dart';
// import 'package:anabulhotel/screen/history/history.dart';
// import 'package:anabulhotel/screen/intro/onboarding.dart';
// import 'package:anabulhotel/screen/login/login.dart';
// import 'package:anabulhotel/screen/login/signup.dart';
// import 'package:anabulhotel/screen/notification/notification.dart';
// import 'package:anabulhotel/screen/pet/pet.dart';
// import 'package:anabulhotel/screen/splash/splash.dart';
// import 'package:anabulhotel/screen/user/detail/detail_user.dart';
// import 'package:anabulhotel/screen/user/user.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'api/api_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onMessage.listen((event) {
    print("success");
  });

  FirebaseMessaging.onMessage.listen((event) {
    //   // if (event.data["category"] != null) {
    //   //   if (event.data["category"] == "tagihan") {
    //   //     navigatorKey.currentContext
    //   //         ?.read<AppProvider>()
    //   //         .setAllowancePaymentDetails({
    //   //       "transaction_id": event.data["transaction_id"],
    //   //       "invoice_id": event.data["invoice_id"],
    //   //       "bank_name": event.data["bank_name"],
    //   //       "bank_image": event.data["bank_image"],
    //   //       "account_name": event.data["account_name"],
    //   //       "account_number": event.data["account_number"],
    //   //       "amount": event.data["amount"],
    //   //       "due_date": event.data["due_date"],
    //   //       "nominal": event.data["nominal"],
    //   //       "unique_code": event.data["unique_code"],
    //   //       "category": event.data["category"],
    //   //       "simulate_payment": event.data["simulatePaymentURL"]
    //   //     });
    //   //   }
    //   // }
  });
  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

void _handleMessage(RemoteMessage message) {
  navigatorKey.currentState?.pushNamed("/dashboardPageview");
  // Logika penanganan notifikasi saat aplikasi terbuka dari latar belakang
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Logika penanganan notifikasi saat aplikasi berjalan di latar belakang
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    initializeFirebaseMessaging();
  }

  void initializeFirebaseMessaging() {
    // FirebaseMessaging.instance.getToken()
    _firebaseMessaging.getToken().then((token) {
      print("Token: $token");
      // Kirim token ke server backend Anda untuk menghubungkannya dengan peran pelanggan.
    }).catchError((e) {
      print("Error getting token: $e");
    });

    _firebaseMessaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print("Received message: ${message.notification?.title}");
    //   // Tampilkan notifikasi di foreground
    //   showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //       title: Text("New Message"),
    //       content: Text(message.notification?.body ?? ''),
    //       actions: [
    //         TextButton(
    //           child: Text("Close"),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //       ],
    //     ),
    //   );
    // });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Message opened by user");
      // Tampilkan notifikasi di background saat aplikasi sudah terbuka
      // Navigasi ke layar yang sesuai berdasarkan pesan yang diterima.
    });
  }

  final routes = <String, WidgetBuilder>{
    "/login": (BuildContext context) => LoginScreen(),
    "/signup": (BuildContext context) => SignupScreen(),
    "/forgotPassword": (BuildContext context) => ForgotEmail(),
    "/dashboard": (BuildContext context) => const DashboardCustomer(),
    "/intro": (BuildContext context) => Onboarding(),
    "/notifications": (BuildContext context) => const NotificationScreen(),
    "/condition": (BuildContext context) => const Condition(),
    "/history": (BuildContext context) => const HistoryScreen(),
    "/profile": (BuildContext context) => const User(),
    "/editProfile": (BuildContext context) => const DetailUser(),
    "/pet": (BuildContext context) => const PetSreen(),
    "/tes": (BuildContext context) => Tes(),
    "/searchHotel": (BuildContext context) => const HotelSearch(),
    // "/maps": (BuildContext context) => const ConditionPetTesCreate(),
    "/staff": (BuildContext context) => const DashboardPageViewStaff(),
    "/testestes": (BuildContext context) => const HotelSearchTes(),
    "/menuHelp": (BuildContext context) => const MenuHelp(),
    "/menuAboutUs": (BuildContext context) => const MenuAboutUs(),
    "/menuSecurity": (BuildContext context) => MenuSecurity(),
  };

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create: (context) => AppProvider(),
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            title: "Anabul Hotel Management System",
            debugShowMaterialGrid: false,
            debugShowCheckedModeBanner: false,
            // useInheritedMediaQuery: true,
            theme: ThemeData(
              primaryColor: Colors.black,
              fontFamily: "Inter",
            ),
            routes: routes,
            // home: SplashScreen(),
            home: SplashScreen(),
            navigatorKey: navigatorKey,
          );
        },
      ),
    );
  }
}
