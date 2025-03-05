import 'package:flutter/material.dart';
import 'package:islamic_app_ui/screens/prayer_screen.dart';
import 'package:islamic_app_ui/screens/quran_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: QuranScreen()
    );
  }
}
