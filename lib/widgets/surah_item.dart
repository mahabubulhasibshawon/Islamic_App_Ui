import 'package:flutter/material.dart';
import '../models/surah_model.dart';

class SurahItem extends StatelessWidget {
  final Surah surah;

  const SurahItem({required this.surah});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(surah.number.toString(), style: TextStyle(color: Colors.blue)),
        ),
        title: Text(surah.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(surah.details, style: TextStyle(color: Colors.grey)),
        trailing: Text(surah.arabic, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        onTap: () => _showTafsirBottomSheet(context, surah.name, surah.arabic, surah.tafsir ?? '', surah.ayat1 ?? ''),
        // onTap: () => _showSurahBottomSheet(context, surah),
      ),
    );
  }
  void _showTafsirBottomSheet(BuildContext context, String surahName, String arabicText, String tafsir, String ayat1) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Drag handle
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 10),

              // Title
              Text(
                surahName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 10),

              // Quranic Arabic Text
              Text(
                arabicText,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: "QuranFont"),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 10),

              // Tafsir Tabs
              DefaultTabController(
                length: 3,
                child: Expanded(
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: Colors.green,
                        unselectedLabelColor: Colors.black,
                        indicatorColor: Colors.green,
                        tabs: [
                          Tab(text: "Tafsir Ibn Kathir"),
                          Tab(text: "Ma'ariful-Quran"),
                          Tab(text: "Tazkirul Quran"),
                        ],
                      ),
                      SizedBox(height: 10),

                      // Tafsir Content
                      Expanded(
                        child: TabBarView(
                          children: [
                            _buildTafsirContent("Tafsir Ibn Kathir", "This is the tafsir of $surahName.", ayat1, tafsir),
                            _buildTafsirContent("Ma'ariful-Quran", "Detailed explanation of $surahName.", ayat1, tafsir),
                            _buildTafsirContent("Tazkirul Quran", "Context and meaning of $surahName.", ayat1,tafsir),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  Widget _buildTafsirContent(String title, String content, String ayat1, String tafsir) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(content, style: TextStyle(fontSize: 16)),
          Container(
            height: 100,
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(ayat1, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          Text(tafsir, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
