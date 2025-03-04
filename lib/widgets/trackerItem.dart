import 'package:flutter/material.dart';

class TrackerItem extends StatelessWidget {
  final String prayer;
  final bool completed;
  const TrackerItem({super.key, required this.prayer, required this.completed});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Icon(
          completed ? Icons.check_circle : Icons.radio_button_unchecked,
          color: completed ? Colors.green : Colors.grey,
        ),
        SizedBox(height: 4),
        Text(prayer, style: TextStyle(fontSize: 12, color: Colors.black)),
      ],
    );
  }
}
