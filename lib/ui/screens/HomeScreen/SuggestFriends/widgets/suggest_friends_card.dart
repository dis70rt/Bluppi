import 'package:bluppi/application/providers/user/follow_provider.dart';
import 'package:bluppi/core/constants/colors.dart';
import 'package:bluppi/domain/models/user_summary_model.dart';
import 'package:bluppi/ui/screens/ProfileScreen/widgets/follow_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuggestFriendsCard extends StatelessWidget {
  final UserSummaryModel user;

  const SuggestFriendsCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/u/${user.username}'),
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: BluppiColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: BluppiColors.divider.withAlpha(80), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: BluppiColors.surfaceRaised,
              backgroundImage: CachedNetworkImageProvider(user.profilePic),
            ),
            const SizedBox(height: 12),
            Text(
              user.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: BluppiColors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 15,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '@${user.username}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: BluppiColors.textSecondary,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: 110,
              height: 30,
              child: FollowButton(args: FollowArg(userId: user.id)),
            ),
          ],
        ),
      ),
    );
  }
}
