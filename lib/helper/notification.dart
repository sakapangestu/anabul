// import 'package:firebase_messaging/firebase_messaging.dart';
//
// class NotificationHelper {
//
//   static Future<void> sendNotification() async {
//     try {
//       // Dapatkan token perangkat pengguna yang akan menerima notifikasi
//       String? token = await FirebaseMessaging.instance.getToken();
//
//       // Kirim notifikasi menggunakan token perangkat
//       await FirebaseMessaging.instance.send(
//         // Konstruksi payload notifikasi
//         RemoteMessage(
//           data: {
//             'title': 'Judul Notifikasi',
//             'body': 'Isi notifikasi',
//           },
//           token: token,
//         ),
//       );
//
//       print('Notifikasi berhasil dikirim');
//     } catch (e) {
//       print('Gagal mengirim notifikasi: $e');
//     }
//   }
// }