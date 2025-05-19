import 'package:flutter/material.dart';
import 'package:synqit/Constants/colors.dart';

Widget profileBio(String name, String? bio, String username, bool isOwnProfile) {
  return Center(
    child: Column(
      children: [
        // Hero(
        //   tag: 'profilePic',
        //   child: profilePic != null
        //       ? CircleAvatar(
        //           radius: 45,
        //           backgroundImage: CachedNetworkImageProvider(profilePic),
        //         )
        //       : const CircleAvatar(
        //           radius: 45,
        //           backgroundImage:
        //               AssetImage('assets/images/default_profile.jpg'),
        //         ),
        // ),
        SizedBox(height: isOwnProfile ? 30 : 20),
        if (isOwnProfile)
        Text(
          "@$username",
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        if (bio != null && bio.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              bio,
              style: const TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ],
    ),
  );
}
