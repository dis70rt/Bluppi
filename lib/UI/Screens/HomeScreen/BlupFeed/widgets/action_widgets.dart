import 'package:flutter/material.dart';

class BlupEngagement extends StatelessWidget {
  final int likesCount;
  final int commentsCount;
  final int shareCount;
  const BlupEngagement(
      {super.key,
      required this.likesCount,
      required this.commentsCount,
      required this.shareCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _ActionItem(
          icon: Icons.favorite_border,
          count: likesCount,
          onTap: () {},
        ),
        _ActionItem(
          icon: Icons.comment,
          count: commentsCount,
          onTap: () {},
        ),
        _ActionItem(
          icon: Icons.share,
          count: shareCount,
          onTap: () {},
        ),
      ],
    );
  }
}

class _ActionItem extends StatelessWidget {
  final IconData icon;
  final int count;
  final VoidCallback onTap;

  const _ActionItem(
      {required this.icon, required this.count, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.white.withValues(alpha: 0.8)),
            const SizedBox(width: 6),
            Text(count.toString(),
                style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
