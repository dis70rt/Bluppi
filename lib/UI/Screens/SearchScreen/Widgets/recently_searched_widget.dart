import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/Provider/UserProvider/search_history_provider.dart';

class RecentSearchesWidget extends ConsumerWidget {
  final Function(String) onSearchSelect;
  
  const RecentSearchesWidget({
    super.key, 
    required this.onSearchSelect,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentSearches = ref.watch(searchHistoryProvider);
    
    if (recentSearches.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 64,
              color: Colors.white.withValues(alpha: 0.2),
            ),
            const SizedBox(height: 16),
            const Text(
              "What are you looking for?",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 18,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recent Searches",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (recentSearches.isNotEmpty)
                TextButton(
                  onPressed: () {
                    ref.read(searchHistoryProvider.notifier).clearSearchHistory();
                  },
                  child: const Text(
                    "Clear all",
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: recentSearches.length,
            itemBuilder: (context, index) {
              final query = recentSearches[index];

              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                leading: const Icon(Icons.history, color: Colors.white54),
                title: Text(
                  query,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.white38, size: 20),
                  onPressed: () {
                    ref.read(searchHistoryProvider.notifier).removeSearchQuery(query);
                  },
                ),
                onTap: () => onSearchSelect(query),
              );
            },
          ),
        ),
      ],
    );
  }
}