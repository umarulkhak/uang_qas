// ================================================================
// Project : UangQas
// Author  : Umar Ulkhak
// File    : models/pembayaran_model.dart
// Purpose : Model data untuk catatan pembayaran per siswa
// ================================================================

class Pembayaran {
  final int? id;
  final int idSiswa;
  final String tanggal;
  final int nominal;

  Pembayaran({this.id, required this.idSiswa, required this.tanggal, required this.nominal});

  Map<String, dynamic> toMap() => {
    'id': id,
    'id_siswa': idSiswa,
    'tanggal': tanggal,
    'nominal': nominal,
  };

  factory Pembayaran.fromMap(Map<String, dynamic> m) => Pembayaran(
    id: m['id'],
    idSiswa: m['id_siswa'],
    tanggal: m['tanggal'],
    nominal: m['nominal'],
  );
}
