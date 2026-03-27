import 'package:bluppi/domain/models/room_summary_model.dart';
import 'package:flutter/material.dart';

class RoomTile extends StatelessWidget {
  final RoomSummaryModel room;
  final VoidCallback? onTap;

  const RoomTile({
    super.key, 
    required this.room,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasTrack = room.trackTitle.isNotEmpty;
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        // A sleek, dark gradient background to give it that "club/music room" vibe
        gradient: LinearGradient(
          colors: [
            Colors.grey.shade900,
            Colors.black87,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(77),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap ?? () {
            // TODO: Navigate to active room
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 1. Artwork Section
                _buildArtwork(),
                const SizedBox(width: 16),
                
                // 2. Room Details (Middle column)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Room Name
                      Text(
                        room.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      
                      // Host Name
                      Text(
                        'Hosted by ${room.hostUsername}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      
                      // Optional Track Info (Only shows if a track is playing)
                      if (hasTrack) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.music_note,
                              size: 14,
                              color: theme.primaryColor, // Uses your app's primary color
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                '${room.trackTitle} • ${room.trackArtist}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: theme.primaryColor.withAlpha(230),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                
                // 3. Trailing Indicators (Live badge & Listener count)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (room.isLive) _buildLiveBadge(),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.headset,
                          size: 16,
                          color: Colors.white70,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${room.listenerCount}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the square artwork or a stylized fallback if no URL exists
  Widget _buildArtwork() {
    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade800,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(52),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: room.artworkUrl.isNotEmpty
            ? Image.network(
                room.artworkUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _fallbackArtwork(),
              )
            : _fallbackArtwork(),
      ),
    );
  }

  /// A cool gradient fallback icon when no track is playing yet
  Widget _fallbackArtwork() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple, Colors.indigo],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.graphic_eq, // Equalizer icon fits the "energy" vibe
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }

  /// The pulsating "LIVE" badge
  Widget _buildLiveBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.redAccent.withAlpha(128),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.redAccent, width: 1),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, color: Colors.redAccent, size: 8),
          SizedBox(width: 4),
          Text(
            'LIVE',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}