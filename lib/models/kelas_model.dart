class Kelas {
  int? id;
  String nama;

  Kelas({this.id, required this.nama});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
    };
  }

  factory Kelas.fromMap(Map<String, dynamic> map) {
    return Kelas(
      id: map['id'],
      nama: map['nama'],
    );
  }
}
