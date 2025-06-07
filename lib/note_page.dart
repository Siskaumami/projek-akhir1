import 'package:flutter/material.dart';
import 'package:project_akhir1/note.dart';
import 'package:project_akhir1/note_database.dart';
import 'package:project_akhir1/profile_page.dart'; // Import halaman profil

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final NoteDatabase notesDatabase = NoteDatabase();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  String searchQuery = "";

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
          title: Text(existingNote == null ? "Tambah Catatan Baru" : "Edit Catatan"),
          content: TextField(
            controller: noteController,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: "Tulis catatan di sini...",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                noteController.clear();
                Navigator.pop(context);
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
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
        title: const Text("Hapus Catatan"),
        content: const Text("Apakah kamu yakin ingin menghapus catatan ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Aplikasi Catatan"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade700,
        elevation: 2,
      ),
      // --- Mulai penambahan Drawer untuk navigasi ke profil ---
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue.shade700,
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
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'catatan@example.com', // Email pengguna
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.note_alt),
              title: const Text('Catatan Saya'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
                // Sudah berada di NotePage, jadi tidak perlu navigasi
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profil'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
            // Tambahkan item lain di drawer jika diperlukan, misalnya pengaturan
            const Divider(), // Garis pemisah
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Tentang Aplikasi'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
                // Aksi untuk membuka halaman "Tentang Aplikasi"
                showAboutDialog(
                  context: context,
                  applicationName: 'Aplikasi Catatan',
                  applicationVersion: '1.0.0',
                  applicationLegalese: '© 2025 Semua Hak Dilindungi',
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Text('Aplikasi sederhana untuk mencatat ide dan informasi penting Anda.'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      // --- Selesai penambahan Drawer ---
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade700,
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
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
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
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
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
                      style: TextStyle(fontSize: 18, color: Colors.grey),
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                        title: Text(
                          note.content,
                          style: const TextStyle(fontSize: 16),
                        ),
                        trailing: SizedBox(
                          width: 96,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => showNoteDialog(existingNote: note),
                                tooltip: "Edit Catatan",
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
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