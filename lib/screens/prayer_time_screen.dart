import 'package:flutter/material.dart';

import 'package:intl/intl.dart';


class PrayerTimesScreen extends StatefulWidget {
  @override
  _PrayerTimesScreenState createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedPrayerIndex = 0;
  DateTime today = DateTime.now(); // Get the current date

  final List<Map<String, dynamic>> prayerTimes = [
    {"name": "Fajr", "time": "5:41 AM", "icon": Icons.wb_sunny},
    {"name": "Subuh", "time": "5:41 AM", "icon": Icons.wb_cloudy},
    {"name": "Dzhuhur", "time": "1:30 PM", "icon": Icons.wb_sunny},
    {"name": "Asr", "time": "5:00 PM", "icon": Icons.cloud},
    {"name": "Maghrib", "time": "6:35 PM", "icon": Icons.nights_stay},
    {"name": "Isha", "time": "8:30 PM", "icon": Icons.nightlight_round},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 7,
      vsync: this,
      initialIndex: 0, // Start from today
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Date and Time",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {},
          ),
        ),
        body: Column(
          children: [
            // Date Selector with TabBar
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      DateFormat("d MMMM y").format(today), // Dynamic date
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    indicator: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.green)
                    ),
                    labelColor: Colors.green,
                    labelPadding: EdgeInsets.all(10),
                    unselectedLabelColor: Colors.black,
                    tabs: List.generate(
                      7,
                          (index) {
                        DateTime date = today.add(Duration(days: index));
                        return Tab(
                          height: 56,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  DateFormat('EEE').format(date), // Day name (Sat, Sun, Mon)
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  DateFormat('d').format(date), // Date number
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Prayer Times List
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: List.generate(
                  7,
                      (index) => ListView.builder(
                    itemCount: prayerTimes.length,
                    itemBuilder: (context, i) {
                      bool isSelected = i == selectedPrayerIndex;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPrayerIndex = i;
                          });
                        },
                        child: Container(
                          margin:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.green : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(prayerTimes[i]["icon"],
                                      color:
                                      isSelected ? Colors.white : Colors.black),
                                  SizedBox(width: 10),
                                  Text(
                                    prayerTimes[i]["name"],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: isSelected ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                prayerTimes[i]["time"],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
