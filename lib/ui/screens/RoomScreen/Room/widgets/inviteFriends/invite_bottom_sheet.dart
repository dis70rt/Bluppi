import 'dart:ui';
import 'package:bluppi/core/constants/colors.dart';
import 'package:bluppi/core/utils/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InviteFriendsBottomSheet extends ConsumerWidget {
  final String inviteLink;

  const InviteFriendsBottomSheet({
    super.key,
    this.inviteLink = 'https://bluppi.app/invite/user123',
  });

  static void show(BuildContext context, {required String roomId}) {
    showModalBottomSheet(
          useRootNavigator: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (_) => InviteFriendsBottomSheet());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final List<Map<String, String>> suggestedFriends = [
      {'name': 'Alex Johnson', 'username': '@alexj', 'image': ''},
      {'name': 'Sarah Smith', 'username': '@sarah_s', 'image': ''},
      {'name': 'Mike Chen', 'username': '@mchen99', 'image': ''},
    ];

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Container(
        color: BluppiColors.surface.withAlpha((0.85 * 255).toInt()),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 14),
                  height: 5,
                  width: 48,
                  decoration: BoxDecoration(
                    color: BluppiColors.divider.withAlpha((0.7 * 255).toInt()),
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 4.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Invite Friends',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: BluppiColors.textPrimary,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.close,
                        color: BluppiColors.textSecondary,
                        size: 24,
                      ),
                      tooltip: 'Close',
                    ),
                  ],
                ),
              ),

              const Divider(
                height: 16,
                thickness: 0.8,
                indent: 24,
                endIndent: 24,
                color: BluppiColors.divider,
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _SectionHeader(
                        title: 'Share Invite Link',
                        color: BluppiColors.textSecondary,
                      ),
                      _ShareLinkBox(inviteLink: inviteLink),

                      const SizedBox(height: 16),

                      const _SectionHeader(
                        title: 'Share Via',
                        color: BluppiColors.textSecondary,
                      ),
                      const _QuickShareAppsRow(),

                      const SizedBox(height: 16),
                      const Divider(
                        height: 1,
                        thickness: 0.5,
                        indent: 24,
                        endIndent: 24,
                        color: BluppiColors.divider,
                      ),

                      const _SectionHeader(
                        title: 'Suggested Friends',
                        color: BluppiColors.textSecondary,
                      ),
                      ...suggestedFriends.map((friend) {
                        return _SuggestedFriendTile(
                          name: friend['name']!,
                          username: friend['username']!,
                          imageUrl: friend['image']!,
                        );
                      }),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final Color color;

  const _SectionHeader({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: 24.0,
        right: 16,
        top: 16,
        bottom: 12,
      ),
      child: Text(
        title,
        style: theme.textTheme.labelLarge?.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _ShareLinkBox extends StatelessWidget {
  final String inviteLink;

  const _ShareLinkBox({required this.inviteLink});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: BluppiColors.divider.withAlpha((0.2 * 255).toInt()),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: BluppiColors.divider.withAlpha((0.5 * 255).toInt()),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                inviteLink,
                style: const TextStyle(
                  color: BluppiColors.textPrimary,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: inviteLink));
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Invite link copied to clipboard'),
                      duration: Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: BluppiColors.accent.withAlpha((0.15 * 255).toInt()),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'COPY',
                  style: TextStyle(
                    color: BluppiColors.accent,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickShareAppsRow extends StatelessWidget {
  const _QuickShareAppsRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _AppShareButton(
            icon: Icons.message_rounded,
            label: 'SMS',
            color: Colors.green,
            onTap: () {
              /* Handle SMS share */
            },
          ),
          _AppShareButton(
            icon: Icons.email_rounded,
            label: 'Email',
            color: Colors.redAccent,
            onTap: () {
              /* Handle Email share */
            },
          ),
          _AppShareButton(
            icon: Icons.link,
            label: 'Copy Link',
            color: Colors.blueGrey,
            onTap: () {
              /* Handle direct copy */
            },
          ),
          _AppShareButton(
            icon: Icons.more_horiz,
            label: 'More',
            color: BluppiColors.textSecondary,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _AppShareButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _AppShareButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: color.withAlpha((0.15 * 255).toInt()),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: BluppiColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _SuggestedFriendTile extends StatelessWidget {
  final String name;
  final String username;
  final String imageUrl;

  const _SuggestedFriendTile({
    required this.name,
    required this.username,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 4.0,
      ),
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: BluppiColors.divider,
        backgroundImage: imageUrl.isNotEmpty ? getAvatarProvider(imageUrl) : null,
        child: imageUrl.isEmpty
            ? Text(
                name.substring(0, 1).toUpperCase(),
                style: const TextStyle(
                  color: BluppiColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
      ),
      title: Text(
        name,
        style: const TextStyle(
          color: BluppiColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        username,
        style: const TextStyle(color: BluppiColors.textSecondary, fontSize: 13),
      ),
      trailing: OutlinedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Invite sent to $name'),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 2),
            ),
          );
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: BluppiColors.accent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        ),
        child: const Text(
          'Invite',
          style: TextStyle(
            color: BluppiColors.accent,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
