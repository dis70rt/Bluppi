// core/theme/bluppi_theme.dart
import 'package:bluppi/core/constants/colors.dart';
import 'package:flutter/material.dart';

class BluppiTheme {
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: BluppiColors.background,

      colorScheme: const ColorScheme.dark(
        surface: BluppiColors.surface,
        primary: BluppiColors.primary,
        secondary: BluppiColors.accent,
        error: BluppiColors.error,
        onSurface: BluppiColors.textPrimary,
        onPrimary: BluppiColors.background,
        onSecondary: BluppiColors.textPrimary,
      ),

      dividerColor: BluppiColors.divider,

      appBarTheme: const AppBarTheme(
        backgroundColor: BluppiColors.background,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: BluppiColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(
          color: BluppiColors.primary,
        ),
      ),

      iconTheme: const IconThemeData(
        color: BluppiColors.primary,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: BluppiColors.primary,
          foregroundColor: BluppiColors.background,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
        ),
      ),

      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: BluppiColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: BluppiColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          color: BluppiColors.textSecondary,
        ),
        bodySmall: TextStyle(
          color: BluppiColors.textDisabled,
        ),
      ),

      cardTheme: CardThemeData(
        color: BluppiColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: BluppiColors.surfaceRaised,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
      ),
    );
  }
}
