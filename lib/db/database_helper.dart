// ================================================================
// Project : UangQas
// Author  : Umar Ulkhak
// File    : db/database_helper.dart
// Purpose : Helper SQLite (open, create tables, CRUD operations)
// ================================================================

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/user_model.dart';
import '../models/siswa_model.dart';
import '../models/pembayaran_model.dart';
import '../models/kelas_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _db;
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final docs = await getApplicationDocumentsDirectory();
    final path = join(docs.path, 'uang_qas.db');
    return await openDatabase(path, version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future<void> _onCreate(Database db, int version) async {
    // Kelas table
    await db.execute('''
      CREATE TABLE kelas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT
      );
    ''');

    // User table
    await db.execute('''
      CREATE TABLE user (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE,
        password_hash TEXT,
        salt TEXT,
        role TEXT,
        id_kelas INTEGER,
        FOREIGN KEY(id_kelas) REFERENCES kelas(id)
      );
    ''');

    // Siswa table
    await db.execute('''
      CREATE TABLE siswa (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT,
        total_bayar INTEGER DEFAULT 0,
        id_kelas INTEGER,
        FOREIGN KEY(id_kelas) REFERENCES kelas(id)
      );
    ''');

    // Pembayaran table
    await db.execute('''
      CREATE TABLE pembayaran (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_siswa INTEGER,
        tanggal TEXT,
        nominal INTEGER,
        FOREIGN KEY(id_siswa) REFERENCES siswa(id)
      );
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute('DROP TABLE IF EXISTS pembayaran');
    await db.execute('DROP TABLE IF EXISTS siswa');
    await db.execute('DROP TABLE IF EXISTS user');
    await db.execute('DROP TABLE IF EXISTS kelas');
    await _onCreate(db, newVersion);
  }

  Future<void> resetAllData() async {
    await _db?.close();
    final docs = await getApplicationDocumentsDirectory();
    final path = join(docs.path, 'uang_qas.db');
    await deleteDatabase(path);
    _db = null;
    await _initDb();
  }

  // -------------------- KELAS --------------------
  Future<int> insertKelas(Kelas k) async {
    final database = await db;
    return await database.insert('kelas', k.toMap());
  }

  Future<List<Kelas>> getAllKelas() async {
    final database = await db;
    final res = await database.query('kelas', orderBy: 'nama ASC');
    return res.map((e) => Kelas.fromMap(e)).toList();
  }

  Future<Kelas?> getKelasById(int id) async {
    final database = await db;
    final res = await database.query('kelas', where: 'id = ?', whereArgs: [id]);
    if (res.isEmpty) return null;
    return Kelas.fromMap(res.first);
  }

  Future<int> deleteKelas(int id) async {
    final database = await db;
    return await database.delete('kelas', where: 'id = ?', whereArgs: [id]);
  }

  // -------------------- USER --------------------
  Future<int> insertUser(User u) async {
    final database = await db;
    return await database.insert('user', u.toMap());
  }

  Future<User?> getUserByUsername(String username) async {
    final database = await db;
    final res = await database.query('user', where: 'username = ?', whereArgs: [username]);
    if (res.isEmpty) return null;
    return User.fromMap(res.first);
  }

  Future<int> getUserCount() async {
    final database = await db;
    final res = await database.rawQuery('SELECT COUNT(*) as c FROM user');
    return (res.first['c'] as int);
  }

  // -------------------- SISWA --------------------
  Future<int> insertSiswa(Siswa s) async {
    final database = await db;
    return await database.insert('siswa', s.toMap());
  }

  Future<Siswa?> getSiswaById(int id) async {
    final database = await db;
    final res = await database.query('siswa', where: 'id = ?', whereArgs: [id]);
    if (res.isEmpty) return null;
    return Siswa.fromMap(res.first);
  }

  Future<List<Siswa>> getAllSiswaByKelas(int idKelas) async {
    final database = await db;
    final res = await database.query('siswa', where: 'id_kelas = ?', whereArgs: [idKelas], orderBy: 'nama ASC');
    return res.map((e) => Siswa.fromMap(e)).toList();
  }
  
  Future<int> deleteSiswa(int id) async {
    final database = await db;
    return await database.transaction((txn) async {
      await txn.delete('pembayaran', where: 'id_siswa = ?', whereArgs: [id]);
      return await txn.delete('siswa', where: 'id = ?', whereArgs: [id]);
    });
  }

  Future<int> updateTotalBayar(int idSiswa, int tambahan) async {
    final database = await db;
    return await database.rawUpdate('UPDATE siswa SET total_bayar = total_bayar + ? WHERE id = ?', [tambahan, idSiswa]);
  }

  Future<int> getTotalKasByKelas(int idKelas) async {
    final database = await db;
    final res = await database.rawQuery('SELECT SUM(total_bayar) as total FROM siswa WHERE id_kelas = ?', [idKelas]);
    final val = res.first['total'];
    if (val == null) return 0;
    return val as int;
  }

  // -------------------- PEMBAYARAN --------------------
  Future<int> insertPembayaran(Pembayaran p) async {
    final database = await db;
    return await database.transaction((txn) async {
      final id = await txn.insert('pembayaran', p.toMap());
      await txn.rawUpdate('UPDATE siswa SET total_bayar = total_bayar + ? WHERE id = ?', [p.nominal, p.idSiswa]);
      return id;
    });
  }

  Future<List<Pembayaran>> getPembayaranBySiswa(int idSiswa) async {
    final database = await db;
    final res = await database.query('pembayaran', where: 'id_siswa = ?', whereArgs: [idSiswa], orderBy: 'id DESC');
    return res.map((e) => Pembayaran.fromMap(e)).toList();
  }

  Future<int> getCountPembayaranBySiswa(int idSiswa) async {
    final database = await db;
    final res = await database.rawQuery('SELECT COUNT(*) as c FROM pembayaran WHERE id_siswa = ?', [idSiswa]);
    return (res.first['c'] as int);
  }
}
