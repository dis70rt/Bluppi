import 'package:bluppi/ui/screens/HomeScreen/Activity/widgets/activity_item_skeleton.dart';
import 'package:bluppi/ui/screens/HomeScreen/SuggestFriends/widgets/suggest_friends_skeleton.dart';
import 'package:bluppi/ui/screens/HomeScreen/WeeklyDiscovery/widgets/stacked_track_cards_skeleton.dart';
import 'package:bluppi/ui/screens/HomeScreen/shared/app_bar_loading.dart';
import 'package:bluppi/ui/screens/HomeScreen/RecentlyPlayed/widgets/recently_track_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LoadingHome extends StatelessWidget {
  const LoadingHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Skeletonizer(
        enabled: true,
        child: Scaffold(
          appBar: const HomeAppBarSkeleton(),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
              children: [
                ActivityListSkeleton(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Bone.text(
                      words: 2,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    StackedTrackCardsSkeleton(),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 12,
                  children: [
                    Bone.text(
                      words: 2,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RecentlyPlayedListSkeleton(),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 12,
                  children: [
                    Bone.text(
                      words: 2,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SuggestFriendsListSkeleton(),
                  ],
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
