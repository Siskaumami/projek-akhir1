import 'package:flutter/material.dart';// Mengimpor pustaka UI dasar Flutter
import 'package:project_akhir1/note.dart'; // Model catatan
// Mengimpor kelas NoteDatabase untuk CRUD catatan
import 'package:project_akhir1/note_database.dart'; 
import 'package:project_akhir1/profile_page.dart'; 
class TodayPage extends StatefulWidget {
  const TodayPage({super.key});

  @override
  State<TodayPage> createState() => _TodayPageState();
}
// State dari halaman TodayPage
class _TodayPageState extends State<TodayPage> {
  final NoteDatabase notesDatabase = NoteDatabase(); // fungsi Instance database
  final TextEditingController noteController = TextEditingController(); //fungsi  Controller untuk input catatan
  final TextEditingController searchController = TextEditingController(); // fungsi Controller untuk input pencarian
  String searchQuery = ""; // fungsi Query pencarian

  @override
  void initState() {
    super.initState();
    // fungsi Bisa digunakan untuk inisialisasi database jika dibutuhkan
  }
  // Fungsi untuk menampilkan dialog tambah/edit catatan
  void showNoteDialog({Note? existingNote}) {
    if (existingNote != null) {
      noteController.text = existingNote.content; // fungsi Jika edit, isi field dengan konten lama
    } else {
      noteController.clear(); // fungsi Jika tambah, kosongkan field
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            existingNote == null ? "Tambah Catatan Baru" : "Edit Catatan",
            style: TextStyle(color: Colors.blue.shade700),
          ),
          content: TextField(
            controller: noteController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: "Tulis catatan di sini...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.blue.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                noteController.clear();
                Navigator.pop(context); // Tutup dialog
              },
              child: Text("Batal", style: TextStyle(color: Colors.blue.shade500)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                final text = noteController.text.trim();
                if (text.isNotEmpty) {
                  if (existingNote == null) {
                    notesDatabase.createNote(Note(content: text)); // Simpan catatan baru
                  } else {
                    notesDatabase.updateNote(existingNote, text); // Update catatan lama
                  }
                }
                noteController.clear();
                Navigator.pop(context); // Tutup dialog
              },
              child: Text(existingNote == null ? "Simpan" : "Update"),
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk konfirmasi sebelum menghapus catatan
  void confirmDelete(Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Hapus Catatan", style: TextStyle(color: Colors.red)),
        content: const Text("Apakah kamu yakin ingin menghapus catatan ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal", style: TextStyle(color: Colors.blueGrey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              notesDatabase.deleteNote(note); // Hapus catatan
              Navigator.pop(context); // Tutup dialog
            },
            child: const Text("Hapus"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    noteController.dispose(); // fungsi Bebaskan memori controller catatan
    searchController.dispose(); // fungsi Bebaskan memori controller pencarian
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text("Catatan Hari Ini", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue.shade700,
        elevation: 2,
      ),
      drawer: Drawer( // Navigasi samping
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue.shade700),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                  ),
                  SizedBox(height: 10),
                  Text('Pengguna Aplikasi', style: TextStyle(color: Colors.white, fontSize: 18)),
                  Text('catatan@example.com', style: TextStyle(color: Colors.white70, fontSize: 14)),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.note_alt, color: Colors.blue.shade700),
              title: const Text('Catatan Saya', style: TextStyle(color: Colors.black87)),
              onTap: () {
                Navigator.pop(context); // fungsi Tidak pindah karena ini halaman aktif
              },
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.blue.shade700),
              title: const Text('Profil', style: TextStyle(color: Colors.black87)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.info_outline, color: Colors.blue.shade700),
              title: const Text('Tentang Aplikasi', style: TextStyle(color: Colors.black87)),
              onTap: () {
                Navigator.pop(context);
                showAboutDialog(
                  context: context,
                  applicationName: 'Aplikasi Catatan',
                  applicationVersion: '1.0.0',
                  applicationLegalese: '© 2025 Semua Hak Dilindungi',
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Text(
                        'Aplikasi sederhana untuk mencatat ide dan informasi penting Anda.',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton( // Tombol tambah catatan
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () => showNoteDialog(), // Panggil form tambah
      ),
      body: Column(
        children: [
          // Input pencarian
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Cari catatan...",
                hintStyle: TextStyle(color: Colors.blue.shade300),
                prefixIcon: Icon(Icons.search, color: Colors.blue.shade500),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase(); // Update pencarian
                });
              },
            ),
          ),
          // Menampilkan daftar catatan dengan Stream
          Expanded(
            child: StreamBuilder<List<Note>>(
              stream: notesDatabase.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: Colors.blue.shade700));
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.red)));
                }

                final notes = snapshot.data ?? [];

                // Filter berdasarkan pencarian
                final filteredNotes = notes.where((note) {
                  return note.content.toLowerCase().contains(searchQuery);
                }).toList();

                if (filteredNotes.isEmpty) {
                  return const Center(
                    child: Text(
                      "Tidak ditemukan catatan.\nCoba kata kunci lain.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                    ),
                  );
                }

                // Tampilkan catatan dalam bentuk list
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  itemCount: filteredNotes.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final note = filteredNotes[index];
                    return Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.blue.shade100, width: 1),
                      ),
                      elevation: 3,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                        title: Text(note.content, style: const TextStyle(fontSize: 16, color: Colors.black87)),
                        trailing: SizedBox(
                          width: 96,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue.shade600),
                                onPressed: () => showNoteDialog(existingNote: note),
                                tooltip: "Edit Catatan",
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red.shade600),
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
