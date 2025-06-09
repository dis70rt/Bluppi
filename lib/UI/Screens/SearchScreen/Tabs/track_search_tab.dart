import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Provider/track_search_provider.dart';
import 'package:synqit/UI/Screens/SearchScreen/Widgets/title_track.dart';
import 'package:synqit/UI/Screens/SearchScreen/Widgets/track_loading.dart';

class TracksSearchTab extends ConsumerWidget {
  final String query;

  const TracksSearchTab({super.key, required this.query});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchAsyncValue = ref.watch(trackSearchProvider(query));
    final previousTracks = searchAsyncValue.valueOrNull;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: searchAsyncValue.when(
        loading: () {
          if (previousTracks != null && previousTracks.isNotEmpty) {
            return Stack(
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: previousTracks.length,
                  itemBuilder: (context, index) {
                    final track = previousTracks[index];
                    return Opacity(
                      opacity: 0.7,
                      child: trackListItem(context, track, ref),
                    );
                  },
                ),
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.2),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
      
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) =>
                  trackLoadingListItem(context));
        },
        error: (error, _) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Error searching tracks: $error',
            style: const TextStyle(color: Colors.redAccent),
            textAlign: TextAlign.center,
          ),
        ),
        data: (tracks) {
          if (tracks.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "No results found for '$query'",
                style: const TextStyle(color: Colors.white54),
                textAlign: TextAlign.center,
              ),
            );
          }
      
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: tracks.length,
            itemBuilder: (context, index) {
              final track = tracks[index];
              return trackListItem(context, track, ref);
            },
          );
        },
      ),
    );
  }
}