import 'package:flutter/material.dart';
import 'package:project_akhir1/note.dart'; // Pastikan path ini benar
import 'package:project_akhir1/note_database.dart'; // Pastikan path ini benar
import 'package:project_akhir1/profile_page.dart'; // Pastikan path ini benar (jika ingin drawer tetap ada)

class TodayPage extends StatefulWidget {
  const TodayPage({super.key});

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  final NoteDatabase notesDatabase = NoteDatabase();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    // Inisialisasi database jika diperlukan, meskipun biasanya sudah diinisialisasi di NoteDatabase itu sendiri
    // notesDatabase.initDatabase(); // contoh jika ada method init di NoteDatabase
  }

  void showNoteDialog({Note? existingNote}) {
    if (existingNote != null) {
      noteController.text = existingNote.content;
    } else {
      noteController.clear();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            existingNote == null ? "Tambah Catatan Baru" : "Edit Catatan",
            style: TextStyle(color: Colors.blue.shade700), // Judul dialog biru
          ),
          content: TextField(
            controller: noteController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: "Tulis catatan di sini...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.blue.shade300), // Border field biru muda
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.blue.shade700, width: 2), // Border focused biru tua
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                noteController.clear();
                Navigator.pop(context);
              },
              child: Text(
                "Batal",
                style: TextStyle(color: Colors.blue.shade500), // Warna teks batal biru
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700, // Warna tombol simpan/update biru tua
                foregroundColor: Colors.white, // Warna teks tombol putih
              ),
              onPressed: () {
                final text = noteController.text.trim();
                if (text.isNotEmpty) {
                  if (existingNote == null) {
                    notesDatabase.createNote(Note(content: text));
                  } else {
                    notesDatabase.updateNote(existingNote, text);
                  }
                }
                noteController.clear();
                Navigator.pop(context);
              },
              child: Text(existingNote == null ? "Simpan" : "Update"),
            ),
          ],
        );
      },
    );
  }

  void confirmDelete(Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Hapus Catatan",
          style: TextStyle(color: Colors.red), // Judul dialog hapus merah
        ),
        content: const Text("Apakah kamu yakin ingin menghapus catatan ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal", style: TextStyle(color: Colors.blueGrey)), // Warna teks batal abu-abu
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700, // Warna tombol hapus merah tua
              foregroundColor: Colors.white, // Warna teks tombol putih
            ),
            onPressed: () {
              notesDatabase.deleteNote(note);
              Navigator.pop(context);
            },
            child: const Text("Hapus"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    noteController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50, // Latar belakang utama biru muda
      appBar: AppBar(
        title: const Text(
          "Catatan Hari Ini", // Judul diubah sesuai konteks "TodayPage"
          style: TextStyle(color: Colors.white), // Warna teks AppBar putih
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade700, // Warna AppBar biru tua
        elevation: 2,
      ),
      // Drawer (opsional, jika kamu ingin tetap ada navigasi profil dari sini)
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue.shade700, // Warna DrawerHeader biru tua
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150'), // Ganti dengan gambar profil default
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Pengguna Aplikasi', // Nama pengguna
                    style: TextStyle(
                      color: Colors.white, // Warna teks putih
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'catatan@example.com', // Email pengguna
                    style: TextStyle(
                      color: Colors.white70, // Warna teks putih agak transparan
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.note_alt, color: Colors.blue.shade700), // Ikon biru tua
              title: const Text('Catatan Saya', style: TextStyle(color: Colors.black87)), // Teks hitam
              onTap: () {
                Navigator.pop(context); // Tutup drawer
                // Sudah berada di TodayPage (sekarang sebagai NotePage), jadi tidak perlu navigasi
              },
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.blue.shade700), // Ikon biru tua
              title: const Text('Profil', style: TextStyle(color: Colors.black87)), // Teks hitam
              onTap: () {
                Navigator.pop(context); // Tutup drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
            const Divider(), // Garis pemisah
            ListTile(
              leading: Icon(Icons.info_outline, color: Colors.blue.shade700), // Ikon biru tua
              title: const Text('Tentang Aplikasi', style: TextStyle(color: Colors.black87)), // Teks hitam
              onTap: () {
                Navigator.pop(context); // Tutup drawer
                showAboutDialog(
                  context: context,
                  applicationName: 'Aplikasi Catatan',
                  applicationVersion: '1.0.0',
                  applicationLegalese: '© 2025 Semua Hak Dilindungi',
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Text(
                        'Aplikasi sederhana untuk mencatat ide dan informasi penting Anda.',
                        style: TextStyle(color: Colors.black87), // Teks hitam
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade700, // FAB biru tua
        foregroundColor: Colors.white, // Ikon FAB putih
        child: const Icon(Icons.add),
        onPressed: () => showNoteDialog(),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Cari catatan...",
                hintStyle: TextStyle(color: Colors.blue.shade300), // Warna hint text biru muda
                prefixIcon: Icon(Icons.search, color: Colors.blue.shade500), // Warna ikon search biru
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue.shade300), // Border field biru muda
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue.shade300), // Border field biru muda
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue.shade700, width: 2), // Border focused biru tua
                ),
                filled: true,
                fillColor: Colors.white, // Latar belakang field putih
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Note>>(
              stream: notesDatabase.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: Colors.blue.shade700)); // Warna progress biru tua
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.red))); // Warna error merah
                }

                final notes = snapshot.data ?? [];

                // Filter berdasarkan kata kunci pencarian
                final filteredNotes = notes.where((note) {
                  return note.content.toLowerCase().contains(searchQuery);
                }).toList();

                if (filteredNotes.isEmpty) {
                  return const Center(
                    child: Text(
                      "Tidak ditemukan catatan.\nCoba kata kunci lain.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.blueGrey), // Warna teks abu-abu kebiruan
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  itemCount: filteredNotes.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final note = filteredNotes[index];
                    return Card(
                      color: Colors.white, // Warna Card putih
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.blue.shade100, width: 1), // Border card biru muda
                      ),
                      elevation: 3,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                        title: Text(
                          note.content,
                          style: const TextStyle(fontSize: 16, color: Colors.black87), // Warna teks catatan hitam
                        ),
                        trailing: SizedBox(
                          width: 96,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue.shade600), // Ikon edit biru
                                onPressed: () => showNoteDialog(existingNote: note),
                                tooltip: "Edit Catatan",
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red.shade600), // Ikon delete merah
                                onPressed: () => confirmDelete(note),
                                tooltip: "Hapus Catatan",
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}