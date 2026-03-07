import 'package:bluppi/ui/screens/RoomScreen/Room/widgets/inviteFriends/invite_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InviteFriends extends ConsumerWidget {
  final String roomId;
  const InviteFriends({super.key, required this.roomId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => InviteFriendsBottomSheet.show(context, roomId: roomId),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.share, color: Colors.white70, size: 20),
              const SizedBox(width: 8),
              Text(
                "Invite to Party",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
