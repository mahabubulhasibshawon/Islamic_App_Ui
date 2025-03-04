import 'package:flutter/material.dart';

class PrayerTimeTile extends StatelessWidget {
  final String prayer;
  final String time;
  const PrayerTimeTile(this.prayer, this.time, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Text(
          prayer,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        CircleAvatar(),
        Text(time, style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
