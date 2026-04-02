import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

ImageProvider getAvatarProvider(String profilePic) {
  if (profilePic.isEmpty) {
    return const AssetImage('assets/images/default_profile.jpg');
  }

  if (profilePic.startsWith('http://') || profilePic.startsWith('https://')) {
    return CachedNetworkImageProvider(profilePic);
  } else if (profilePic.startsWith('/')) {
    final file = File(profilePic);
    if (file.existsSync()) {
      return FileImage(file);
    }
  }

  return const AssetImage('assets/images/default_profile.jpg');
}

Widget buildAvatarImage(String? profilePic, {BoxFit fit = BoxFit.cover}) {
  if (profilePic == null || profilePic.isEmpty) {
    return Image.asset('assets/images/default_profile.jpg', fit: fit);
  }

  if (profilePic.startsWith('http://') || profilePic.startsWith('https://')) {
    return CachedNetworkImage(
      imageUrl: profilePic,
      fit: fit,
      errorWidget: (context, url, error) => Image.asset('assets/images/default_profile.jpg', fit: fit),
    );
  } else if (profilePic.startsWith('/')) {
    final file = File(profilePic);
    if (file.existsSync()) {
      return Image.file(file, fit: fit);
    }
  }

  return Image.asset('assets/images/default_profile.jpg', fit: fit);
}
