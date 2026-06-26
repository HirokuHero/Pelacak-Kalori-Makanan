import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get material3 {
    const Color seed = Color(0xFF5B8DEF);

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light),
      appBarTheme: const AppBarTheme(centerTitle: true),
    );
  }
}

