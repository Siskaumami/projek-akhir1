import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Pengguna"),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                    'https://via.placeholder.com/150'), // Ganti dengan URL gambar profil default atau dari aset
                backgroundColor: Colors.blueGrey,
              ),
              const SizedBox(height: 20),
              const Text(
                "Nama Pengguna", // Ganti dengan nama pengguna sebenarnya
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "email@example.com", // Ganti dengan email pengguna sebenarnya
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              // Tambahkan informasi lain di sini, misalnya:
              ListTile(
                leading: const Icon(Icons.info_outline, color: Colors.blue),
                title: const Text("Versi Aplikasi"),
                subtitle: const Text("1.0.0"),
              ),
              ListTile(
                leading: const Icon(Icons.privacy_tip_outlined, color: Colors.blue),
                title: const Text("Kebijakan Privasi"),
                onTap: () {
                  // Aksi ketika Kebijakan Privasi diklik
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Membuka Kebijakan Privasi...")),
                  );
                },
              ),
              // Kamu bisa menambahkan lebih banyak opsi di sini, seperti "Pengaturan"
            ],
          ),
        ),
      ),
    );
  }
}