// ================================================================
// Project : UangQas
// Author  : Umar Ulkhak
// File    : pages/auth/register_page.dart
// Purpose : Halaman pembuatan akun bendahara pertama kali (register)
// ================================================================

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../db/database_helper.dart';
import '../../models/user_model.dart';
import '../../utils/security.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _form = GlobalKey<FormState>();
  final _userC = TextEditingController();
  final _passC = TextEditingController();
  bool _loading = false;
  final db = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Bendahara - UangQas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                controller: _userC,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (v) => v == null || v.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passC,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (v) => v == null || v.length < 6 ? 'Minimal 6 karakter' : null,
              ),
              const SizedBox(height: 20),
              _loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(onPressed: _register, child: const Text('Buat Akun')),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _register() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _loading = true);

    final username = _userC.text.trim();
    final password = _passC.text;

    final existing = await db.getUserByUsername(username);
    if (existing != null) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Username sudah digunakan')));
      return;
    }

    final salt = generateSalt();
    final hash = hashPassword(password, salt);
    final user = User(username: username, passwordHash: hash, salt: salt, role: 'bendahara');
    await db.insertUser(user);

    // Simpan session sederhana
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('logged_username', username);

    setState(() => _loading = false);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()));
  }
}
