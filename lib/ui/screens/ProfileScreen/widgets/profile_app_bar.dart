import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileAppBar extends ConsumerWidget {
  final String? profilePic;

  const ProfileAppBar({
    super.key,
    required this.profilePic,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: 130,
      child: Stack(
        fit: StackFit.expand,
        children: [
          profilePic != null && profilePic!.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: profilePic!,
                  fit: BoxFit.cover,
                )
              : Container(color: Colors.grey.shade900),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withAlpha(0),
              ),
            ),
          ),
          Container(
            color: Colors.black.withAlpha(100),
          ),
        ],
      ),
    );
  }
}