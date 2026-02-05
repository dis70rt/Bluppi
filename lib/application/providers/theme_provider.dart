// application/providers/theme_provider.dart
import 'package:bluppi/core/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = Provider<ThemeData>((ref) {
  return BluppiTheme.dark();
});
