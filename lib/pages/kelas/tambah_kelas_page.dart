// ================================================================
// Project : UangQas
// Author  : Umar Ulkhak
// File    : pages/kelas/tambah_kelas_page.dart
// Purpose : Halaman untuk menambah kelas baru
// ================================================================

import 'package:flutter/material.dart';
import 'package:uang_qas/db/database_helper.dart';
import 'package:uang_qas/models/kelas_model.dart';

class TambahKelasPage extends StatefulWidget {
  const TambahKelasPage({super.key});

  @override
  State<TambahKelasPage> createState() => _TambahKelasPageState();
}

class _TambahKelasPageState extends State<TambahKelasPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final db = DatabaseHelper();

  Future<void> _simpan() async {
    if (_formKey.currentState!.validate()) {
      await db.insertKelas(Kelas(nama: _namaController.text));
      if (mounted) { // Changed context.mounted to mounted
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Kelas'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama Kelas',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama kelas tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _simpan,
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
