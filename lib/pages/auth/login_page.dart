// ================================================================
// Project : UangQas
// Author  : Umar Ulkhak
// File    : pages/auth/login_page.dart
// Purpose : Halaman login untuk bendahara (offline auth)
// ================================================================

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uang_qas/pages/kelas/kelas_list_page.dart';
import '../../db/database_helper.dart';
import '../../utils/security.dart';
import 'register_page.dart'; // Import RegisterPage untuk navigasi reset

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _uC = TextEditingController();
  final _pC = TextEditingController();
  final db = DatabaseHelper();
  bool _loading = false;

  Future<void> _login() async {
    setState(() => _loading = true);
    final username = _uC.text.trim();
    final pass = _pC.text;
    final user = await db.getUserByUsername(username);

    if (!mounted) return;

    if (user == null) {
      _showErr('User tidak ditemukan');
      return;
    }
    final hashed = hashPassword(pass, user.salt);
    if (hashed != user.passwordHash) {
      _showErr('Password salah');
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('logged_username', username);
    
    if (!mounted) return;
    
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const KelasListPage()));
  }

  Future<void> _resetAccount() async {
    // Tampilkan dialog konfirmasi
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset Akun'),
        content: const Text('Apakah Anda yakin ingin mereset akun? Semua data (pengguna, kelas, siswa, pembayaran) akan dihapus secara permanen.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true), 
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Reset', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      // Bersihkan SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // Hapus semua data preferensi, termasuk logged_username

      await db.resetAllData();
      if (mounted) {
        // Navigasi ke RegisterPage setelah reset
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RegisterPage()));
      }
    }
  }

  void _showErr(String msg) {
    setState(() => _loading = false);
    if(mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login - UangQas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset(
              'assets/images/logo.png', 
              height: 120,
            ),
            const SizedBox(height: 24),
            TextField(controller: _uC, decoration: const InputDecoration(labelText: 'Username')),
            const SizedBox(height: 12),
            TextField(controller: _pC, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 16),
            _loading ? const CircularProgressIndicator() : ElevatedButton(onPressed: _login, child: const Text('Login')),
            const SizedBox(height: 20), // Spasi antara tombol login dan reset
            ElevatedButton.icon(
              onPressed: _resetAccount,
              icon: const Icon(Icons.warning_rounded, color: Colors.white),
              label: const Text('Reset Akun (Hapus Semua Data)', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent, 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
