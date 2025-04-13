import 'package:flutter/material.dart';

Widget profileBio(String name, String bio, String? profilePic) {
  return Column(
    children: [
      profilePic != null
          ? CircleAvatar(
              radius: 45,
              backgroundImage: NetworkImage(profilePic),
            )
          : const CircleAvatar(
              radius: 45,
              backgroundImage: AssetImage('assets/images/default_profile.jpg'),
            ),
      const SizedBox(height: 20),
      Text(
        name,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
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
  );
}
