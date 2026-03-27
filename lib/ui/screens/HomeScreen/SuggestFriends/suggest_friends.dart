import 'package:bluppi/core/constants/colors.dart';
import 'package:bluppi/domain/models/user_summary_model.dart';
import 'package:bluppi/ui/screens/HomeScreen/SuggestFriends/suggest_friends_card.dart';
import 'package:flutter/material.dart';

class SuggestFriends extends StatelessWidget {
  const SuggestFriends({super.key});

  @override
  Widget build(BuildContext context) {
    // Top-tier mock data to render the UI before hooking up actual DB provider
    final List<UserSummaryModel> suggestedUsers = [
      UserSummaryModel(
        id: '1',
        username: 'silver_shades_420',
        name: 'Devansh Gupta',
        profilePic: 'https://i.pravatar.cc/150?u=silver_shades_420',
        suggestionReason: 'Based on your music taste',
      ),
      UserSummaryModel(
        id: '2',
        username: 'sanchitkumar_____',
        name: 'Sanchit Kumar',
        profilePic: 'https://i.pravatar.cc/150?u=sanchitkumar_____',
      ),
      UserSummaryModel(
        id: '3',
        username: 'aniisingh69',
        name: 'Anirudh Singh',
        profilePic: 'https://i.pravatar.cc/150?u=aniisingh69',
      ),
      UserSummaryModel(
        id: '3',
        username: 'nikk_goyal',
        name: 'Nikshey Goyal',
        profilePic: 'https://i.pravatar.cc/150?u=nikk_goyal',
      ),
      UserSummaryModel(
        id: '3',
        username: 'pride_guy_67',
        name: 'Bhavesh Manhani',
        profilePic: 'https://i.pravatar.cc/150?u=pride_guy_67',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Suggest Friends',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView.separated(
            // padding: const EdgeInsets.symmetric(horizontal: 16.0),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: suggestedUsers.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return SuggestFriendsCard(user: suggestedUsers[index]);
            },
          ),
        ),
      ],
    );
  }
}