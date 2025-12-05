# 💰 UangQas - Aplikasi Manajemen Kas Sekolah Modern

Aplikasi **Manajemen Uang Kas Sekolah (Offline)** ini dibangun dengan **Flutter** dan **SQLite**, dirancang untuk membantu bendahara sekolah mengelola keuangan kas dengan efisien, cepat, dan tanpa memerlukan koneksi internet. Dengan antarmuka yang canggih dan elegan, UangQas mempermudah pencatatan pembayaran siswa, pemantauan total kas per kelas, dan pengelolaan data siswa serta kelas secara keseluruhan.

---

## 🧠 Fitur Utama

✅ **Autentikasi & Keamanan Offline**
- Login & registrasi bendahara aman (disimpan lokal)
- Password terenkripsi kuat menggunakan SHA-256 + salt
- **Fitur Reset Akun**: Opsi untuk menghapus semua data dan memulai kembali jika lupa detail login (dengan konfirmasi keamanan).

✅ **Manajemen Kelas Komprehensif**
- Tambah, lihat, dan kelola daftar kelas di sekolah.
- Setiap kelas memiliki total uang kasnya sendiri yang terhitung otomatis.

✅ **Manajemen Siswa Efisien**
- Tambah, lihat, dan kelola daftar siswa yang terkait dengan masing-masing kelas.
- Total uang kas yang dibayarkan setiap siswa terhitung otomatis dan terintegrasi dengan kelasnya.

✅ **Catatan Pembayaran Detail**
- Tambah pembayaran dengan mudah untuk setiap siswa.
- Tampilkan riwayat pembayaran lengkap dan jumlah kali pembayaran yang telah dilakukan.
- Total kas keseluruhan per kelas dan total kas sekolah dihitung secara otomatis.

✅ **Database Offline Lokal (SQLite)**
- Semua data tersimpan aman di perangkat pengguna.
- Tidak memerlukan koneksi internet untuk menjalankan aplikasi dan mengelola data.

✅ **UI/UX Canggih & Elegan**
- Tema utama yang konsisten: **Navy, Gold, dan Green**, terinspirasi dari logo aplikasi.
- Desain antarmuka yang modern, bersih, intuitif, dan mudah digunakan.
- Penggunaan **Google Fonts (Poppins)** untuk tipografi yang profesional.

---

## 🧱 Teknologi yang Digunakan

| Komponen | Deskripsi |
|-----------|------------|
| **Flutter** | Framework utama untuk membangun UI cross-platform yang indah dan berperforma tinggi. |
| **SQLite (sqflite)** | Penyimpanan data lokal yang aman dan efisien. |
| **Shared Preferences** | Menyimpan sesi login dan konfigurasi aplikasi lokal. |
| **Path Provider & Path** | Mengelola lokasi database di perangkat. |
| **Crypto** | Library untuk hashing password (SHA-256) guna keamanan data. |
| **Intl** | Internasionalisasi dan format tanggal/waktu yang fleksibel. |
| **Google Fonts** | Mengintegrasikan font kustom (Poppins) untuk tampilan UI yang lebih menarik. |

---