// ================================================================
// Project : UangQas
// Author  : Umar Ulkhak
// File    : pages/auth/splash_page.dart
// Purpose : Cek first-run: jika belum ada user -> register, else login
// ================================================================

import 'package:flutter/material.dart';
import '../../db/database_helper.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final db = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _checkFirst();
  }

  Future<void> _checkFirst() async {
    final count = await db.getUserCount();
    
    if (!mounted) return;

    if (count == 0) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RegisterPage()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: CircularProgressIndicator()));
}
