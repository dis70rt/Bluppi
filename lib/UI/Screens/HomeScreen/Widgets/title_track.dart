import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/UI/Screens/HomeScreen/Widgets/track_preview_player.dart';

Widget trackListItem(BuildContext context, Track track) {
  final imageUrl = track.imageUrl;
  final previewUrl = track.previewUrl;
  const double avatarSize = 50.0;

  return ListTile(
    leading: SizedBox(
      width: avatarSize,
      height: avatarSize,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: Colors.white.withOpacity(0.2),
          child: imageUrl.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  width: avatarSize,
                  height: avatarSize,
                  placeholder: (context, url) => const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white54),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) {
                    log("Failed to load image: $imageUrl, Error: $error");
                    return Icon(
                      Icons.music_note,
                      color: Colors.white.withOpacity(0.6),
                      size: avatarSize * 0.6,
                    );
                  },
                )
              : Icon(
                  Icons.music_note,
                  color: Colors.white.withOpacity(0.6),
                  size: avatarSize * 0.6,
                ),
        ),
      ),
    ),
    title: Text(
      track.trackName,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
    subtitle: Text(
      track.artistName,
      style: TextStyle(color: Colors.white.withOpacity(0.8)),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
    trailing: TrackPreviewPlayer(
      previewUrl: previewUrl,
    ),
    onTap: () {
      log("Tapped ListTile: ${track.trackName} by ${track.artistName}");
    },
  );
}
