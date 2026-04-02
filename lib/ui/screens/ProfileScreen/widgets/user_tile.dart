import 'package:bluppi/application/providers/user/follow_provider.dart';
import 'package:bluppi/core/constants/colors.dart';
import 'package:bluppi/domain/models/follow_user_entry_model.dart';
import 'package:bluppi/ui/screens/ProfileScreen/widgets/follow_button.dart';
import 'package:bluppi/core/utils/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UserListTile extends StatelessWidget {
  final FollowUserEntryModel user;
  final bool isOwner;

  const UserListTile({
    super.key,
    required this.user,
    this.isOwner = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: BluppiColors.surfaceRaised,
        backgroundImage: getAvatarProvider(user.profilePic),
      ),
      title: Text(
        user.username,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: BluppiColors.textPrimary,
        ),
      ),
      subtitle: Text(
        user.name,
        style: const TextStyle(color: BluppiColors.textSecondary),
      ),
      trailing: isOwner
          ? null
          : FollowButton(args: FollowArg(userId: user.id)),
    );
  }
}

class SkeletonUserList extends StatelessWidget {
  const SkeletonUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            leading: const CircleAvatar(
              radius: 24,
              backgroundColor: BluppiColors.surfaceRaised,
            ),
            title: const Text(
              "LoadingUsername",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: BluppiColors.textPrimary,
              ),
            ),
            subtitle: const Text(
              "Display Name",
              style: TextStyle(color: BluppiColors.textSecondary),
            ),
            trailing: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                minimumSize: Size.zero,
              ),
              child: const Text("Follow"),
            ),
          );
        },
      ),
    );
  }
}
