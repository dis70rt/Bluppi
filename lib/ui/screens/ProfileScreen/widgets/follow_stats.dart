// following_stats_widget.dart
import 'package:flutter/material.dart';

class FollowingStatsWidget extends StatelessWidget {
  final int followers;
  final int following;

  const FollowingStatsWidget({
    super.key,
    required this.followers,
    required this.following,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _statColumn("Followers", followers),
          const SizedBox(width: 20),
          _statColumn("Following", following),
        ],
      ),
    );
  }

  Widget _statColumn(String title, int count) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to followers/following list
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            count.toString(),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(width: 5),
          Text(
            title,
            style: const TextStyle(fontSize: 14, color: Colors.white54),
          ),
        ],
      ),
    );
  }
}