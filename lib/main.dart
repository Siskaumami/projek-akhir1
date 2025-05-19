import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:project_akhir1/note_page.dart';

void main() async {
  //supabase setup
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://iaraofinpyowiiiytsug.supabase.co',
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlhcmFvZmlucHlvd2lpaXl0c3VnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU5MjE2MDEsImV4cCI6MjA2MTQ5NzYwMX0.qCIhdoKF8SRUIJlZ26op_IxpTkHMnvEXwGY2PMU_-h0");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotePage(),
    ); //matetrial app
  }
}
