import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:synqit/Provider/user_provider.dart';

Widget iconButton(
    {required void Function() onPressed,
    required IconData icon,
    double size = 40.0,
    double iconSize = 20.0}) {
  return SizedBox(
    height: size,
    width: size,
    child: InkWell(
      onTap: onPressed,
      customBorder: const CircleBorder(),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withOpacity(0.2),
        ),
        child: Center(
          child: FaIcon(
            icon,
            size: iconSize,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}

PreferredSizeWidget homeAppBar(BuildContext context, WidgetRef ref) {
  final userAsync = ref.watch(userProvider);

  const double appBarHeight = 80.0;
  const Color appBarColor = Colors.black;
  const double avatarRadius = 22.0;
  const double horizontalPadding = 16.0;

  return PreferredSize(
    preferredSize: const Size.fromHeight(appBarHeight),
    child: userAsync.when(
      data: (user) {
        if (user == null) {
          return AppBar(
            toolbarHeight: appBarHeight,
            backgroundColor: appBarColor,
            title: const Text("Welcome!"),
          );
        }

        return AppBar(
          toolbarHeight: appBarHeight,
          backgroundColor: appBarColor,
          automaticallyImplyLeading: false,
          titleSpacing: horizontalPadding,
          title: Row(
            children: [
              CircleAvatar(
                radius: avatarRadius,
                backgroundImage:
                    user.profilePic != null && user.profilePic!.isNotEmpty
                        ? CachedNetworkImageProvider(user.profilePic!)
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
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
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
              child: iconButton(
                onPressed: () async {
                  context.pushNamed("/search");
                } ,
                icon: Icons.search,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: horizontalPadding - 4.0, left: 4.0),
              child: iconButton(
                onPressed: () {
                  print("History tapped");
                },
                icon: Icons.history,
              ),
            ),
          ],
        );
      },
      error: (error, stackTrace) => AppBar(
        toolbarHeight: appBarHeight,
        backgroundColor: Colors.red.shade900,
        title: const Text("Error Loading User"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: "Retry",
            onPressed: () {
              ref.invalidate(userProvider);
            },
          ),
        ],
      ),
      loading: () => AppBar(
        toolbarHeight: appBarHeight,
        backgroundColor: appBarColor,
        automaticallyImplyLeading: false,
        titleSpacing: horizontalPadding,
        title: const Skeletonizer(
          enabled: true,
          child: Row(
            children: [
              CircleAvatar(radius: avatarRadius),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Bone.text(
                      words: 2,
                      style: TextStyle(fontSize: 13),
                    ),
                    SizedBox(height: 2),
                    Bone.text(
                      words: 1,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: iconButton(onPressed: () {}, icon: Icons.search),
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: horizontalPadding - 4.0, left: 4.0),
            child: iconButton(onPressed: () {}, icon: Icons.history),
          ),
        ],
      ),
    ),
  );
}
