import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Data/Services/firebase_services.dart';
import 'package:synqit/Provider/music_provider/music_player_provider.dart';
import 'package:synqit/UI/Widgets/main_screen.dart';
import 'package:synqit/Utils/datetime.dart';

class HistoryTrack {
  final Track track;
  final Timestamp playedAt;

  HistoryTrack({required this.track, required this.playedAt});
}

class HistoryOverlay extends ConsumerStatefulWidget {
  const HistoryOverlay({
    super.key,
    required this.historyItems,
    required this.onDismiss,
  });

  final List<HistoryTrack> historyItems;
  final VoidCallback onDismiss;

  @override
  ConsumerState<HistoryOverlay> createState() => _HistoryOverlayState();
}

class _HistoryOverlayState extends ConsumerState<HistoryOverlay> {
  @override
  Widget build(BuildContext context) {
    final playerNotifier = ref.read(musicPlayerProvider.notifier);
    final firebaseService = FirebaseServices();

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: widget.onDismiss,
            child: Container(color: Colors.black54),
          ),
        ),
        Positioned(
          top: kToolbarHeight + 56,
          left: 16,
          right: 16,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Material(
                color: Colors.white.withValues(alpha: 0.1),
                elevation: 0,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * (widget.historyItems.isEmpty ? 0.2 : 0.5),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: widget.historyItems.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Oops—your play history is empty.',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                TextButton(onPressed: () {
                                  ref.read(mainScreenIndexProvider.notifier).state = 2;
                                  widget.onDismiss();
                                }, child: const Text(
                                  'Explore Music',
                                  // style: TextStyle(color: Colors.white),
                                )),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.history, color: Colors.white70),
                                  SizedBox(width: 8),
                                  Text(
                                    "History",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                    ],
                                  ),
                                  TextButton(

                                    onPressed: () => firebaseService.deleteAllHistoryTracks(),
                                    child: const Text("Clear History"))
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.separated(
                                padding: EdgeInsets.zero,
                                itemCount: widget.historyItems.length,
                                separatorBuilder: (_, __) =>
                                    const Divider(color: Colors.white12),
                                itemBuilder: (context, index) {
                                  final item = widget.historyItems[index];
                                  return ListTile(
                                    tileColor: Colors.transparent,
                                    contentPadding: EdgeInsets.zero,
                                    leading: SizedBox(
                                      height: 45,
                                      width: 45,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl: item.track.imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      item.track.trackName,
                                      style: const TextStyle(color: Colors.white, fontSize: 14),
                                      ),
                                    subtitle:
                                     
                                    Text(
                                      item.track.artistName,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white54,
                                        overflow: TextOverflow.ellipsis
                                      ),
                                    ),
                                    trailing: Text(
                                      formatTimeAgo(item.playedAt),
                                      style: const TextStyle(
                                          color: Colors.white54),
                                    ),
                                    onTap: () => playerNotifier.loadTrack(item.track),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
