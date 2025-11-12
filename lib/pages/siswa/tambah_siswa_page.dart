// ================================================================
// Project : UangQas
// Author  : Umar Ulkhak
// File    : pages/siswa/tambah_siswa_page.dart
// Purpose : Form tambah siswa baru
// ================================================================

import 'package:flutter/material.dart';
import '../../db/database_helper.dart';
import '../../models/siswa_model.dart';

class TambahSiswaPage extends StatefulWidget {
  const TambahSiswaPage({super.key});
  @override
  State<TambahSiswaPage> createState() => _TambahSiswaPageState();
}

class _TambahSiswaPageState extends State<TambahSiswaPage> {
  final _ctrl = TextEditingController();
  final db = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Siswa - UangQas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(controller: _ctrl, decoration: const InputDecoration(labelText: 'Nama siswa')),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _save, child: const Text('Simpan'))
        ]),
      ),
    );
  }

  Future<void> _save() async {
    final name = _ctrl.text.trim();
    if (name.isEmpty) return;
    final s = Siswa(nama: name, totalBayar: 0);
    await db.insertSiswa(s);
    Navigator.pop(context);
  }
}
