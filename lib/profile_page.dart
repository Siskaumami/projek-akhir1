import 'package:flutter/material.dart';
// Membuat halaman profil dengan widget stateless karena tidak ada data yang berubah secara dinamis
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key}); // Constructor dengan key opsional untuk identifikasi widget

  // Fungsi utama untuk membangun tampilan halaman profil
  @override
  Widget build(BuildContext context) {
    return Scaffold( // fungsi Struktur dasar halaman
      appBar: AppBar( // fungsi Bagian atas halaman (judul dan latar)
        title: const Text("Profil Pengguna"), // fungsi Judul di AppBar
        backgroundColor: Colors.blue.shade700, // fungsi Warna latar AppBar
      ),
      body: Center( // fungsi Isi halaman ditaruh di tengah layar
        child: Padding( // fungsi Menambahkan padding di sekeliling isi
          padding: const EdgeInsets.all(20.0), // fungsi Jarak 20 pixel dari semua sisi
          child: Column( // fungsi Menyusun widget ke bawah secara vertikal
            mainAxisAlignment: MainAxisAlignment.center, // fungsi Posisi widget di tengah secara vertikal
            children: [
              const CircleAvatar( // fungsi Widget untuk menampilkan foto profil berbentuk lingkaran
                radius: 60, //fungsi  Ukuran lingkaran
                backgroundImage: NetworkImage(
                    'https://via.placeholder.com/150'), // fungsi URL gambar profil (sementara)
                backgroundColor: Colors.blueGrey, // fungsi Warna latar belakang jika gambar gagal dimuat
              ),
              const SizedBox(height: 20), // fungsi Jarak vertikal 20 pixel antar elemen
              const Text(
                "Nama Pengguna", //fungsi Nama pengguna (sementara)
                style: TextStyle(
                  fontSize: 24, // fungsi Ukuran huruf
                  fontWeight: FontWeight.bold, // fungsi Tebal
                  color: Colors.black87, // fungsi Warna teks
                ),
              ),
              const SizedBox(height: 10), // fungsi Jarak vertikal 10 pixel
              const Text(
                "email@example.com", // fungsi Email pengguna (sementara)
                style: TextStyle(
                  fontSize: 16, // fungsi Ukuran huruf
                  color: Colors.grey, // fungsi Warna teks abu-abu
                ),
              ),
              const SizedBox(height: 30), // fungsi Jarak vertikal 30 pixel

              // fungsi Informasi tambahan: versi aplikasi
              ListTile(
                leading: const Icon(Icons.info_outline, color: Colors.blue), // Ikon di kiri
                title: const Text("Versi Aplikasi"), // Judul item
                subtitle: const Text("1.0.0"), // Keterangan tambahan
              ),

              // fungsi Informasi tambahan: kebijakan privasi
              ListTile(
                leading: const Icon(Icons.privacy_tip_outlined, color: Colors.blue), // Ikon di kiri
                title: const Text("Kebijakan Privasi"), // Judul item
                onTap: () {
                  // Ketika diklik, munculkan pesan sementara (Snackbar)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Membuka Kebijakan Privasi...")),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
