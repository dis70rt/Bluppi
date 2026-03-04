import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String? avatarUrl;

  const AvatarWidget({super.key, required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      margin: const EdgeInsets.only(top: 2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.surface,
      ),
      clipBehavior: Clip.antiAlias,
      child: avatarUrl != null && avatarUrl!.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: avatarUrl!,
              fit: BoxFit.cover,
              memCacheWidth: 124,
              memCacheHeight: 124,
              errorWidget: (context, url, error) =>
                  const Icon(Icons.person, size: 20),
            )
          : Icon(
              Icons.person,
              size: 20,
              color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
            ),
    );
  }
}

class NameAndHostTag extends StatelessWidget {
  final String displayName;
  final bool isHost;

  const NameAndHostTag({
    super.key,
    required this.displayName,
    required this.isHost,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          displayName,
          style: TextStyle(
            color: colorScheme.onSurface.withAlpha(200),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (isHost) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: colorScheme.secondary.withAlpha(30),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: colorScheme.secondary.withAlpha(150),
                width: 0.5,
              ),
            ),
            child: Text(
              'HOST',
              style: TextStyle(
                color: colorScheme.secondary,
                fontSize: 9,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
