import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:audioplayers/audioplayers.dart';


class PrayerTimePermissionScreen extends StatelessWidget {
  final List<Map<String, String>> prayerTimes = [
    {'name': 'ফজর', 'time': '4:58'},
    {'name': 'যোহর', 'time': '12:13'},
    {'name': 'আসর', 'time': '4:25'},
    {'name': 'মাগরিব', 'time': '6:03'},
    {'name': 'এশা', 'time': '7:21'},
  ];

  final AudioPlayer _audioPlayer = AudioPlayer();

  void playAlarm() async {
    await _audioPlayer.play(AssetSource('sounds/alarm.mp3'));
    await Future.delayed(Duration(seconds: 20));
    await _audioPlayer.stop();
  }

  void schedulePrayerNotification(String prayerName, String time) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'prayer_reminder',
        title: 'নামাজের সময়',
        body: '$prayerName এর সময় হয়েছে ($time)',
        notificationLayout: NotificationLayout.Default,
      ),
    );
    playAlarm();
  }

  void requestNotificationPermission(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'অনুমতি প্রয়োজন',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'অনুগ্রহ করে সেটিংস থেকে অ্যালার্মের অনুমতি দিন',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('বন্ধ করুন', style: TextStyle(color: Colors.white70)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {
                      AwesomeNotifications().requestPermissionToSendNotifications();
                      Navigator.pop(context);
                    },
                    child: Text('নিশ্চিত'),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('নামাজের সময়সূচী'), backgroundColor: Colors.black),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('৮ রমজান, ১৪৪৫ হিজরী', style: TextStyle(color: Colors.white70)),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('পরবর্তী সূর্যোদয়', style: TextStyle(color: Colors.white)),
                    Text('6:13', style: TextStyle(color: Colors.greenAccent)),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: prayerTimes.length,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         title: Text(prayerTimes[index]['name']!, style: TextStyle(color: Colors.white)),
          //         subtitle: Text(prayerTimes[index]['time']!, style: TextStyle(color: Colors.white70)),
          //         trailing: IconButton(
          //           icon: Icon(Icons.notifications_active, color: Colors.white54),
          //           onPressed: () => schedulePrayerNotification(
          //               prayerTimes[index]['name']!, prayerTimes[index]['time']!
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          Container(
            height: 200,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal ,
                  itemCount: prayerTimes.length,
                  itemBuilder: (context, index) => _buildPrayerTimeColumn(prayerTimes[index]['name']!,  prayerTimes[index]['time']!, IconButton(
                    icon: Icon(Icons.notifications_active, color: Colors.white54),
                    onPressed: () => schedulePrayerNotification(
                        prayerTimes[index]['name']!, prayerTimes[index]['time']!
                    ),
                  ),),)

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     _buildPrayerTimeColumn('ফজর', '৪:৫৮'),
              //     _buildDivider(),
              //     _buildPrayerTimeColumn('জোহর', '১২:১৩'),
              //     _buildDivider(),
              //     _buildPrayerTimeColumn('আসর', '৪:২৫'),
              //     _buildDivider(),
              //     _buildPrayerTimeColumn('মাগরিব', '৬:৩৬'),
              //     _buildDivider(),
              //     _buildPrayerTimeColumn('এশা', '৭:২১'),
              //   ],
              // ),
            ),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () => requestNotificationPermission(context),
            child: Text('লোকেশন অন করুন'),
          ),
          SizedBox(height: 50)
        ],
      ),
    );
  }
  Widget _buildPrayerTimeColumn(String name, String time, IconButton iconButton) {
    return Container(
      height: 100,
      width: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.wb_sunny_outlined,
                color: Colors.green,
                size: 20,
              ),
              const SizedBox(height: 8),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                time,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              iconButton
            ],
          ),
          _buildDivider()
        ],
      ),
    );
  }
  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 80,
      color: Colors.grey[800],
    );
  }
}
