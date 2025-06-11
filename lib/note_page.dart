import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  // Struktur data notifikasi yang lebih kaya sesuai desain
  // Tambahan: 'isRead' untuk indikator status
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': 'notif1',
      'isRead': false, // Notifikasi baru/belum dibaca
      'title': 'Reminder!',
      'body': 'Doctor appointment today at 6:30pm, need to pick up files on the way.',
      'time': '23 min',
      'icon': Icons.calendar_today, // Contoh ikon untuk reminder
      'actionText': 'Mark as done - Update',
      'onAction': () {
        // Implementasi aksi: Tandai selesai atau update
        print('Aksi: Mark as done - Update for notif1');
      },
    },
    {
      'id': 'notif2',
      'isRead': false,
      'title': 'Your weekly health tip is ready!',
      'body': "We've prepared your weekly health tip to help you customize your mood.",
      'time': '2 hr',
      'icon': Icons.health_and_safety, // Contoh ikon untuk health tip
      'actionText': 'Open weekly tips',
      'onAction': () {
        // Implementasi aksi: Buka halaman tips kesehatan
        print('Aksi: Open weekly tips for notif2');
      },
    },
    {
      'id': 'notif3',
      'isRead': false,
      'title': "It's time to enter your weight",
      'body': "Track your weight and help us customize your weekly health tip for you.",
      'time': '1 dy',
      'icon': Icons.monitor_weight, // Contoh ikon untuk weight
      'actionText': 'Add weight entry',
      'onAction': () {
        // Implementasi aksi: Buka halaman entri berat badan
        print('Aksi: Add weight entry for notif3');
      },
    },
    {
      'id': 'notif4',
      'isRead': true, // Notifikasi sudah dibaca
      'title': 'Moment reminder!',
      'body': 'Doctor appointment today at 6:30pm, need to pick up files on the way.',
      'time': '1 wk',
      'icon': Icons.calendar_today, // Contoh ikon untuk reminder
      'actionText': 'View - Update', // Aksi bisa berbeda jika sudah dibaca
      'onAction': () {
        // Implementasi aksi
        print('Aksi: View - Update for notif4');
      },
    },
    {
      'id': 'notif5',
      'isRead': true, // Notifikasi sudah dibaca
      'title': "It's time to enter your weight",
      'body': "We've prepared your weekly health tip to help you improve your mood.",
      'time': '1 yr',
      'icon': Icons.monitor_weight, // Contoh ikon untuk weight
      'actionText': 'Add weight entry',
      'onAction': () {
        // Implementasi aksi
        print('Aksi: Add weight entry for notif5');
      },
    },
  ];

  // Fungsi untuk mengubah status 'isRead' (opsional, untuk simulasi)
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
          "Notifications",
          style: TextStyle(color: Colors.white), // Warna teks putih
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade700, // Warna AppBar biru tua
        elevation: 0, // Tanpa shadow
        // actions: [], // Menghapus ikon pengaturan di sini
      ),
      body: _notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ikon bell tidur
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue.shade100, // Lingkaran lebih kebiruan
                        ),
                        child: Icon(
                          Icons.notifications,
                          size: 50,
                          color: Colors.blue.shade800, // Warna ikon bell
                        ),
                      ),
                      Positioned(
                        top: 15,
                        right: 15,
                        child: Text(
                          'Z\nZ', // Zz di atas bell
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade400, // Warna Zz
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "You're all caught up",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue), // Warna teks biru
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      "Come back later for Reminders, health tips, moments and weight notifications",
                      style: TextStyle(fontSize: 16, color: Colors.blueGrey), // Warna teks abu-abu kebiruan
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              itemCount: _notifications.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16), // Jarak antar item
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Indikator status (lingkaran kecil)
                        Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.only(top: 6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: notification['isRead']
                                ? Colors.lightBlue.shade300 // Biru muda jika sudah dibaca
                                : Colors.blue.shade700, // Biru tua jika belum dibaca
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Konten notifikasi
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    notification['title']!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black87, // Tetap hitam agar mudah dibaca
                                    ),
                                  ),
                                  Text(
                                    notification['time']!,
                                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                notification['body']!,
                                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              // Aksi notifikasi (TextButton)
                              if (notification['actionText'] != null)
                                GestureDetector(
                                  onTap: notification['onAction'],
                                  child: Text(
                                    notification['actionText']!,
                                    style: TextStyle(
                                      color: Colors.blue.shade700, // Warna biru tua untuk aksi
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