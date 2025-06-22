import 'package:project_akhir1/note.dart'; 
import 'package:supabase_flutter/supabase_flutter.dart'; // Import Supabase SDK untuk Flutter
//notepage=notification


class NoteDatabase {
  final _db = Supabase.instance.client.from('notes'); // Referensi ke tabel 'notes'

  // Stream realtime untuk mengambil list catatan dari Supabase
  Stream<List<Note>> get stream => Supabase.instance.client
      .from('notes') // Tabel 'notes'
      .stream(primaryKey: ['id']) // fungsi Mengaktifkan fitur stream dengan primaryKey 'id'
      .order('id', ascending: false) // sungsi Urutkan dari ID terbesar (catatan terbaru)
      .map((data) => data.map<Note>((e) => Note.fromMap(e)).toList()); // fungsi Ubah hasil dari Map ke objek Note

  // Fungsi untuk menambahkan catatan baru
  Future<void> createNote(Note newNote) async {
    await _db.insert(newNote.toMap()); // fungsi Insert catatan ke tabel
  }

  // Fungsi untuk mengupdate isi catatan
  Future<void> updateNote(Note oldNote, String newContent) async {
    if (oldNote.id == null) {
      throw ArgumentError('Note id cannot be null'); // Validasi: pastikan ada ID
    }
    await _db.update({'content': newContent}).eq('id', oldNote.id!); // Update konten catatan berdasarkan ID
  }

  // Fungsi untuk menghapus catatan
  Future<void> deleteNote(Note note) async {
    if (note.id == null) {
      throw ArgumentError('Note id cannot be null'); // Validasi: pastikan ada ID
    }
    await _db.delete().eq('id', note.id!); // Hapus catatan berdasarkan ID
  }
}
