import 'package:bluppi/ui/screens/HomeScreen/WeeklyDiscovery/widgets/stacked_track_cards_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/application/providers/music/weekly_discover_provider.dart';
import 'package:bluppi/ui/screens/HomeScreen/WeeklyDiscovery/widgets/stacked_track_cards.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WeeklyDiscovery extends ConsumerWidget {
  const WeeklyDiscovery({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTracks = ref.watch(weeklyDiscoverProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      // spacing: 16,
      children: [
        Text(
          'Weekly Discovery',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        asyncTracks.when(
          data: (tracks) {
            if (tracks.isEmpty) {
              return Text('No tracks discovered this week.');
            }

            return StackedTrackCards(tracks: tracks);
          },
          loading: () => Skeletonizer(
            enabled: true,
            child: const StackedTrackCardsSkeleton(),
          ),
          error: (error, stackTrace) => Text(
            'Error: ${error.toString()}',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
