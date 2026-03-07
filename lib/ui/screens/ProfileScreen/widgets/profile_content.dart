import 'package:bluppi/application/providers/user/follow_provider.dart';
import 'package:bluppi/application/providers/user/profile_provider.dart';
import 'package:bluppi/ui/screens/ProfileScreen/widgets/follow_button.dart';
import 'package:bluppi/ui/screens/ProfileScreen/widgets/follow_stats.dart';
import 'package:bluppi/ui/screens/ProfileScreen/widgets/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileContent extends ConsumerWidget {
  final ProfileState profile;

  const ProfileContent({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = profile.user!;
    final isOwnProfile = profile.isOwnProfile;

    final initialFollowStats = FollowStats(
      userId: user.id,
      followers: user.followerCount,
      following: user.followingCount,
    );

    final followState = ref.watch(followStatsProvider(initialFollowStats));
    final followNotifier = ref.read(followStatsProvider(initialFollowStats).notifier);

    return RefreshIndicator(
      onRefresh: () async {
        // ignore: unused_result
        await ref.refresh(profileProvider(user.username).future);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ProfileHeader(profile: profile),
              FollowingStatsWidget(
                followers: followState.followers,
                following: followState.following,
              ),
              const SizedBox(height: 16),
              FollowButton(
                followState: followState,
                isOwnProfile: isOwnProfile,
                onFollowTap: () => followNotifier.toggleFollow(),
              ),
              
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(color: Colors.white10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}