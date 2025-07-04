import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/UI/Screens/SearchScreen/search_screen.dart';
import 'package:bluppi/UI/Screens/ProfileScreen/other_profile_screen.dart';

class SearchNavigationState {
  final int index;
  final String? selectedUsername;

  SearchNavigationState({required this.index, this.selectedUsername});
}

final searchNavigationProvider =
    StateNotifierProvider<SearchNavigationNotifier, SearchNavigationState>(
        (ref) {
  return SearchNavigationNotifier();
});

class SearchNavigationNotifier extends StateNotifier<SearchNavigationState> {
  SearchNavigationNotifier()
      : super(SearchNavigationState(index: 0, selectedUsername: null));

  void goToSearch() =>
      state = SearchNavigationState(index: 0, selectedUsername: null);

  void goToUserProfile(String username) =>
      state = SearchNavigationState(index: 1, selectedUsername: username);
}

class SearchNavigationScreen extends ConsumerWidget {
  final String? username;

  const SearchNavigationScreen({super.key, this.username});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationState = ref.watch(searchNavigationProvider);
    final currentIndex = navigationState.index;
    final selectedUsername = navigationState.selectedUsername ?? username;

    if (username != null && currentIndex == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(searchNavigationProvider.notifier).goToUserProfile(username!);
      });
    }

    return Scaffold(
      backgroundColor: const Color(0XFF181818),
      body: Stack(
        children: [
          const SearchScreen(),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: currentIndex == 1 ? 0 : MediaQuery.of(context).size.width,
            top: 0,
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Material(
              color: const Color(0XFF181818),
              child: selectedUsername != null
                  ? OtherProfileScreen(
                      username: selectedUsername,
                      onBack: () => ref
                          .read(searchNavigationProvider.notifier)
                          .goToSearch(),
                    )
                  : const Center(
                      child: Text('No user selected',
                          style: TextStyle(color: Colors.white)),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
