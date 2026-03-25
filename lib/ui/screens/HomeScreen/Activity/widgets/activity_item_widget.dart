import 'package:bluppi/domain/models/activity_model.dart';
import 'package:bluppi/ui/screens/HomeScreen/Activity/widgets/avatar_ring.dart';
import 'package:bluppi/ui/screens/HomeScreen/Activity/widgets/note_bubble.dart';
import 'package:flutter/material.dart';

class ActivityItemWidget extends StatelessWidget {
  final ActivityModel activity;

  const ActivityItemWidget({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    final isOnline = activity.status.toLowerCase() == 'online';

    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: SizedBox(
        width: 80,
        child: Opacity(
          opacity: isOnline ? 1.0 : 0.45,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 30),

                  AvatarRing(
                    avatarUrl: activity.friendAvatarUrl,
                    isOnline: isOnline,
                  ),

                  const SizedBox(height: 6),

                  UserName(name: activity.friendName, isOnline: isOnline),
                ],
              ),

              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: NoteBubble(
                  trackTitle: activity.trackTitle,
                  trackArtist: activity.trackArtist,
                  friendName: activity.friendName,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
