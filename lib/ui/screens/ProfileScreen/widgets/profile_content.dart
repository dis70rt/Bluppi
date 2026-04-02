import 'package:bluppi/application/providers/user/follow_provider.dart';
import 'package:bluppi/application/providers/user/profile_provider.dart';
import 'package:bluppi/ui/screens/ProfileScreen/widgets/user_interation_button.dart';
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

    final followArgs = FollowArg(
      userId: user.id,
      initialFollowers: user.followerCount,
      initialFollowing: user.followingCount,
    );

    final followState = ref.watch(followStatsProvider(followArgs));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ProfileHeader(profile: profile),
          FollowingStatsWidget(
            userId: user.id,
            username: user.username,
            followers: followState.followers ?? user.followerCount,
            following: followState.following ?? user.followingCount,
          ),
          const SizedBox(height: 16),
          UserInteractionButton(
            followArgs: followArgs,
            isOwnProfile: isOwnProfile,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: Colors.white10),
          ),
        ],
      ),
    );
  }
}