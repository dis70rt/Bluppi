import 'package:flutter/material.dart';

class Spotify {
  static const Color primary = Color(0xFF1DB954);
}

class AppColors {
  static const Color primary = Color(0xFF7B1FA2);
  static const Color primaryAlt = Color(0xFF9C27B0);
  static const Color primaryAltDeep = Color(0xFF673AB7);

  static const Color primaryDark = Color(0xFF6A0DAD);
  static const Color primaryDarker = Color(0xFF8E24AA);
  static const Color primaryDarkest = Color(0xFF512DA8);

  static const Color accent = Color(0xFFEC407A);
  static const Color accentCyan = Color(0xFF00BCD4);
  static const Color accentYellow = Color(0xFFFFD54F);

  static const Color background = Color(0xFF161625);
  static const Color backgroundDark = Color(0xFF120E1A);

  static const Color surface = Color(0xFF1E1E32);
  static const Color surfaceDark = Color(0xFF201A2B);

  static const Color darkSurface = Color(0xFF12121F);
  static const Color darkSurfaceBlack = Color(0xFF0F0C14);

  static const Color textPrimary = Color(0xFFE0E0FF);
  static const Color textPrimaryStandard = Color(0xFFFFFFFF);

  static const Color textSecondary = Color(0xFFA0A0C0);
  static const Color textSecondaryStandard = Color(0xFFB3B3B3);

  static const Color textHint = Color(0xFF707090);
  static const Color textHintStandard = Color(0xFF757575);

  static const Color active = primary;

  static const Color inactive = textSecondary;

  static const Color disabled = textHint;

  static const Color divider = Color(0xFF35354A);

  static const Color error = Color(0xFFCF6679);

  static const Color success = Color(0xFF66BB6A);

  static const Color warning = Color(0xFFFFB74D);

  static const Color info = Color(0xFF4FC3F7);

  static Color overlay = textPrimary.withOpacity(0.08);
  static Color selectedOverlay = primary.withOpacity(0.25);
}
