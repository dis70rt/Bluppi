import 'package:bluppi/application/providers/follow_provider.dart';
import 'package:bluppi/application/providers/profile_provider.dart';
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
    final followNotifier = ref.watch(
      followStatsProvider(
        FollowStats(
          userId: user.id,
          followers: user.followerCount,
          following: user.followingCount,
        ),
      ).notifier,
    );

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
                userId: user.id,
                followers: user.followerCount,
                following: user.followingCount,
              ),
              SizedBox(height: 16),
              FollowButton(
                followNotifier: followNotifier,
                isOwnProfile: isOwnProfile,
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

class EditRow extends StatelessWidget {
  const EditRow({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        // Edit profile logic
      },
    );
  }
}

class LastPlayedWidget extends StatelessWidget {
  final String userId;
  const LastPlayedWidget({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TabBarContents extends StatelessWidget {
  const TabBarContents({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
