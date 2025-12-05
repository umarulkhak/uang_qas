// ================================================================
// Project : UangQas
// Author  : Umar Ulkhak
// File    : pages/siswa/detail_siswa_page.dart
// Purpose : Detail siswa: total bayar, jumlah kali bayar, riwayat pembayaran
// ================================================================

import 'package:flutter/material.dart';
import 'package:uang_qas/models/pembayaran_model.dart';
import '../../db/database_helper.dart';
import '../../models/siswa_model.dart';
import 'package:uang_qas/pages/pembayaran/tambah_pembayaran_page.dart';

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
    final refreshed = await db.getSiswaById(currentSiswa.id!);
    if(mounted){
      setState(() {
        list = data;
        count = cnt;
        if (refreshed != null) {
          currentSiswa = refreshed;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(currentSiswa.nama)),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Bayar', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text('Rp ${currentSiswa.totalBayar}', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Text('Sudah bayar: $count kali', style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Riwayat Pembayaran', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            if (list.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Text('Belum ada pembayaran'),
                ),
              )
            else
              ...list.map((p) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(Icons.payment_rounded),
                  title: Text('Rp ${p.nominal}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(p.tanggal),
                ),
              )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => TambahPembayaranPage(idSiswa: currentSiswa.id!)));
          await _load();
        },
        label: const Text('Tambah Bayar'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
