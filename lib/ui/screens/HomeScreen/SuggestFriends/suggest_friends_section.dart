import 'dart:developer';

import 'package:bluppi/application/providers/user/suggested_friends_provider.dart';
import 'package:bluppi/ui/screens/HomeScreen/SuggestFriends/widgets/suggest_friends_card.dart';
import 'package:bluppi/ui/screens/HomeScreen/SuggestFriends/widgets/suggest_friends_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SuggestFriendSection extends ConsumerWidget {
  const SuggestFriendSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suggestedAsync = ref.watch(suggestedUsersProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Suggest Friends',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 12),

        suggestedAsync.when(
          skipLoadingOnReload: true,
          data: (state) {
            if (state.suggestedFriends.isEmpty) {
              return const SizedBox(
                height: 200,
                child: Center(child: Text("No suggestions right now.")),
              );
            }

            return SizedBox(
              height: 200,
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent - 150) {
                    ref.read(suggestedUsersProvider.notifier).loadMore();
                  }
                  return false;
                },
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),

                  itemCount:
                      state.suggestedFriends.length +
                      (suggestedAsync.isLoading ? 1 : 0),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    if (index == state.suggestedFriends.length) {
                      return const SuggestFriendsCardSkeleton();
                    }

                    return SuggestFriendsCard(
                      user: state.suggestedFriends[index],
                    );
                  },
                ),
              ),
            );
          },
          loading: () => const SuggestFriendsListSkeleton(itemCount: 3),

          error: (error, stackTrace) {
            log("Error loading suggested friends: $error", error: error, stackTrace: stackTrace);
            return SizedBox(
            height: 200,
            child: Center(
              child: Text(
                "Error loading suggestions",
                style: TextStyle(color: Colors.red.shade300),
              ),
            ),
          );
          }
        ),
      ],
    );
  }
}
