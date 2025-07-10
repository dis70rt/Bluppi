import 'package:bluppi/Provider/MusicProvider/music_player_provider.dart';
import 'package:bluppi/UI/Screens/HomeScreen/Widgets/recent_tracks_provider.dart';
import 'package:bluppi/Utils/datetime.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecentTrackCard extends ConsumerWidget {
  final HistoryTrack historyTrack;
  const RecentTrackCard({super.key, required this.historyTrack});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerNotifier = ref.read(musicPlayerProvider.notifier);
    return SizedBox(
      width: 200,
      height: 100,
      child: InkWell(
        onTap: () => playerNotifier.loadTrack(historyTrack.track),
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: historyTrack.track.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
        
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 100,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.9),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
        
              // Title & subtitle
              Positioned(
                bottom: 8,
                left: 12,
                right: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      historyTrack.track.trackName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        shadows: [Shadow(blurRadius: 4, color: Colors.black45)],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            historyTrack.track.artistName,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              shadows: [
                                Shadow(blurRadius: 4, color: Colors.black45)
                              ],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          formatTimeAgo(historyTrack.playedAt),
                          style: const TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
