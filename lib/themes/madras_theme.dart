import 'package:flutter/material.dart';

// 🎨 Couleurs Kwazé Kréyol
const Color rougeMadras = Color(0xFFD72638);
const Color jauneSoleil = Color(0xFFF4C300);
const Color vertCanne = Color(0xFF6BBF59);
const Color bleuLagon = Color(0xFF00B5E2);
const Color orangeZepon = Color(0xFFF27D16);
const Color sable = Color(0xFFFAF3E0);
const Color bois = Color(0xFF6F4E37);
const Color violetBalisier = Color(0xFF9146A0);

final ThemeData madrasTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: sable,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: rougeMadras,
    onPrimary: Colors.white,
    secondary: bleuLagon,
    onSecondary: Colors.white,
    surface: sable,
    //surface: jauneSoleil,
    onSurface: bois,
    error: orangeZepon,
    onError: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: bois,
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent,
    elevation: 0,
    selectedItemColor: rougeMadras,
    unselectedItemColor: bois,
    selectedIconTheme: IconThemeData(size: 28),
    unselectedIconTheme: IconThemeData(size: 24),
    showUnselectedLabels: true,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: bois,
    ),
    titleMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: bois,
    ),
    bodyLarge: TextStyle(fontSize: 16, color: bois),
  ),
);
