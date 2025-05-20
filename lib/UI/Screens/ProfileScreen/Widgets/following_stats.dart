import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FollowStats {
  final int followers;
  final int following;
  final int playlists;

  const FollowStats({
    required this.followers,
    required this.following,
    required this.playlists,
  });

  FollowStats copyWith({
    int? followers,
    int? following,
    int? playlists,
  }) {
    return FollowStats(
      followers: followers ?? this.followers,
      following: following ?? this.following,
      playlists: playlists ?? this.playlists,
    );
  }
}

class FollowStatsNotifier extends StateNotifier<FollowStats> {
  FollowStatsNotifier(
      {required int followers, required int following, required int playlists})
      : super(FollowStats(
            followers: followers, following: following, playlists: playlists));

  void incrementFollowers() {
    state = state.copyWith(followers: state.followers + 1);
  }

  void decrementFollowers() {
    state = state.copyWith(followers: state.followers - 1);
  }

  void loadStats({required int followers,required int following,required int playlists}) {
    state = state.copyWith(
      followers: followers,
      following: following,
      playlists: playlists,
    );
  }
}

final followStatsProvider =
    StateNotifierProvider.family<FollowStatsNotifier, FollowStats, String>(
  (ref, userId) =>
      FollowStatsNotifier(followers: 0, following: 0, playlists: 0),
);

class FollowingStatsWidget extends ConsumerWidget {
  final String userId;

  const FollowingStatsWidget({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(followStatsProvider(userId));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _statColumn("Followers", stats.followers),
            const VerticalDivider(
                color: Colors.white30, width: 1, indent: 10, endIndent: 10),
            _statColumn("Following", stats.following),
            const VerticalDivider(
                color: Colors.white30, width: 1, indent: 10, endIndent: 10),
            _statColumn("Playlists", stats.playlists),
          ],
        ),
      ),
    );
  }

  Widget _statColumn(String title, int count) {
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
}
