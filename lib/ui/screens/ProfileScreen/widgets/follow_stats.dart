import 'package:bluppi/application/providers/user/follow_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FollowingStatsWidget extends ConsumerWidget {
  final String userId;
  final int followers;
  final int following;

  const FollowingStatsWidget({
    super.key,
    required this.userId,
    required this.followers,
    required this.following,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(
      followStatsProvider(
        FollowStats(userId: userId, followers: followers, following: following),
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _statColumn("Followers", stats.followers, context, ref),
              SizedBox(width: 20),
              _statColumn("Following", stats.following, context, ref),
              SizedBox(width: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statColumn(
    String title,
    int count,
    BuildContext context,
    WidgetRef ref,
  ) {
    return GestureDetector(
      onTap: () {},
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
