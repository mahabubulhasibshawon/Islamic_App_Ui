import 'package:flutter/material.dart';

class QuranScreen extends StatefulWidget {
  @override
  _QuranScreenState createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: Text(
          'Al-Quran',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.bookmark_border, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _lastReadCard('Al-Baqarah (2)', 'Last read'),
                _lastReadCard('Al-Ma\'idah', 'Last played'),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            indicator: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            tabs: [
              _tabItem('Surah'),
              _tabItem('Juzz'),
              _tabItem('Hadith'),
              _tabItem('Doa'),
              _tabItem('Page'),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: surahList.length,
              itemBuilder: (context, index) {
                final surah = surahList[index];
                return _surahItem(surah['number'], surah['name'], surah['details'], surah['arabic']);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _lastReadCard(String title, String subtitle) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabItem(String title) {
    return Tab(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Text(title),
      ),
    );
  }

  Widget _surahItem(int number, String name, String details, String arabic) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(number.toString(), style: TextStyle(color: Colors.blue)),
        ),
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(details, style: TextStyle(color: Colors.grey)),
        trailing: Text(
          arabic,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

  Widget _buildTafsirContent(String title, String content) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(
            "وَمَا أَنْزَلْنَا عَلَيْكَ الْكِتَابَ إِلَّا لِتُبَيِّنَ لَهُمُ الَّذِي اخْتَلَفُوا فِيهِ",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "QuranFont"),
            textAlign: TextAlign.right,
          ),
          SizedBox(height: 10),
          Text(content, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> surahList = [
  {'number': 1, 'name': 'Al-Fatihah', 'details': '7 Verses | Meccan', 'arabic': 'الفاتحة'},
  {'number': 2, 'name': 'Al-Baqarah', 'details': '286 Verses | Medinan', 'arabic': 'البقرة'},
  {'number': 3, 'name': 'Al-Imran', 'details': '200 Verses | Medinan', 'arabic': 'آل عمران'},
  {'number': 4, 'name': 'An-Nisa', 'details': '176 Verses | Medinan', 'arabic': 'النساء'},
  {'number': 5, 'name': 'Al-Ma\'idah', 'details': '120 Verses | Medinan', 'arabic': 'المائدة'},
  {'number': 6, 'name': 'Al-Anfal', 'details': '75 Verses | Medinan', 'arabic': 'الأنفال'},
  {'number': 7, 'name': 'Al-Hujarat', 'details': '18 Verses | Medinan', 'arabic': 'الحجرات'},
];
