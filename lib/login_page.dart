import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:project_akhir1/note_page.dart'; // file ini harus ada because jika tidak ada mk tdk ada output

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  // Durasi simulasi loading
  Duration get loadingTime => const Duration(milliseconds: 2000);

  // Simulasi login (anggap login berhasil)
  Future<String?> _authUser(LoginData data) {
    return Future.delayed(loadingTime).then((_) => null); // null = sukses
  }

  // Simulasi lupa password
  Future<String?> _recoverPassword(String name) {
    return Future.delayed(loadingTime).then((_) => null); // null = sukses
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'My Notes',
      onLogin: _authUser,
      onRecoverPassword: _recoverPassword,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const NotePage()),
        );
      },
      theme: LoginTheme(
        pageColorLight: Colors.pink.shade100, // Warna latar belakang
        primaryColor: Colors.pink,             // Warna utama tombol
        accentColor: Colors.white,             // Warna ikon & teks
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        titleStyle: const TextStyle(
          color: Colors.pink,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        buttonTheme: const LoginButtonTheme(
          backgroundColor: Colors.pink,
        ),
      ),
    );
  }
}
