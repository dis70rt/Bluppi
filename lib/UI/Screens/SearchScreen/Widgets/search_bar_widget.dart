import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Provider/UserProvider/search_history_provider.dart';
import 'package:synqit/UI/Widgets/main_screen.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');
final isSearchingProvider = StateProvider<bool>((ref) => false);

class SearchControllerNotifier extends StateNotifier<TextEditingController> {
  SearchControllerNotifier() : super(TextEditingController());

  void setText(String text) {
    state.text = text;
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }
}

final searchControllerProvider =
    StateNotifierProvider<SearchControllerNotifier, TextEditingController>(
  (ref) => SearchControllerNotifier(),
);

class SearchBarWidget extends ConsumerStatefulWidget {
  final Function(String) onSearch;

  const SearchBarWidget({
    super.key,
    required this.onSearch,
  });

  @override
  ConsumerState<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends ConsumerState<SearchBarWidget> {
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    final controller = ref.read(searchControllerProvider);
    controller.text = ref.read(searchQueryProvider);
    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchTextChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    ref.read(isSearchingProvider.notifier).state = true;
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      final trimmedValue = value.trim();
      ref.read(searchQueryProvider.notifier).state = trimmedValue;
      widget.onSearch(trimmedValue);

      if (trimmedValue.isNotEmpty) {
        ref.read(searchHistoryProvider.notifier).addSearchQuery(trimmedValue);
      }
      ref.read(isSearchingProvider.notifier).state = false;
    });
  }

  void _onSearchSubmitted(String value) {
    _debounce?.cancel();
    final trimmedValue = value.trim();
    ref.read(searchQueryProvider.notifier).state = trimmedValue;
    widget.onSearch(trimmedValue);

    if (trimmedValue.isNotEmpty) {
      ref.read(searchHistoryProvider.notifier).addSearchQuery(trimmedValue);
    }
    ref.read(isSearchingProvider.notifier).state = false;
  }

  @override
  Widget build(BuildContext context) {
    final isSearching = ref.watch(isSearchingProvider);
    final controller = ref.watch(searchControllerProvider);

    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white70,
          onChanged: _onSearchTextChanged,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14.0, horizontal: 0),
            hintText: "Search tracks or people...",
            hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
            prefixIcon: InkWell(
              borderRadius: BorderRadius.circular(30),
              child: const Icon(Icons.arrow_back, color: Colors.white),
              onTap: () => ref.read(mainScreenIndexProvider.notifier).state = 0,
            ),
            suffixIcon: controller.text.isNotEmpty
                ? isSearching
                    ? Container(
                        padding: const EdgeInsets.all(15),
                        width: 20,
                        height: 20,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white70),
                        ),
                      )
                    : IconButton(
                        icon: Icon(Icons.clear,
                            color: Colors.white.withValues(alpha: 0.8)),
                        onPressed: () {
                          controller.clear();
                          _debounce?.cancel();
                          ref.read(searchQueryProvider.notifier).state = '';
                          widget.onSearch('');
                        },
                      )
                : null,
          ),
          onSubmitted: _onSearchSubmitted,
          textInputAction: TextInputAction.search,
        ),
      ),
    );
  }
}
