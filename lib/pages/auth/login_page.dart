// ================================================================
// Project : UangQas
// Author  : Umar Ulkhak
// File    : pages/auth/login_page.dart
// Purpose : Halaman login untuk bendahara (offline auth)
// ================================================================

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../db/database_helper.dart';
import '../../utils/security.dart';
import '../home_page.dart';

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
    setState(() => _loading = false);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
  }

  void _showErr(String msg) {
    setState(() => _loading = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login - UangQas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _uC, decoration: const InputDecoration(labelText: 'Username')),
            const SizedBox(height: 12),
            TextField(controller: _pC, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 16),
            _loading ? const CircularProgressIndicator() : ElevatedButton(onPressed: _login, child: const Text('Login'))
          ],
        ),
      ),
    );
  }
}
