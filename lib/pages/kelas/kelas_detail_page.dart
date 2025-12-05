// ================================================================
// Project : UangQas
// Author  : Umar Ulkhak
// File    : pages/kelas/kelas_detail_page.dart
// Purpose : Halaman detail kelas (total kas, daftar siswa)
// ================================================================

import 'package:flutter/material.dart';
import 'package:uang_qas/db/database_helper.dart';
import 'package:uang_qas/models/kelas_model.dart';
import 'package:uang_qas/models/siswa_model.dart';
import 'package:uang_qas/pages/siswa/tambah_siswa_page.dart';
import 'package:uang_qas/pages/siswa/detail_siswa_page.dart';

class KelasDetailPage extends StatefulWidget {
  final Kelas kelas;
  const KelasDetailPage({super.key, required this.kelas});

  @override
  State<KelasDetailPage> createState() => _KelasDetailPageState();
}

class _KelasDetailPageState extends State<KelasDetailPage> {
  final db = DatabaseHelper();
  List<Siswa> listSiswa = [];
  int totalKas = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final s = await db.getAllSiswaByKelas(widget.kelas.id!);
    final total = await db.getTotalKasByKelas(widget.kelas.id!);
    if (mounted) {
      setState(() {
        listSiswa = s;
        totalKas = total;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.kelas.nama),
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Kas Kelas', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text('Rp $totalKas', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Daftar Siswa', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            if (listSiswa.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Text('Belum ada siswa. Tambah dengan tombol +'),
                ),
              )
            else
              ...listSiswa.map((s) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(Icons.person_rounded),
                  title: Text(s.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Total bayar: Rp ${s.totalBayar}'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DetailSiswaPage(siswa: s)),
                    );
                    _loadData();
                  },
                ),
              )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => TambahSiswaPage(idKelas: widget.kelas.id!)));
          _loadData();
        },
        label: const Text('Tambah Siswa'),
        icon: const Icon(Icons.person_add),
      ),
    );
  }
}
