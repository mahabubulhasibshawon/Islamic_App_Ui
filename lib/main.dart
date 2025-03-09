import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:islamic_app_ui/screens/prayer_screen.dart';
import 'package:islamic_app_ui/screens/quran_screen.dart';
import 'package:islamic_app_ui/screens/prayer_time_screen.dart';
import 'package:islamic_app_ui/screens/surah_screen.dart';
import 'package:islamic_app_ui/screens/prayer_time_permission_screen.dart';
import 'package:islamic_app_ui/services/noti_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'prayer_reminder',
        channelName: 'Prayer Notifications',
        channelDescription: 'Reminders for prayer times',
        defaultColor: Colors.teal,
        importance: NotificationImportance.High,
        ledColor: Colors.white,
        soundSource: 'resource://raw/alarm',
      )
    ],
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: PrayerTimePermissionScreen(),
    );
  }
}