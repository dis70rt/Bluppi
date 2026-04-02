import 'dart:developer';

import 'package:bluppi/application/providers/user/profile_provider.dart';
import 'package:bluppi/core/utils/error_scaffold.dart';
import 'package:bluppi/ui/screens/ProfileScreen/profile_screen_skeleton.dart';
import 'package:bluppi/ui/screens/ProfileScreen/user_not_found.dart';
import 'package:bluppi/ui/screens/ProfileScreen/widgets/profile_app_bar.dart';
import 'package:bluppi/ui/screens/ProfileScreen/widgets/profile_content.dart';
import 'package:bluppi/ui/screens/ProfileScreen/widgets/top_tracks_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';

class ProfileScreen extends ConsumerWidget {
  final String? username;
  const ProfileScreen({super.key, this.username});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider(username));

    return profileAsync.when(
      data: (profile) {
        if (profile.user == null) {
          return const UserNotFoundScreen();
        }
        final user = profile.user!;
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Stack(
                  children: [
                    ProfileAppBar(profilePic: user.profilePic),
                    Padding(
                      padding: const EdgeInsets.only(top: 85),
                      child: ProfileContent(profile: profile),
                    ),
                  ],
                ),
                Expanded(
                  child: TopTracksSection(userId: user.id),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const ProfileScreenSkeleton(),
      error: (error, stackTrace) {
        if (error is GrpcError && error.code == StatusCode.notFound) {
          log("User not found: ${error.codeName}");
          return const UserNotFoundScreen();
        }
        return ScaffoldError(
          message: "Error loading profile: $error",
          onRetry: () => ref.refresh(profileProvider(username)),
        );
      },
    );
  }
}
