// ================================================================
// Project : UangQas
// Author  : Umar Ulkhak
// File    : models/user_model.dart
// Purpose : Model data untuk user (bendahara)
// ================================================================

class User {
  final int? id;
  final String username;
  final String passwordHash;
  final String salt;
  final String role;

  User({
    this.id,
    required this.username,
    required this.passwordHash,
    required this.salt,
    required this.role,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'username': username,
    'password_hash': passwordHash,
    'salt': salt,
    'role': role,
  };

  factory User.fromMap(Map<String, dynamic> m) => User(
    id: m['id'],
    username: m['username'],
    passwordHash: m['password_hash'],
    salt: m['salt'],
    role: m['role'],
  );
}
