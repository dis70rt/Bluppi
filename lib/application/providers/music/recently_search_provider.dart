import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final recentlySearchProvider =
    AsyncNotifierProvider<RecentlySearchNotifier, List<String>>(
  RecentlySearchNotifier.new,
);


class RecentlySearchNotifier extends AsyncNotifier<List<String>> {
  static const _key = 'recently_searches';

  @override
  Future<List<String>> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  Future<void> add(String query) async {
    if (query.trim().isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    final current = List<String>.from(state.value ?? []);

    current.remove(query);
    current.insert(0, query);

    if (current.length > 10) {
      current.removeRange(10, current.length);
    }

    await prefs.setStringList(_key, current);
    state = AsyncData(current);
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
    state = const AsyncData([]);
  }
}
