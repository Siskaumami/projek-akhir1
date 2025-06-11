import 'package:flutter/material.dart';

class HealthPage extends StatelessWidget {
  const HealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50, // Latar belakang biru muda
      appBar: AppBar(
        title: const Text(
          "Health & Wellness",
          style: TextStyle(color: Colors.white), // Warna teks putih
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade700, // Warna AppBar biru tua
        elevation: 0, // Tanpa shadow
        // actions: [], // Menghapus ikon pengaturan di sini
      ),
      body: const Center(
        child: Text(
          "Konten untuk Kesehatan & Kesejahteraan",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}