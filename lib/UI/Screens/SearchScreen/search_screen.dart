import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Constants/colors.dart';
import 'package:synqit/UI/Screens/SearchScreen/Tabs/room_search_tab.dart';
import 'package:synqit/UI/Screens/SearchScreen/Tabs/track_search_tab.dart';
import 'package:synqit/UI/Screens/SearchScreen/Tabs/user_search_tab.dart';
import 'package:synqit/UI/Screens/SearchScreen/Widgets/recently_searched_widget.dart';
import 'package:synqit/UI/Screens/SearchScreen/Widgets/search_bar_widget.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(searchQueryProvider);
    final showSearchHistory = searchQuery.isEmpty;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: SearchBarWidget(
          onSearch: (query) {
            ref.read(searchQueryProvider.notifier).state = query;
          },
        ),
        surfaceTintColor: Colors.transparent,
        bottom: showSearchHistory
            ? null
            : PreferredSize(
                preferredSize: const Size.fromHeight(kTextTabBarHeight),
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: AppColors.accent,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white54,
                  tabs: const [
                    Tab(text: "Tracks"),
                    Tab(text: "Users"),
                    Tab(text: "Rooms"),
                  ],
                ),
              ),
      ),
      body: Column(
        children: [
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.05),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: showSearchHistory
                  ? RecentSearchesWidget(
                      key: const ValueKey('recent-searches'),
                      onSearchSelect: (query) {
                        ref.read(searchQueryProvider.notifier).state = query;

                        ref
                            .read(searchControllerProvider.notifier)
                            .setText(query);
                      },
                    )
                  : TabBarView(
                      key: const ValueKey('search-results'),
                      controller: _tabController,
                      children: [
                        TracksSearchTab(query: searchQuery),
                        UsersSearchTab(query: searchQuery),
                        RoomsSearchTab(query: searchQuery),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
