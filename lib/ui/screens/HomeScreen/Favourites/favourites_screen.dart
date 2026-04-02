import 'package:bluppi/application/providers/music/favorite_tracks_provider.dart';
import 'package:bluppi/core/constants/colors.dart';
import 'package:bluppi/ui/screens/HomeScreen/Favourites/widgets/favorite_skeleton.dart';

import 'package:bluppi/ui/screens/HomeScreen/Favourites/widgets/favorite_track_tile.dart';
import 'package:bluppi/ui/screens/HomeScreen/Favourites/widgets/month_filter_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesScreen extends ConsumerWidget {
  final String userId;
  const FavoritesScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likedTracksAsync = ref.watch(likedTracksProvider(userId));

    final selectedMonthKey = ref.watch(selectedMonthProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: BluppiColors.background,
        appBar: AppBar(
          backgroundColor: BluppiColors.background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: BluppiColors.textPrimary,
              size: 20,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'Favorites',
            style: TextStyle(
              color: BluppiColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: likedTracksAsync.when(
          loading: () => FavoritesSkeleton(),
          error: (err, stack) => Center(
            child: Text(
              'Error: $err',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          data: (stateData) {
            if (stateData.tracks.isEmpty) {
              return const Center(
                child: Text(
                  "No favorites yet!",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
      
            final (groupedTracks, monthKeys) = groupTracks(stateData.tracks);
      
            final displayedTracks = selectedMonthKey == 'All'
                ? stateData.tracks
                : groupedTracks[selectedMonthKey] ?? [];
      
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MonthFilterBar(
                  monthKeys: monthKeys,
                  selectedMonthKey: selectedMonthKey,
                  onMonthSelected: (newMonth) {
                    ref.read(selectedMonthProvider.notifier).setMonth(newMonth);
                  },
                ),
      
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    '${displayedTracks.length} Tracks',
                    style: const TextStyle(
                      color: BluppiColors.textDisabled,
                      fontSize: 12,
                    ),
                  ),
                ),
      
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 100),
                    itemCount:
                        displayedTracks.length +
                        (stateData.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == displayedTracks.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: BluppiColors.primary,
                            ),
                          ),
                        );
                      }
      
                      if (selectedMonthKey == 'All' &&
                          index == displayedTracks.length - 1 &&
                          stateData.hasMore) {
                        Future.microtask(
                          () => ref
                              .read(likedTracksProvider(userId).notifier)
                              .loadMore(),
                        );
                      }
      
                      final track = displayedTracks[index];
                      return FavoriteTrackTile(track: track, onTap: () {});
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
