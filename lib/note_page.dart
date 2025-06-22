import 'package:flutter/material.dart';
// fungsi Membuat widget NotePage sebagai halaman stateful (karena notifikasi bisa berubah statusnya)
class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState(); // fungsi Menghubungkan widget dengan state-nya
}

// fungsi State dari NotePage
class _NotePageState extends State<NotePage> {
  // fungsi Daftar notifikasi berupa list Map yang berisi data notifikasi
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': 'notif1', // ID notifikasi 
      'isRead': false, // Status belum dibaca
      'title': 'Reminder!', // fungsi Judul notifikasi
      'body': 'Doctor appointment today at 6:30pm, need to pick up files on the way.', // fungsi Isi notifikasi
      'time': '23 min', // Waktu notifikasi
      'icon': Icons.calendar_today, // Ikon yang merepresentasikan notifikasi
      'actionText': 'Mark as done - Update', // Teks untuk tombol aksi
      'onAction': () {
        // Fungsi ketika aksi ditekan
        print('Aksi: Mark as done - Update for notif1');
      },
    },
    {
      'id': 'notif2',
      'isRead': false,
      'title': 'Your weekly health tip is ready!',
      'body': "We've prepared your weekly health tip to help you customize your mood.",
      'time': '2 hr',
      'icon': Icons.health_and_safety,
      'actionText': 'Open weekly tips',
      'onAction': () {
        print('Aksi: Open weekly tips for notif2');
      },
    },
    {
      'id': 'notif3',
      'isRead': false,
      'title': "It's time to enter your weight",
      'body': "Track your weight and help us customize your weekly health tip for you.",
      'time': '1 dy',
      'icon': Icons.monitor_weight,
      'actionText': 'Add weight entry',
      'onAction': () {
        print('Aksi: Add weight entry for notif3');
      },
    },
    {
      'id': 'notif4',
      'isRead': true, // Sudah dibaca
      'title': 'Moment reminder!',
      'body': 'Doctor appointment today at 6:30pm, need to pick up files on the way.',
      'time': '1 wk',
      'icon': Icons.calendar_today,
      'actionText': 'View - Update',
      'onAction': () {
        print('Aksi: View - Update for notif4');
      },
    },
    {
      'id': 'notif5',
      'isRead': true,
      'title': "It's time to enter your weight",
      'body': "We've prepared your weekly health tip to help you improve your mood.",
      'time': '1 yr',
      'icon': Icons.monitor_weight,
      'actionText': 'Add weight entry',
      'onAction': () {
        print('Aksi: Add weight entry for notif5');
      },
    },
  ];

  // Fungsi untuk toggle status isRead (bisa dipakai kalau mau klik untuk tandai dibaca/belum)
  void _toggleReadStatus(String id) {
    setState(() {
      final index = _notifications.indexWhere((notif) => notif['id'] == id);
      if (index != -1) {
        _notifications[index]['isRead'] = !_notifications[index]['isRead'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50, // Latar belakang biru muda
      appBar: AppBar(
        title: const Text(
          "Notifications", // Judul app bar
          style: TextStyle(color: Colors.white), // Warna teks putih
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade700, // Warna latar app bar
        elevation: 0, // Tanpa bayangan
      ),
      // Jika list notifikasi kosong, tampilkan ilustrasi kosong
      body: _notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack( // Membuat ikon notifikasi tidur
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue.shade100,
                        ),
                        child: Icon(
                          Icons.notifications,
                          size: 50,
                          color: Colors.blue.shade800,
                        ),
                      ),
                      Positioned(
                        top: 15,
                        right: 15,
                        child: Text(
                          'Z\nZ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "You're all caught up", // Pesan jika tidak ada notifikasi
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      "Come back later for Reminders, health tips, moments and weight notifications",
                      style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated( // Jika ada notifikasi, tampilkan dalam list
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              itemCount: _notifications.length, // Jumlah notifikasi
              separatorBuilder: (context, index) => const SizedBox(height: 16), // Spasi antar item
              itemBuilder: (context, index) {
                final notification = _notifications[index]; // Ambil notifikasi ke-i
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Indikator lingkaran kecil di kiri
                        Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.only(top: 6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: notification['isRead']
                                ? Colors.lightBlue.shade300 // Jika dibaca
                                : Colors.blue.shade700, // Jika belum dibaca
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Isi notifikasi
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Baris judul dan waktu
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    notification['title']!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    notification['time']!,
                                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              // Isi pesan
                              Text(
                                notification['body']!,
                                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis, // Potong teks jika terlalu panjang
                              ),
                              const SizedBox(height: 8),
                              // Tindakan yang bisa dilakukan dari notifikasi
                              if (notification['actionText'] != null)
                                GestureDetector(
                                  onTap: notification['onAction'], // Jalankan fungsi saat ditekan
                                  child: Text(
                                    notification['actionText']!,
                                    style: TextStyle(
                                      color: Colors.blue.shade700,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
    );
  }
}
