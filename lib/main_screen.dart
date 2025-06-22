import 'package:flutter/material.dart';
import 'package:project_akhir1/note_page.dart'; // Halaman Notifikasi (sekarang NotePage)
import 'package:project_akhir1/today_page.dart'; // Halaman Today
import 'package:project_akhir1/track_page.dart'; // Halaman Track
import 'package:project_akhir1/health_page.dart'; // Halaman Health

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 3; // Index default untuk Notifications (sesuai gambar)

  // Daftar halaman yang akan ditampilkan
  static final List<Widget> _widgetOptions = <Widget>[
    const TodayPage(),
    const TrackPage(),
    const HealthPage(),
    const NotePage(), // Halaman Notifikasi adalah NotePage
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex), // Menampilkan halaman sesuai index yang dipilih
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes), // atau Icons.timeline, Icons.bar_chart
            label: 'Track',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border), // atau Icons.favorite, Icons.health_and_safety
            label: 'Health',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue.shade700, // Warna ikon/label yang dipilih
        unselectedItemColor: Colors.grey, // Warna ikon/label yang tidak dipilih
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Penting agar semua label terlihat jika item banyak
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
//mainscreen adalah halaman utama yang menampilkan navigasi ke Today, Track, Health, dan Notifications (NotePage).
// Halaman ini menggunakan BottomNavigationBar untuk navigasi antar halaman.