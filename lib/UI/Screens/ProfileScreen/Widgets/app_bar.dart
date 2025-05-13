import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:synqit/UI/Widgets/main_screen.dart';

Widget profileAppBar(String? profilePic, BuildContext context, WidgetRef ref) {
  return Positioned(
    top: 0,
    left: 0,
    right: 0,
    height: 130,
    child: Stack(
      fit: StackFit.expand,
      children: [
        profilePic != null && profilePic.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: profilePic,
                fit: BoxFit.cover,
              )
            : Container(color: Colors.grey.shade900),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withOpacity(0),
          ),
        ),
        Container(
          color: Colors.black.withOpacity(0.6),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 0,
          left: 8,
          right: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => ref.read(mainScreenIndexProvider.notifier).state = 0,
              ),
              IconButton(
                icon:
                    const Icon(FontAwesomeIcons.ellipsis, color: Colors.white),
                onPressed: () => context.push('/settings'),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
