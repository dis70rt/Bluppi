import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget trackLoadingListItem(BuildContext context) {
  const double avatarSize = 50.0;
  const double borderRadius = 12.0;
  const double trailingIconSize = 28.0;

  return Skeletonizer(
    enabled: true,
    effect: ShimmerEffect(
      baseColor: Colors.grey.shade700.withValues(alpha: 0.5),
      highlightColor: Colors.grey.shade600.withValues(alpha: 0.6),
      duration: const Duration(milliseconds: 1200),
    ),
    ignoreContainers: true,
    child: ListTile(
      leading: SizedBox(
        width: avatarSize,
        height: avatarSize,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            width: avatarSize,
            height: avatarSize,
            color: Colors.white,
          ),
        ),
      ),
      title: Text(
        '█' * 20,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.transparent,
            ),
        maxLines: 1,
        overflow: TextOverflow.clip,
      ),
      subtitle: Text(
        '█' * 14,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.transparent,
            ),
        maxLines: 1,
        overflow: TextOverflow.clip,
      ),
      trailing: const CircleAvatar(
        radius: trailingIconSize / 2,
        backgroundColor: Colors.white,
      ),
    ),
  );
}

Widget userLoadingListItem(BuildContext context) {
  const double avatarRadius = 30.0;

  return Skeletonizer(
    enabled: true,
    effect: ShimmerEffect(
      baseColor: Colors.grey.shade700.withValues(alpha: 0.5),
      highlightColor: Colors.grey.shade600.withValues(alpha: 0.6),
      duration: const Duration(milliseconds: 1200),
    ),
    ignoreContainers: true,
    child: Container(
      width: 80,
      margin: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: avatarRadius,
            child: ClipOval(
              child: Image.asset(
                'assets/images/default_profile.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "username",
            style: TextStyle(fontSize: 8),
            maxLines: 1,
            overflow: TextOverflow.clip,
          ),
          const Text(
            "full name",
            style: TextStyle(fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.clip,
          ),
        ],
      ),
    ),
  );
}
