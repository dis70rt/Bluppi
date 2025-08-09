import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bluppi/Constants/colors.dart';

Widget profileBio(String name, String username, bool isOwnProfile, String? profilePic) {
  return Padding(
    padding: const EdgeInsets.only(left: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: 'profilePic',
          child: profilePic != null
              ? CircleAvatar(
                  radius: 45,
                  backgroundImage: CachedNetworkImageProvider(profilePic),
                )
              : const CircleAvatar(
                  radius: 45,
                  backgroundImage:
                      AssetImage('assets/images/default_profile.jpg'),
                ),
        ),
        SizedBox(height: isOwnProfile ? 10 : 0),
    
        Text(
          name,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 0),
        // if (isOwnProfile)
        Text(
          "@$username",
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        // const SizedBox(height: 10),
        
      ],
    ),
  );
}
