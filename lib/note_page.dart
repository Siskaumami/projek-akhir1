import 'package:flutter/material.dart'; // Mengimpor library UI Flutter
import 'package:project_akhir1/note.dart'; // Mengimpor model Note
import 'package:project_akhir1/note_database.dart'; // Mengimpor database Note
class NotePage extends StatefulWidget { // Komponen utama halaman catatan, bersifat Stateful
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState(); // Membuat state dari widget ini
}
class _NotePageState extends State<NotePage> {
  final NoteDatabase notesDatabase = NoteDatabase(); // Inisialisasi database catatan
  final TextEditingController noteController = TextEditingController(); // Controller untuk input catatan
  void showNoteDialog({Note? existingNote}) {
    if (existingNote != null) {
      noteController.text = existingNote.content; // Isi controller dengan konten lama jika edit
    } else {
      noteController.clear(); // Kosongkan jika buat baru
    }

    showDialog( // Tampilkan dialog input
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(existingNote == null ? "Tambah Catatan Baru" : "Edit Catatan"), // Judul dialog
          content: TextField( // Text field untuk menulis catatan
            controller: noteController,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: "Tulis catatan di sini...",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton( // Tombol Batal
              onPressed: () {
                noteController.clear();
                Navigator.pop(context);
              },
              child: const Text("Batal"),
            ),
            ElevatedButton( // Tombol Simpan/Update
              onPressed: () {
                final text = noteController.text.trim();
                if (text.isNotEmpty) {
                  if (existingNote == null) {
                    notesDatabase.createNote(Note(content: text)); // Simpan catatan baru
                  } else {
                    notesDatabase.updateNote(existingNote, text); // Perbarui catatan lama
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
  void confirmDelete(Note note) {
    showDialog( // Tampilkan konfirmasi hapus
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Hapus Catatan"),
        content: const Text("Apakah kamu yakin ingin menghapus catatan ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Tutup dialog
            child: const Text("Batal"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red), // Tombol hapus berwarna merah
            onPressed: () {
              notesDatabase.deleteNote(note); // Hapus catatan dari database
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
    noteController.dispose(); // Buang controller agar tidak terjadi memory leak
    super.dispose();
  }
  //UI UTAMA
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100, // Warna latar belakang
      appBar: AppBar(
        title: const Text("Aplikasi Catatan"),
        centerTitle: true,
        backgroundColor: Colors.pink.shade400,
        elevation: 2, // Shadow kecil di bawah AppBar
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink.shade400,
        child: const Icon(Icons.add), // Ikon tambah
        onPressed: () => showNoteDialog(), // Buka dialog catatan baru
      ),
      //menampilkan daftar catatan
            body: StreamBuilder<List<Note>>(
        stream: notesDatabase.stream, // Ambil stream dari database
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Tampilkan loading
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Tampilkan error
          }

          final notes = snapshot.data ?? []; // Ambil data catatan, jika null maka list kosong

          if (notes.isEmpty) {
            return const Center( // Jika tidak ada catatan
              child: Text(
                "Belum ada catatan.\nTekan tombol + untuk membuat catatan baru.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            itemCount: notes.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12), // Jarak antar item
            itemBuilder: (context, index) {
              final note = notes[index];
              return Card( // Gunakan Card untuk tampilan menarik
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
                          onPressed: () => showNoteDialog(existingNote: note), // Edit catatan
                          tooltip: "Edit Catatan",
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => confirmDelete(note), // Hapus catatan
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
    );
  }
}

