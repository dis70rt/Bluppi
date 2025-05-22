import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Constants/colors.dart';
import 'package:synqit/Data/Services/user_services.dart';
import 'package:synqit/Provider/user_provider/follow_provider.dart';
import 'package:synqit/UI/Screens/ProfileScreen/Widgets/follow_tile_skeleton.dart';
import 'package:synqit/UI/Screens/ProfileScreen/Widgets/grassmorphic_user_tile.dart';
import 'package:synqit/UI/Screens/ProfileScreen/profile_screen.dart';
// import 'package:synqit/Provider/follow_provider.dart';
// import 'package:synqit/UI/Screens/ProfileScreen/Widgets/glassmorphic_user_tile.dart';
// import 'package:synqit/UI/Screens/ProfileScreen/Widgets/user_tile_skeleton.dart';

class FollowBottomSheet extends ConsumerStatefulWidget {
  final String userId;
  final int followerCount;
  final int followingCount;
  final int? tabIndex;

  const FollowBottomSheet({
    super.key,
    required this.userId,
    required this.followerCount,
    required this.followingCount,
    this.tabIndex,
  });

  @override
  ConsumerState<FollowBottomSheet> createState() => _FollowBottomSheetState();
}

class _FollowBottomSheetState extends ConsumerState<FollowBottomSheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _followersScrollController = ScrollController();
  final ScrollController _followingScrollController = ScrollController();

  final userServices = UserServices();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 2, vsync: this, initialIndex: widget.tabIndex ?? 0);

    // Load initial followers data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(followersProvider(widget.userId).notifier).loadFollowers();
    });

    // Add scroll listeners
    _followersScrollController.addListener(_onFollowersScroll);
    _followingScrollController.addListener(_onFollowingScroll);

    // Add tab change listener
    _tabController.addListener(_onTabChange);
  }

  void _onTabChange() {
    if (_tabController.index == 1) {
      // Load following data when tab is switched to following
      final followingState = ref.read(followingProvider(widget.userId));
      if (followingState.items.isEmpty && !followingState.isLoading) {
        ref.read(followingProvider(widget.userId).notifier).loadFollowing();
      }
    }
  }

  void _onFollowersScroll() {
    if (_followersScrollController.position.pixels >=
        _followersScrollController.position.maxScrollExtent - 200) {
      ref.read(followersProvider(widget.userId).notifier).loadFollowers();
    }
  }

  void _onFollowingScroll() {
    if (_followingScrollController.position.pixels >=
        _followingScrollController.position.maxScrollExtent - 200) {
      ref.read(followingProvider(widget.userId).notifier).loadFollowing();
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChange);
    _followersScrollController.removeListener(_onFollowersScroll);
    _followingScrollController.removeListener(_onFollowingScroll);
    _followersScrollController.dispose();
    _followingScrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Container(
        color: AppColors.darkSurfaceBlack.withValues(alpha: 0.85),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle indicator
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 14),
                  height: 5,
                  width: 48,
                  decoration: BoxDecoration(
                    color: AppColors.divider.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
              ),

              // Tabs
              TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: 'Followers: ${widget.followerCount}'),
                  Tab(text: 'Following: ${widget.followingCount}'),
                ],
                labelColor: AppColors.textPrimaryStandard,
                unselectedLabelColor: AppColors.textSecondary,
                indicatorColor: AppColors.accent,
              ),

              const Divider(
                  height: 1,
                  thickness: 0.8,
                  indent: 24,
                  endIndent: 24,
                  color: AppColors.divider),

              // Tab content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildFollowersTab(),
                    _buildFollowingTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFollowersTab() {
    final followersState = ref.watch(followersProvider(widget.userId));

    return RefreshIndicator(
      onRefresh: () async {
        await ref
            .read(followersProvider(widget.userId).notifier)
            .loadFollowers(refresh: true);
      },
      child: followersState.items.isEmpty && !followersState.isLoading
          ? const Center(
              child: Text('No followers yet',
                  style: TextStyle(color: AppColors.textSecondary)),
            )
          : ListView(
              controller: _followersScrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                const SizedBox(height: 8),
                ...followersState.items.map((user) => GlassmorphicUserTile(
                      user: user,
                      onTap: () async {
                        final sendUser =
                            await userServices.getUserByID(user.id);
                        Navigator.pop(context);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                              user: sendUser,
                            ),
                          ),
                        );
                      },
                    )),
                if (followersState.isLoading) ..._buildSkeletonLoaders(),
                if (!followersState.hasMore && followersState.items.isNotEmpty)
                  _buildEndOfListIndicator(),
                const SizedBox(height: 24),
              ],
            ),
    );
  }

  Widget _buildFollowingTab() {
    final followingState = ref.watch(followingProvider(widget.userId));

    return RefreshIndicator(
      onRefresh: () async {
        await ref
            .read(followingProvider(widget.userId).notifier)
            .loadFollowing(refresh: true);
      },
      child: followingState.items.isEmpty && !followingState.isLoading
          ? const Center(
              child: Text('Not following anyone yet',
                  style: TextStyle(color: AppColors.textSecondary)),
            )
          : ListView(
              controller: _followingScrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                const SizedBox(height: 8),
                ...followingState.items.map((user) => GlassmorphicUserTile(
                      user: user,
                      onTap: () async {
                        final sendUser =
                            await userServices.getUserByID(user.id);
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                              user: sendUser,
                            ),
                          ),
                        );
                      },
                    )),
                if (followingState.isLoading) ..._buildSkeletonLoaders(),
                if (!followingState.hasMore && followingState.items.isNotEmpty)
                  _buildEndOfListIndicator(),
                const SizedBox(height: 24),
              ],
            ),
    );
  }

  List<Widget> _buildSkeletonLoaders() {
    return List.generate(3, (index) => const UserTileSkeleton());
  }

  Widget _buildEndOfListIndicator() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          'End of list',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
                color: AppColors.textHint,
              ),
        ),
      ),
    );
  }
}
