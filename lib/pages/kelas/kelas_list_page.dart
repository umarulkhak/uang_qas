// ================================================================
// Project : UangQas
// Author  : Umar Ulkhak
// File    : pages/kelas/kelas_list_page.dart
// Purpose : Halaman untuk menampilkan daftar kelas
// ================================================================

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uang_qas/db/database_helper.dart';
import 'package:uang_qas/models/kelas_model.dart';
import 'package:uang_qas/pages/auth/login_page.dart';
import 'package:uang_qas/pages/kelas/tambah_kelas_page.dart';
import 'package:uang_qas/pages/kelas/kelas_detail_page.dart';

class KelasListPage extends StatefulWidget {
  const KelasListPage({super.key});

  @override
  State<KelasListPage> createState() => _KelasListPageState();
}

class _KelasListPageState extends State<KelasListPage> {
  final db = DatabaseHelper();
  List<Kelas> listKelas = [];

  @override
  void initState() {
    super.initState();
    _loadKelas();
  }

  Future<void> _loadKelas() async {
    final k = await db.getAllKelas();
    if (mounted) {
      setState(() {
        listKelas = k;
      });
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('logged_username');
    if (mounted) { // Changed context.mounted to mounted
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
        title: const Text('UangQas'),
        actions: [
          IconButton(onPressed: _logout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadKelas,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Daftar Kelas', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            if (listKelas.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Text('Belum ada kelas. Tambah dengan tombol +'),
                ),
              )
            else
              ...listKelas.map((k) => Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: const Icon(Icons.class_rounded),
                      title: Text(k.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => KelasDetailPage(kelas: k)),
                        );
                        _loadKelas();
                      },
                    ),
                  )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => const TambahKelasPage()));
          _loadKelas();
        },
        label: const Text('Tambah Kelas'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
