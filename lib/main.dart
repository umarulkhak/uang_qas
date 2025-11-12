// ================================================================
// Project : UangQas (Manajemen Kas Kelas Offline)
// Author  : Umar Ulkhak
// File    : main.dart
// Purpose : Entry point aplikasi, setup tema & halaman awal (Splash)
// ================================================================

import 'package:flutter/material.dart';
import 'theme.dart';
import 'pages/auth/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const UangQasApp());
}

/// Root widget aplikasi UangQas
class UangQasApp extends StatelessWidget {
  const UangQasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UangQas',
      debugShowCheckedModeBanner: false,
      theme: appTheme,             // Tema global (navy + gold)
      home: const SplashPage(),    // Halaman pertama yang dijalankan
    );
  }
}
