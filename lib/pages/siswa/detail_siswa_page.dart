// ================================================================
// Project : UangQas
// Author  : Umar Ulkhak
// File    : pages/siswa/detail_siswa_page.dart
// Purpose : Detail siswa: total bayar, jumlah kali bayar, riwayat pembayaran
// ================================================================

import 'package:flutter/material.dart';
import '../../db/database_helper.dart';
import '../../models/siswa_model.dart';
import '../../models/pembayaran_model.dart';
import '../pembayaran/tambah_pembayaran_page.dart';

class DetailSiswaPage extends StatefulWidget {
  final Siswa siswa;
  const DetailSiswaPage({super.key, required this.siswa});
  @override
  State<DetailSiswaPage> createState() => _DetailSiswaPageState();
}

class _DetailSiswaPageState extends State<DetailSiswaPage> {
  final db = DatabaseHelper();
  List<Pembayaran> list = [];
  int count = 0;
  late Siswa currentSiswa;

  @override
  void initState() {
    super.initState();
    currentSiswa = widget.siswa;
    _load();
  }

  Future<void> _load() async {
    final data = await db.getPembayaranBySiswa(currentSiswa.id!);
    final cnt = await db.getCountPembayaranBySiswa(currentSiswa.id!);
    // reload siswa list to get updated total (simple approach: fetch all and find)
    final all = await db.getAllSiswa();
    final refreshed = all.firstWhere((s) => s.id == currentSiswa.id, orElse: () => currentSiswa);
    setState(() {
      list = data;
      count = cnt;
      currentSiswa = refreshed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(currentSiswa.nama)),
      body: Column(children: [
        Container(
          width: double.infinity,
          color: Colors.grey[50],
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Bayar: Rp ${currentSiswa.totalBayar}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text('Sudah bayar: $count kali', style: const TextStyle(color: Colors.black54)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: list.isEmpty
              ? const Center(child: Text('Belum ada pembayaran'))
              : ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, i) {
              final p = list[i];
              return ListTile(
                title: Text('Rp ${p.nominal}'),
                subtitle: Text(p.tanggal),
              );
            },
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => TambahPembayaranPage(idSiswa: currentSiswa.id!)));
          await _load();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
