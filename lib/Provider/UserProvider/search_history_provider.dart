import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryNotifier extends StateNotifier<List<String>> {
  SearchHistoryNotifier() : super([]) {
    _loadSearchHistory();
  }

  Future<void> _loadSearchHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedSearches = prefs.getStringList('recent_searches') ?? [];
      state = cachedSearches;
    } catch (e) {
      log("Error retrieving recently searched queries: $e");
    }
  }

  Future<void> addSearchQuery(String query) async {
    if (query.trim().isEmpty) {
      log("Skipping empty search query");
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedSearches = [...state];

      cachedSearches.remove(query);
      cachedSearches.insert(0, query);

      if (cachedSearches.length > 10) {
        cachedSearches.removeRange(10, cachedSearches.length);
      }

      await prefs.setStringList('recent_searches', cachedSearches);
      state = cachedSearches;
      log("Successfully saved search query to local storage: $query");
    } catch (e) {
      log("Error saving recently searched query: $e");
    }
  }

  Future<void> removeSearchQuery(String query) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedSearches = [...state];

      cachedSearches.remove(query);
      await prefs.setStringList('recent_searches', cachedSearches);
      state = cachedSearches;

      log("Successfully deleted search query from local storage: $query");
    } catch (e) {
      log("Error deleting search query: $e");
    }
  }

  Future<void> clearSearchHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('recent_searches', []);
      state = [];
      log("Successfully cleared search history");
    } catch (e) {
      log("Error clearing search history: $e");
    }
  }
}

final searchHistoryProvider =
    StateNotifierProvider<SearchHistoryNotifier, List<String>>(
  (ref) => SearchHistoryNotifier(),
);
