import 'package:flutter/material.dart';

class WarRoomTheme {
  static const Color deepBlack = Color(0xFF0A0A0A);
  static const Color neonGreen = Color(0xFF39FF14);
  static const Color ivory = Color(0xFFF5F5F0);
  static const Color mutedGray = Color(0xFF2D2D2D);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: deepBlack,
      primaryColor: neonGreen,
      colorScheme: const ColorScheme.dark(
        primary: neonGreen,
        secondary: neonGreen,
        surface: mutedGray,
        onSurface: ivory,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: neonGreen,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          fontFamily: 'monospace',
        ),
        bodyLarge: TextStyle(
          color: ivory,
          fontSize: 16,
          fontFamily: 'monospace',
        ),
        bodyMedium: TextStyle(
          color: ivory,
          fontSize: 14,
          fontFamily: 'monospace',
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: deepBlack,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: neonGreen,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'monospace',
        ),
      ),
      cardTheme: CardThemeData(
        color: deepBlack,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: neonGreen, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
