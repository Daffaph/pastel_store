import 'package:flutter/material.dart';

// Palet warna pastel
const Color pastelLavender = Color(0xFFCDB4DB);
const Color pastelPink = Color(0xFFFFC8DD);
const Color pastelBlue = Color(0xFFBDE0FE);
const Color pastelBackground = Color(0xFFFFF8FB);
const Color textDark = Color(0xFF4A4458);

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: pastelBackground,
  colorScheme: ColorScheme.fromSeed(
    seedColor: pastelLavender,
    primary: const Color(0xFF8E6BBF),
    secondary: pastelPink,
    surface: pastelBackground,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: pastelLavender,
    foregroundColor: textDark,
    elevation: 0,
    centerTitle: true,
  ),
);
