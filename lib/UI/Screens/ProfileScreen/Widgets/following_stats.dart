import 'package:flutter/material.dart';

Widget followingStats(int followers, int following, int playlistCount) {
  Widget statColumn(String title, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          count.toString(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: Colors.white54),
        ),
      ],
    );
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          statColumn("Followers", followers),
          const VerticalDivider(
              color: Colors.white30, width: 1, indent: 10, endIndent: 10),
          statColumn("Following", following),
          const VerticalDivider(
              color: Colors.white30, width: 1, indent: 10, endIndent: 10),
          statColumn("Playlists", playlistCount),
        ],
      ),
    ),
  );
}
