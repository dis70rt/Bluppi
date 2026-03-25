import 'package:flutter/material.dart';

class NoteStyle {
  static const bubbleBg = Color(0xFF1C1C1E);
  static const bubbleText = Colors.white;
  static const artistText = Color(0xFFAAAAAA);
  static const musicBarColor = Color(0xFF43D854);
  static const onlineRing = Color(0xFF43D854);
  static const offlineRing = Color(0xFF3A3A3C);

  static const bubbleRadius = BorderRadius.only(
    topLeft: Radius.circular(14),
    topRight: Radius.circular(14),
    bottomRight: Radius.circular(14),
    bottomLeft: Radius.circular(4),
  );

  static const List<String> emptyPlaceholders = [
    "pure silence 🫥",
    "no vibes yet 💀",
    "still loading taste",
    "AUX unplugged 🔇",
    "living in silence",
    "music? never heard",
  ];
}
