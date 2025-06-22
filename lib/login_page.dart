import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
// import 'package:project_akhir1/note_page.dart'; // NotePage tidak lagi jadi tujuan utama login
import 'package:project_akhir1/main_screen.dart'; // <-- PENTING: Tambahkan import untuk MainScreen

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Duration get loadingTime => const Duration(milliseconds: 2000);

  Future<String?> _authUser(LoginData data) async {
    // Ini adalah tempat kamu akan mengintegrasikan Supabase login
    // Untuk saat ini, kita bisa mensimulasikan login berhasil atau gagal
    try {
      // Ganti ini dengan logika Supabase login yang sebenarnya
  
      await Future.delayed(loadingTime); // Simulasi proses async
    
      // Jika login berhasil, kembalikan null (berarti tidak ada error)
      return null; 
    } catch (e) {
      // Tangani error login dari Supabase atau simulasi error
      return 'Gagal login: ${e.toString()}'; // Mengembalikan pesan error
    }
  }

  Future<String?> _recoverPassword(String name) {
    // Ini adalah tempat kamu akan mengintegrasikan Supabase reset password
    return Future.delayed(loadingTime).then((_) => null);
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'MindVault',
      onLogin: _authUser,
      onRecoverPassword: _recoverPassword,
      onSubmitAnimationCompleted: () {
        // Setelah login/registrasi selesai dan animasinya beres
        // NAVIGASI KE MAINSCREEN, BUKAN NOTEPAAGE
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainScreen()), 
        );
      },
      theme: LoginTheme(
        pageColorLight: Colors.lightBlue.shade50, // latar belakang biru muda
        primaryColor: Colors.blue.shade700, // warna utama (tombol, judul)
        accentColor: Colors.white, // ikon dan teks
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        titleStyle: TextStyle(
          color: Colors.blue.shade700,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        buttonTheme: LoginButtonTheme(
          backgroundColor: Colors.blue.shade700,
        ),
      ),
    );
  }
}