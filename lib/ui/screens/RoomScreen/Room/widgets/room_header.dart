import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/core/utils/image_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:bluppi/application/providers/user/user_service_provider.dart';

class RoomHeader extends ConsumerWidget {
  final String roomCode;
  final String hostUserId;

  const RoomHeader({
    super.key,
    required this.roomCode,
    required this.hostUserId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncHost = ref.watch(userByIdProvider(hostUserId));

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0), 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          asyncHost.when(
            data: (host) => GestureDetector(
              onTap: () => context.push('/u/${host.username}'),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: getAvatarProvider(host.profilePic),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Hosted by ",
                    style: TextStyle(color: Colors.white54, fontSize: 13),
                  ),
                  Text(
                    '@${host.username}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            error: (_, _) => const Text(
              "Hosted by @unknown",
              style: TextStyle(color: Colors.white54, fontSize: 13),
            ),
            loading: () => Skeletonizer(
              child: Container(
                width: 140,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(25),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          Material(
            color: Colors.white.withAlpha(40),
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: roomCode));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'CODE: ${roomCode.toUpperCase()}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.copy_rounded, // Better suited for modern UI
                      color: Colors.white70,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}