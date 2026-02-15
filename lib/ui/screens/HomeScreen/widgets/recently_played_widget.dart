import 'package:bluppi/application/providers/music/history_provider.dart';
import 'package:bluppi/ui/screens/HomeScreen/widgets/recent_track_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecentlyPlayedWidget extends ConsumerWidget {
  const RecentlyPlayedWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(historyProvider);

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
          historyAsync.when(
            loading: () => const SizedBox(
              height: 100,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Failed to load history',
                style: const TextStyle(color: Colors.red),
              ),
            ),
            data: (tracks) {
              if (tracks.isEmpty) {
                return const SizedBox(
                  height: 100,
                  child: Center(child: Text('No recently played tracks')),
                );
              }
              return SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tracks.length,
                  itemBuilder: (context, index) {
                    final historyTrack = tracks[index];
                    return RecentTrackCard(historyTrack: historyTrack);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}