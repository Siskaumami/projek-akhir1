import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:project_akhir1/note_page.dart';
import 'package:project_akhir1/login_page.dart';

void main() async {
  // Inisialisasi Flutter & Supabase
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://iaraofinpyowiiiytsug.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlhcmFvZmlucHlvd2lpaXl0c3VnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU5MjE2MDEsImV4cCI6MjA2MTQ5NzYwMX0.qCIhdoKF8SRUIJlZ26op_IxpTkHMnvEXwGY2PMU_-h0',
  );
  
  // Jalankan aplikasi dengan LoginPage sebagai halaman awal
  runApp(const MyApp());
}

// Widget untuk halaman login
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

// Widget untuk halaman catatan
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotePage(),
    );
  }
}
