class Note {
  final int? id; // ID catatan, opsional karena akan di-generate oleh database
  final String content; // Isi catatan

  // Constructor class Note
  Note({
    this.id, // ID bisa null saat membuat catatan baru
    required this.content, // Isi catatan wajib diisi
  });

  // Fungsi untuk mengubah objek Note ke bentuk Map (untuk dikirim ke Supabase)
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id, // Sertakan ID jika tidak null
      'content': content,       // Sertakan konten catatan
    };
  }

  // Factory constructor untuk membuat objek Note dari Map (hasil ambil dari Supabase)
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int?,            // Ambil ID dari map (bisa null)
      content: map['content'] as String, // Ambil isi catatan sebagai String
    );
  }
}

// Penjelasan singkat tentang class Note:
//id : Digunakan sebagai primary key catatan (dari Supabase)      
//content: Merupakan isi atau teks dari catatan.                                        
//toMap() :Mengubah objek menjadi `Map<String, dynamic>` agar bisa dikirim ke database. 
//fromMap() :Mengubah data dari database (map) menjadi objek `Note`.                        
