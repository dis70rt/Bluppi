import 'package:bluppi/application/providers/user/profile_provider.dart';
import 'package:bluppi/core/utils/error_scaffold.dart';
import 'package:bluppi/ui/screens/ProfileScreen/widgets/profile_app_bar.dart';
import 'package:bluppi/ui/screens/ProfileScreen/widgets/profile_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  final String? username;
  const ProfileScreen({super.key, this.username});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider(username));

    return profileAsync.when(
      data: (profile) {
        if (profile.user == null) {
          return const Scaffold(body: Center(child: Text('User not found')));
        }
        final user = profile.user!;
        return Scaffold(
          body: Stack(
            children: [
              ProfileAppBar(profilePic: user.profilePic),
              Padding(
                padding: const EdgeInsets.only(top: 85),
                child: ProfileContent(profile: profile),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => ScaffoldError(
        message: "Error loading profile: $error",
        onRetry: () => ref.refresh(profileProvider(username)),
      ),
    );
  }
}
