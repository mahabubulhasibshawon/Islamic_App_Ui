// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotiService {
//   final notificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   bool _isInitialized = false;
//
//   bool get isInitialized => _isInitialized;
//
// //   initialize
//   Future<void> initNotification() async {
//     if (_isInitialized) return;
//
//     const initSettingsAndroid = AndroidInitializationSettings(
//         '@mipmap/ic_launcher');
//
//     //   init setttings
//     const initSettings = InitializationSettings(
//         android: initSettingsAndroid
//     );
//
//     await notificationsPlugin.initialize(initSettings);
//   }
//
// //   notificationsetup
//   NotificationDetails notificationDetails() {
//     return const NotificationDetails(
//         android: AndroidNotificationDetails(
//             'daily_channel_id', 'Daily Notificationion',
//             channelDescription: 'Daily notificaiton channel', importance: Importance.max, priority: Priority.high)
//     );
//   }
//
// //   show notifications
//   Future<void> showNotifications({
//     int id = 0,
//     String? title,
//     String? body,
// }) async {
//     return notificationsPlugin.show(id, title, body, NotificationDetails());
//   }
//
// }