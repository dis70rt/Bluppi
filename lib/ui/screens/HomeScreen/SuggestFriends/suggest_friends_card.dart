import 'package:bluppi/core/constants/colors.dart';
import 'package:bluppi/domain/models/user_summary_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SuggestFriendsCard extends StatelessWidget {
  final UserSummaryModel user;

  const SuggestFriendsCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140, // Fixed width for horizontal scrolling cards
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
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement follow trigger using Riverpod
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: BluppiColors.primary,
                foregroundColor: BluppiColors.background,
                elevation: 0,
                minimumSize: const Size(double.infinity, 32), // thinner height
                padding: const EdgeInsets.symmetric(vertical: 4),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: const VisualDensity(vertical: -2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Follow',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
