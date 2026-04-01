import 'package:bluppi/application/providers/user/get_follows_provider.dart';
import 'package:bluppi/core/constants/colors.dart';
import 'package:bluppi/ui/screens/ProfileScreen/widgets/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FollowNetworkScreen extends ConsumerStatefulWidget {
  final String userId;
  final String username;
  final int initialFollowersCount;
  final int initialFollowingCount;
  final int initialTabIndex;

  const FollowNetworkScreen({
    super.key,
    required this.userId,
    required this.username,
    required this.initialFollowersCount,
    required this.initialFollowingCount,
    this.initialTabIndex = 0,
  });

  @override
  ConsumerState<FollowNetworkScreen> createState() =>
      _FollowNetworkScreenState();
}

class _FollowNetworkScreenState extends ConsumerState<FollowNetworkScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: widget.initialTabIndex,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            onPressed: () => context.pop(),
          ),
          title: Text(widget.username),
          centerTitle: false,
          bottom: TabBar(
            indicatorColor: BluppiColors.primary,
            labelColor: BluppiColors.textPrimary,
            unselectedLabelColor: BluppiColors.textSecondary,
            dividerColor: BluppiColors.divider,
            tabs: [
              _buildTab(widget.initialFollowersCount, "Followers"),
              _buildTab(widget.initialFollowingCount, "Following"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _FollowersListView(userId: widget.userId),
            _FollowingListView(userId: widget.userId),
          ],
        ),
      ),
    );
  }

  Tab _buildTab(int count, String label) {
    return Tab(
      height: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}

// --- Followers List View ---
class _FollowersListView extends ConsumerWidget {
  final String userId;
  const _FollowersListView({required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(followersProvider(userId));

    return state.when(
      data: (data) {
        if (data.users.isEmpty) {
          return const Center(
            child: Text(
              "No followers yet.",
              style: TextStyle(color: BluppiColors.textSecondary),
            ),
          );
        }

        return NotificationListener<ScrollEndNotification>(
          onNotification: (scrollInfo) {
            if (scrollInfo.metrics.pixels >=
                scrollInfo.metrics.maxScrollExtent - 50) {
              ref.read(followersProvider(userId).notifier).loadMore();
            }
            return true;
          },
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: data.users.length + (data.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              // return const SkeletonUserList();
              if (index == data.users.length) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: BluppiColors.primary,
                    ),
                  ),
                );
              }
              return UserListTile(user: data.users[index]);
            },
          ),
        );
      },
      loading: () => const SkeletonUserList(),
      error: (error, stack) => Center(child: Text("Error: $error")),
    );
  }
}

// --- Following List View ---
class _FollowingListView extends ConsumerWidget {
  final String userId;
  const _FollowingListView({required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(followingsProvider(userId));

    return state.when(
      data: (data) {
        if (data.users.isEmpty) {
          return const Center(
            child: Text(
              "Not following anyone.",
              style: TextStyle(color: BluppiColors.textSecondary),
            ),
          );
        }

        return NotificationListener<ScrollEndNotification>(
          onNotification: (scrollInfo) {
            if (scrollInfo.metrics.pixels >=
                scrollInfo.metrics.maxScrollExtent - 50) {
              ref.read(followingsProvider(userId).notifier).loadMore();
            }
            return true;
          },
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: data.users.length + (data.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == data.users.length) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: BluppiColors.primary,
                    ),
                  ),
                );
              }
              return UserListTile(user: data.users[index]);
            },
          ),
        );
      },
      loading: () => const SkeletonUserList(),
      error: (error, stack) => Center(child: Text("Error: $error")),
    );
  }
}
