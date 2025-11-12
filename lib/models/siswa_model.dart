// ================================================================
// Project : UangQas
// Author  : Umar Ulkhak
// File    : models/siswa_model.dart
// Purpose : Model data untuk siswa (nama + total bayar)
// ================================================================

class Siswa {
  final int? id;
  final String nama;
  final int totalBayar;

  Siswa({this.id, required this.nama, required this.totalBayar});

  Map<String, dynamic> toMap() => {
    'id': id,
    'nama': nama,
    'total_bayar': totalBayar,
  };

  factory Siswa.fromMap(Map<String, dynamic> m) => Siswa(
    id: m['id'],
    nama: m['nama'],
    totalBayar: m['total_bayar'] ?? 0,
  );
}
