import 'package:flutter/material.dart';
import 'dart:async'; 
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:project_akhir1/login_page.dart';
import 'package:project_akhir1/main_screen.dart'; 
// note_page.dart tidak perlu diimport langsung di sini karena sudah diimport oleh main_screen.dart
// import 'package:project_akhir1/note_page.dart'; // TIDAK DIPERLUKAN DI SINI

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://iaraofinpyowiiiytsug.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlhcmFvZmlucHlvd2lpaXl0c3VnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU5MjE2MDEsImV4cCI6MjA2MTQ5NzYwMX0.qCIhdoKF8SRUIJlZ26op_IxpTkHMnvEXwGY2PMU_-h0',
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget { // HARUS STATEFUL UNTUK MENGELOLA AUTH STATE
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Ini adalah StreamSubscription untuk membersihkan listener saat widget di-dispose.
  late final StreamSubscription<AuthState> _authStateSubscription;

  @override
  void initState() {
    super.initState();
    // Mendengarkan perubahan status autentikasi dari Supabase
    _authStateSubscription = Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;

      // GUARD THE USE WITH A 'MOUNTED' CHECK
      if (!mounted) return;

      if (event == AuthChangeEvent.signedIn || event == AuthChangeEvent.initialSession) {
        if (session != null) {
          // Navigasi ke MainScreen dan hapus semua rute sebelumnya
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MainScreen()),
            (Route<dynamic> route) => false,
          );
        }
      } else if (event == AuthChangeEvent.signedOut) {
        // Navigasi ke LoginPage dan hapus semua rute sebelumnya
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (Route<dynamic> route) => false,
        );
      }
    });
  }

  @override
  void dispose() {
    _authStateSubscription.cancel(); // Batalkan langganan stream
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Catatan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Tentukan halaman awal berdasarkan sesi Supabase saat ini
      home: Supabase.instance.client.auth.currentSession != null  
          ? const MainScreen() // Jika ada sesi aktif
          : const LoginPage(), // Jika tidak ada sesi
    );
  }
}