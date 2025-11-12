// ================================================================
// Project : UangQas
// Author  : Umar Ulkhak
// File    : pages/home_page.dart
// Purpose : Dashboard utama: total kas, daftar siswa, navigasi CRUD
// ================================================================

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uang_qas/db/database_helper.dart';
import 'package:uang_qas/models/siswa_model.dart';
import 'package:uang_qas/pages/siswa/tambah_siswa_page.dart';
import 'package:uang_qas/pages/siswa/detail_siswa_page.dart';
import 'package:uang_qas/pages/auth/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final db = DatabaseHelper();
  List<Siswa> list = [];
  int totalKas = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final s = await db.getAllSiswa();
    final total = await db.getTotalSemuaKas();
    setState(() {
      list = s;
      totalKas = total;
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('logged_username');
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UangQas - Dashboard'),
        actions: [
          IconButton(onPressed: _logout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Total Kas', style: TextStyle(fontSize: 14, color: Colors.black54)),
                            const SizedBox(height: 6),
                            Text('Rp $totalKas', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          ],
                        )),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.download),
                      label: const Text('Export'),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            const Text('Daftar Siswa', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            ...list.map((s) => ListTile(
              title: Text(s.nama),
              subtitle: Text('Total bayar: Rp ${s.totalBayar}'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DetailSiswaPage(siswa: s)),
                );
                _load();
              },
            )),
            if (list.isEmpty) const SizedBox(height: 20),
            if (list.isEmpty) const Center(child: Text('Belum ada siswa. Tambah dengan tombol +')),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => const TambahSiswaPage()));
          _load();
        },
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
