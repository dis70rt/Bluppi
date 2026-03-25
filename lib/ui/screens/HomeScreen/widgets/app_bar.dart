import 'package:bluppi/domain/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final UserModel user;
  const HomeAppBar({super.key, required this.user});

  static const double appBarHeight = 80.0;
  static const double avatarRadius = 22.0;
  static const double horizontalPadding = 16.0;

  @override
  Size get preferredSize => const Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      toolbarHeight: appBarHeight,
      backgroundColor: Theme.of(context).colorScheme.surface,
      automaticallyImplyLeading: false,
      titleSpacing: horizontalPadding,
      title: Row(
        children: [
          CircleAvatar(
            radius: avatarRadius,
            backgroundImage: user.profilePic.isNotEmpty
                ? CachedNetworkImageProvider(user.profilePic)
                : const AssetImage('assets/images/default_profile.jpg')
                      as ImageProvider,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome back,",
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: _iconButton(onPressed: () => {}, icon: FontAwesomeIcons.bell),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: _iconButton(onPressed: () => {}, icon: FontAwesomeIcons.users),
        ),
      ],
    );
  }

  Widget _iconButton({
    required void Function() onPressed,
    required FaIconData icon,
    double size = 40.0,
    double iconSize = 14.0,
  }) {
    return SizedBox(
      height: size,
      width: size,
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.withAlpha(51),
          ),
          child: Center(
            child: FaIcon(icon, size: iconSize, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
