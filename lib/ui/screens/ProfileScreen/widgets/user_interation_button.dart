// follow_button.dart
import 'package:bluppi/application/providers/user/follow_provider.dart';
import 'package:bluppi/ui/screens/ProfileScreen/widgets/follow_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserInteractionButton extends StatelessWidget {
  final FollowArg followArgs;
  final bool isOwnProfile;

  const UserInteractionButton({
    super.key,
    required this.followArgs,
    required this.isOwnProfile,
  });

  @override
  Widget build(BuildContext context) {
    final glassColor = Colors.white.withAlpha(20);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isOwnProfile) ...[
          Expanded(
            child: _buildActionButton(
              label: "Edit Profile",
              backgroundColor: glassColor,
              textColor: Colors.white,
              onTap: () {}, // TODO: Navigate to Edit Profile
            ),
          ),
          const SizedBox(width: 8),
          _buildCircularIconButton(
            icon: Icons.settings_outlined,
            backgroundColor: glassColor,
            onTap: () => context.push('/settings'), // Open Settings
          ),
        ] else ...[
          
          Expanded(
            child: FollowButton(args: followArgs),
          ),
            
          const SizedBox(width: 8),
          _buildCircularIconButton(
            icon: Icons.mail_outline_rounded,
            backgroundColor: glassColor,
            onTap: () {}, // TODO: Open Chat
          ),
        ],
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback? onTap,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return SizedBox(
      height: 44,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          disabledBackgroundColor: backgroundColor.withAlpha(128),
          disabledForegroundColor: textColor.withAlpha(128),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
      width: 44, height: 44,
      decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(12)),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white, size: 22),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        style: IconButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
      ),
    );
  }
}