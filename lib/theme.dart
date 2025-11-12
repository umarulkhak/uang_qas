// ================================================================
// Project : UangQas
// Author  : Umar Ulkhak
// File    : theme.dart
// Purpose : Tema global (navy + gold) dan style dasar aplikasi
// ================================================================

import 'package:flutter/material.dart';

const Color navyPrimary = Color(0xFF0A2647);
const Color goldAccent = Color(0xFFFFC93C);

final ThemeData appTheme = ThemeData(
  primaryColor: navyPrimary,
  colorScheme: const ColorScheme.light(
    primary: navyPrimary,
    secondary: goldAccent,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: navyPrimary,
    foregroundColor: Colors.white,
    elevation: 1,
    centerTitle: true,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: goldAccent,
    foregroundColor: navyPrimary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: goldAccent,
      foregroundColor: navyPrimary,
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[100],
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  ),
);
