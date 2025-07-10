import 'package:bluppi/UI/Screens/HomeScreen/Widgets/recent_track_card.dart';
import 'package:bluppi/UI/Screens/HomeScreen/Widgets/recent_tracks_provider.dart';
import 'package:bluppi/UI/Screens/HomeScreen/Widgets/recentlyplayed_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecentlyPlayedWidget extends ConsumerWidget {
  const RecentlyPlayedWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(recentlyPlayedProvider);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Recently Played',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          if (state.isLoading)
            const RecentlyPlayedProgressIndicator()
          else if (state.error != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                state.error!,
                style: const TextStyle(color: Colors.red),
              ),
            )
          else if (state.tracks.isEmpty)
            const SizedBox(
              height: 100,
              child: Center(
                child: Text('No recently played tracks'),
              ),
            )
          else
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.tracks.length,
                itemBuilder: (context, index) {
                  final historyTrack = state.tracks[index];
                  return RecentTrackCard(historyTrack: historyTrack);
                },
              ),
            ),
        ],
      ),
    );
  }
}
