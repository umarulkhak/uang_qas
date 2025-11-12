// ================================================================
// Project : UangQas
// Author  : Umar Ulkhak
// File    : utils/security.dart
// Purpose : Utility untuk salt & hash password (SHA-256)
// ================================================================

import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

/// Generate random salt (base64)
String generateSalt([int length = 16]) {
  final rand = Random.secure();
  final bytes = List<int>.generate(length, (_) => rand.nextInt(256));
  return base64Url.encode(bytes);
}

/// Hash password + salt menggunakan SHA-256, return hex string
String hashPassword(String password, String salt) {
  final bytes = utf8.encode(password + salt);
  final digest = sha256.convert(bytes);
  return digest.toString();
}
