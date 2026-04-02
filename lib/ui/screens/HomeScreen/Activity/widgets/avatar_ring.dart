import 'package:bluppi/core/constants/colors.dart';
import 'package:bluppi/ui/screens/HomeScreen/Activity/widgets/constants.dart';
import 'package:bluppi/core/utils/image_utils.dart';
import 'package:flutter/material.dart';

class AvatarRing extends StatelessWidget {
  final String avatarUrl;
  final bool isOnline;

  const AvatarRing({super.key, 
    required this.avatarUrl,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isOnline ? NoteStyle.onlineRing : NoteStyle.offlineRing,
          width: 2.0,
        ),
      ),
      child: CircleAvatar(
        radius: 30,
        backgroundImage: getAvatarProvider(avatarUrl),
        backgroundColor: BluppiColors.surface,
      ),
    );
  }
}

class UserName extends StatelessWidget {
  final String name;
  final bool isOnline;

  const UserName({super.key, required this.name, required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Text(
        name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: isOnline ? Colors.white : const Color(0xFF8E8E93),
          letterSpacing: 0.1,
        ),
      ),
    );
  }
}