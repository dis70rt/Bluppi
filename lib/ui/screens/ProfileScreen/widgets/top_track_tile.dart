import 'package:bluppi/core/constants/colors.dart';
import 'package:bluppi/domain/models/top_track_entry_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TopTrackTile extends StatelessWidget {
  final TopTrackEntryModel track;
  final int rank;

  const TopTrackTile({
    super.key,
    required this.track,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          // Rank number
          SizedBox(
            width: 28,
            child: Text(
              "$rank",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: rank <= 3
                    ? BluppiColors.primary
                    : BluppiColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Album art
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: track.imageSmall,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: 48,
                height: 48,
                color: BluppiColors.surfaceRaised,
                child: const Icon(
                  Icons.music_note,
                  color: BluppiColors.textDisabled,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Track info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  track.title,
                  style: const TextStyle(
                    color: BluppiColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  track.artist,
                  style: const TextStyle(
                    color: BluppiColors.textSecondary,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Play count
          Text(
            "${track.playCount} plays",
            style: const TextStyle(
              color: BluppiColors.textDisabled,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
