import 'package:flutter/material.dart';

class HealthPage extends StatelessWidget {
  const HealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kesehatan"),
        backgroundColor: Colors.blue.shade700,
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