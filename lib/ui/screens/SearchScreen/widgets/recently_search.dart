import 'package:bluppi/application/providers/music/recently_search_provider.dart';
import 'package:bluppi/application/providers/music/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecentlySearch extends ConsumerWidget {
  const RecentlySearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentAsync = ref.watch(recentlySearchProvider);

    return recentAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (recent) {
        if (recent.isEmpty) {
          return const SizedBox.shrink();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Recently Searched',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      ref.read(recentlySearchProvider.notifier).clear(),
                  child: const Text('Clear All'),
                ),
              ],
            ),
            Wrap(
              spacing: 8,
              children: recent
                  .map(
                    (query) => ActionChip(
                      label: Text(query),
                      onPressed: () {
                        ref.read(searchTrackProvider.notifier).setQuery(query);
                        ref.read(recentlySearchProvider.notifier).add(query);
                      },
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}
