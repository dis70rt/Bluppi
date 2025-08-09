import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/UI/Screens/ProfileScreen/Widgets/follow_bottomsheet.dart';

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

  void incrementFollower() {
    state = state.copyWith(followers: state.followers + 1);
  }

  void decrementFollower() {
    state = state.copyWith(followers: state.followers - 1);
  }

  void incrementFollowering() {
    state = state.copyWith(following: state.following + 1);
  }

  void decrementFollowering() {
    state = state.copyWith(following: state.following - 1);
  }

  void loadStats(
      {required int followers,
      required int following,
      required int playlists}) {
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
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _statColumn("Followers", stats.followers, context, ref),
          SizedBox(width: 20),
          // const VerticalDivider(
          //     color: Colors.white30, width: 1, indent: 10, endIndent: 10),
          _statColumn("Following", stats.following, context, ref),
          SizedBox(width: 20),
          // const VerticalDivider(
          //     color: Colors.white30, width: 1, indent: 10, endIndent: 10),
          _statColumn("Playlists", stats.playlists, context, ref),
        ],
      ),
    );
  }

  Future<void> showFollowBottomSheet({
    required BuildContext context,
    required String userId,
    required WidgetRef ref,
    required int tabIndex
  }) {
    final stats = ref.read(followStatsProvider(userId));
    final followerCount = stats.followers;
    final followingCount = stats.following;

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return FollowBottomSheet(
            userId: userId,
            followerCount: followerCount,
            followingCount: followingCount,
            tabIndex: tabIndex,
          );
        },
      ),
    );
  }

  Widget _statColumn(String title, int count, BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        if (title == "Followers" || title == "Following") {
          showFollowBottomSheet(
            context: context,
            userId: userId,
            ref: ref,
            tabIndex: title == "Followers" ? 0 : 1,
          );
        } else {
          // Handle other cases if needed
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            count.toString(),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
