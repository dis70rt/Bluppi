import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bluppi/Constants/colors.dart';
import 'package:bluppi/Data/Models/track_model.dart';

class GrassmorphicTrackTile extends StatelessWidget {
  const GrassmorphicTrackTile({
    super.key,
    required this.track,
    required this.onTap,
    this.isCurrent = false,
    this.trailing,
  });

  final Track track;
  final VoidCallback onTap;
  final bool isCurrent;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final tileBaseColor =
        isCurrent ? AppColors.textPrimary : AppColors.darkSurface;

    final textColor =
        isCurrent ? AppColors.textPrimaryStandard : AppColors.textPrimary;

    final subtitleColor =
        isCurrent ? AppColors.textSecondaryStandard : AppColors.textSecondary;

    final double blurSigma = isCurrent ? 10.0 : 6.0;
    final double opacity = isCurrent ? 0.25 : 0.15;
    const double borderRadius = 12.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Container(
            decoration: BoxDecoration(
              color: tileBaseColor.withValues(alpha: opacity),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                  color: AppColors.divider.withValues(alpha: 0.4), width: 0.8),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                splashColor: isCurrent
                    ? AppColors.accent.withValues(alpha: 0.3)
                    : AppColors.primary.withValues(alpha: 0.3),
                highlightColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: track.imageUrl,
                          height: 45,
                          width: 45,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: AppColors.darkSurface,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.music_note,
                              color: AppColors.textSecondary,
                              size: 20,
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: AppColors.darkSurface,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.error_outline,
                              color: Colors.redAccent,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              track.trackName,
                              style: TextStyle(
                                fontWeight: isCurrent
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                fontSize: isCurrent ? 16 : 15,
                                color: textColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              track.artistName,
                              style: TextStyle(
                                fontSize: 13,
                                color: subtitleColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      if (trailing != null) ...[
                        const SizedBox(width: 8),
                        trailing!,
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
