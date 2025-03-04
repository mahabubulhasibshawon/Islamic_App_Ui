import 'package:flutter/material.dart';

import '../widgets/menu_item.dart';
import '../widgets/prayer_time_tile.dart';
import '../widgets/trackerItem.dart';

class PrayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Image covering top 30%
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Image.asset(
              'assets/star_bg.png', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Section
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "As-salamu alaykum",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Mohammad Jabel",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "21:57",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // Prayer Times
                SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PrayerTimeTile("Fajr", "5:25"),
                    PrayerTimeTile("Dzuhr", "1:05"),
                    PrayerTimeTile("Asr", "4:45"),
                    PrayerTimeTile("Maghrib", "5:36"),
                    PrayerTimeTile("Isha", "7:45"),
                  ],
                ),

                // Quick Access Buttons
                SizedBox(height: 16),
                // Menu Grid
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 5,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: const [
                    MenuIcon(icon: Icons.menu_book, label: 'Quran'),
                    MenuIcon(icon: Icons.mosque, label: 'Hajj'),
                    MenuIcon(icon: Icons.calendar_today, label: 'Salah'),
                    MenuIcon(icon: Icons.location_on, label: 'Qibla'),
                    MenuIcon(icon: Icons.calendar_month, label: 'Calendar'),
                    MenuIcon(icon: Icons.favorite, label: 'Dua'),
                    MenuIcon(icon: Icons.health_and_safety, label: 'Health'),
                    MenuIcon(icon: Icons.star, label: 'Salah'),
                  ],
                ),
                // Last Read Card
                SizedBox(height: 16),
                Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green.shade50,
                  ),
                  child: Row(
                    children: [
                      Image.asset('assets/quran.png', height: 60),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Al-Fatiha',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text('Ayah No. 1'),
                        ],
                      ),
                    ],
                  ),
                ),
                // Prayer Tracker
                SizedBox(height: 16),
                Text(
                  "Prayer Tracker",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white70,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TrackerItem(prayer: 'Fajr', completed: true,),
                      TrackerItem(prayer: 'Dzuhr', completed: true,),
                      TrackerItem(prayer: 'Asr', completed: false,),
                      TrackerItem(prayer: 'Maghrib', completed: false,),
                      TrackerItem(prayer: 'Isha', completed: false,),
                    ],
                  ),
                ),

                // Daily Dua
                Text(
                  "Daily Dua",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Allahummaghfir lee thanbee kullahu...",
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

