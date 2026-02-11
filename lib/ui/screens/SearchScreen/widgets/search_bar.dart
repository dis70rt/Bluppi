import 'package:bluppi/application/providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchBarWidget extends ConsumerStatefulWidget {
  const SearchBarWidget({super.key});

  @override
  ConsumerState<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends ConsumerState<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    ref.read(searchTrackProvider.notifier).setQuery(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final searchState = ref.watch(searchTrackProvider);
    final isSearching = searchState.isLoading;

    return Padding(
      padding: const EdgeInsets.all(0),
      child: SearchBar(
        controller: _controller,
        hintText: 'We Don\'t Talk Anymore',
        hintStyle: WidgetStateProperty.all(
          theme.textTheme.bodyLarge!.copyWith(color: theme.colorScheme.onSurfaceVariant.withAlpha(125)),
        ),
        elevation: WidgetStateProperty.all(2),
        backgroundColor:
            WidgetStateProperty.all(theme.colorScheme.surface),
        shadowColor:
            WidgetStateProperty.all(theme.colorScheme.shadow),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Icon(Icons.search),
        ),
        trailing: [
          if (isSearching)
            const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else if (_controller.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _controller.clear();
                setState(() {});
              },
            ),
        ],
        onChanged: _onChanged,
      ),
    );
  }
}
