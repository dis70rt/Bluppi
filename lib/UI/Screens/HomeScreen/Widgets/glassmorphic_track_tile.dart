import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:synqit/Constants/colors.dart';
import 'package:synqit/Data/Models/track_model.dart';

class GrassmorphicTrackTile extends StatelessWidget {
  const GrassmorphicTrackTile({
    super.key,
    required this.track,
    required this.onTap,
    this.isCurrent = false,
  });

  final Track track;
  final VoidCallback onTap;
  final bool isCurrent;

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
                      ClipRRect(borderRadius: BorderRadius.circular(8), child: CachedNetworkImage(imageUrl: track.imageUrl, height: 45)),
                      // if (isCurrent)
                      //   const Icon(Icons.play_arrow_rounded,
                      //       color: AppColors.accent, size: 24)
                      // else
                        
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