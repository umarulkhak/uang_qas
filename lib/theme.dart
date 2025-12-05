// ================================================================
// Project : UangQas
// Author  : Umar Ulkhak
// File    : theme.dart
// Purpose : Tema global (navy + gold + green) dan style dasar aplikasi
// ================================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color navyPrimary = Color(0xFF0A2647); // Darker blue from logo
const Color navySecondary = Color(0xFF144272);
const Color goldPrimary = Color(0xFFFFC93C); // Gold from logo
const Color goldSecondary = Color(0xFFE5B836);
const Color greenPrimary = Color(0xFF285C4F); // Green from logo
const Color lightBackground = Color(0xFFF8F9FA);

final ThemeData appTheme = ThemeData(
  primaryColor: navyPrimary,
  colorScheme: const ColorScheme.light(
    primary: navyPrimary,
    secondary: goldPrimary,
    surface: lightBackground,
    // Menambahkan warna hijau ke skema warna
    tertiary: greenPrimary, 
  ),
  scaffoldBackgroundColor: lightBackground,
  textTheme: GoogleFonts.poppinsTextTheme(),
  appBarTheme: AppBarTheme(
    backgroundColor: navyPrimary,
    foregroundColor: Colors.white,
    elevation: 2,
    centerTitle: true,
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: goldPrimary,
    foregroundColor: navyPrimary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: goldPrimary,
      foregroundColor: navyPrimary,
      textStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
    ),
  ),
  cardTheme: CardThemeData(
    elevation: 4,
    shadowColor: Colors.black.withAlpha((255 * 0.1).round()),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  listTileTheme: ListTileThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: navyPrimary),
    ),
  ),
);
