// ================================================================
// Project : UangQas
// Author  : Umar Ulkhak
// File    : pages/pembayaran/tambah_pembayaran_page.dart
// Purpose : Form tambah pembayaran untuk satu siswa
// ================================================================

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../db/database_helper.dart';
import '../../models/pembayaran_model.dart';

class TambahPembayaranPage extends StatefulWidget {
  final int idSiswa;
  const TambahPembayaranPage({super.key, required this.idSiswa});
  @override
  State<TambahPembayaranPage> createState() => _TambahPembayaranPageState();
}

class _TambahPembayaranPageState extends State<TambahPembayaranPage> {
  final _ctrl = TextEditingController();
  final db = DatabaseHelper();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Pembayaran')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(controller: _ctrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Nominal')),
          const SizedBox(height: 20),
          _loading ? const CircularProgressIndicator() : ElevatedButton(onPressed: _save, child: const Text('Simpan'))
        ]),
      ),
    );
  }

  Future<void> _save() async {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    setState(() => _loading = true);
    final nominal = int.tryParse(text) ?? 0;
    final tanggal = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());
    final p = Pembayaran(idSiswa: widget.idSiswa, tanggal: tanggal, nominal: nominal);
    await db.insertPembayaran(p);
    setState(() => _loading = false);
    Navigator.pop(context);
  }
}
