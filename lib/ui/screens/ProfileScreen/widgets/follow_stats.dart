// following_stats_widget.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FollowingStatsWidget extends StatelessWidget {
  final String userId;
  final String username;
  final int followers;
  final int following;

  const FollowingStatsWidget({
    super.key,
    required this.userId,
    required this.username,
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
          _statColumn(context, "Followers", followers, 0),
          const SizedBox(width: 20),
          _statColumn(context, "Following", following, 1),
        ],
      ),
    );
  }

  Widget _statColumn(BuildContext context, String title, int count, int tabIndex) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          'network',
          pathParameters: {'userId': userId},
          extra: {
            'username': username,
            'followersCount': followers,
            'followingCount': following,
            'initialTabIndex': tabIndex,
          },
        );
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