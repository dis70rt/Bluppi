import 'package:bluppi/application/providers/follow_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FollowButton extends ConsumerWidget {
  final FollowStatsNotifier followNotifier;
  final bool isOwnProfile;
  final VoidCallback? onFollowTap;

  const FollowButton({
    super.key,
    required this.followNotifier,
    required this.isOwnProfile,
    this.onFollowTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final glassColor = Colors.white.withAlpha(20);
    final activeColor = const Color(0xFF2D3BFF);
    //TODO: Later Implement the backend logic onTap of the buttons

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isOwnProfile) ...[
          Expanded(
            child: _buildActionButton(
              context,
              label: "Edit Profile",
              backgroundColor: glassColor,
              textColor: Colors.white,
              onTap: () {
                //TODO: Navigate to Edit Profile
              },
            ),
          ),
          const SizedBox(width: 8),
          _buildCircularIconButton(
            icon: Icons.settings_outlined,
            backgroundColor: glassColor,
            onTap: () {
              // Open Settings
            },
          ),
        ] else ...[
          FutureBuilder(
            future: followNotifier.isFollowing(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 44,
                  child: Center(
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }

              if (snapshot.hasError) {
                return const SizedBox(
                  height: 44,
                  child: Center(
                    child: Icon(Icons.error_outline, color: Colors.redAccent),
                  ),
                );
              }

              if (!snapshot.hasData) {
                return const SizedBox(
                  height: 44,
                  child: Center(
                    child: Icon(Icons.error_outline, color: Colors.redAccent),
                  ),
                );
              }

              final isFollowing = snapshot.data!;

              return Expanded(
                child: _buildActionButton(
                  context,
                  label: isFollowing ? "Following" : "Follow",
                  backgroundColor: isFollowing ? glassColor : activeColor,
                  textColor: Colors.white,
                  fontWeight: isFollowing ? FontWeight.w600 : FontWeight.bold,
                  onTap: onFollowTap ?? () {},
                ),
              );
            },
          ),
          const SizedBox(width: 8),
          _buildCircularIconButton(
            icon: Icons.mail_outline_rounded,
            backgroundColor: glassColor,
            onTap: () {
              //TODO: Open Chat
            },
          ),
        ],
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required String label,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onTap,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return SizedBox(
      height: 44,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 15, fontWeight: fontWeight),
        ),
      ),
    );
  }

  Widget _buildCircularIconButton({
    required IconData icon,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white, size: 22),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        style: IconButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}
