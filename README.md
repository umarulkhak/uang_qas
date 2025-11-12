# 💰 UangQas

Aplikasi **Manajemen Uang Kas Kelas (Offline)** dibuat dengan **Flutter** dan **SQLite**.  
Dikembangkan oleh **Umar Ulkhak** — untuk membantu bendahara kelas memantau pembayaran uang kas, mencatat pembayaran siswa, dan melihat total kas dengan cepat tanpa koneksi internet.

---

## 🧠 Fitur Utama

✅ **Autentikasi Offline**
- Login & register bendahara hanya sekali (disimpan lokal)
- Password terenkripsi menggunakan SHA-256 + salt

✅ **Manajemen Siswa**
- Tambah, lihat, dan kelola daftar siswa
- Total uang kas tiap siswa terhitung otomatis

✅ **Catatan Pembayaran**
- Tambah pembayaran untuk setiap siswa
- Tampilkan histori dan jumlah kali pembayaran
- Total kas keseluruhan dihitung otomatis

✅ **Database Offline (SQLite)**
- Semua data tersimpan aman di perangkat
- Tidak butuh koneksi internet

✅ **UI/UX Profesional**
- Tema utama **Navy + Gold**
- Desain simpel, rapi, dan mudah digunakan

---

## 🧱 Teknologi yang Digunakan

| Komponen | Deskripsi |
|-----------|------------|
| **Flutter** | Framework utama untuk UI cross-platform |
| **SQLite (sqflite)** | Penyimpanan data lokal |
| **Shared Preferences** | Menyimpan sesi login |
| **Path Provider & Path** | Lokasi database |
| **Crypto** | Hash password (SHA-256) |
| **Intl** | Format tanggal pembayaran |

---