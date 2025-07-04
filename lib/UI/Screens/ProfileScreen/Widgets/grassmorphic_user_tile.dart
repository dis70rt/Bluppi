import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bluppi/Constants/colors.dart';
import 'package:bluppi/Data/Models/follower_model.dart';

class GlassmorphicUserTile extends StatelessWidget {
  final FollowUserModel user;
  final VoidCallback onTap;
  final bool isLoading;

  const GlassmorphicUserTile({
    super.key,
    required this.user,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    const tileBaseColor = AppColors.darkSurface;
    const textColor = AppColors.textPrimary;
    const subtitleColor = AppColors.textSecondary;
    const double blurSigma = 6.0;
    const double opacity = 0.15;
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
                color: AppColors.divider.withValues(alpha: 0.4), 
                width: 0.8
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                splashColor: AppColors.primary.withValues(alpha: 0.3),
                highlightColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0, 
                    horizontal: 8.0
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: user.profilePic.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: user.profilePic,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => Container(
                                width: 50,
                                height: 50,
                                color: Colors.grey.shade800,
                                child: const Icon(Icons.person, color: Colors.white70),
                              ),
                            )
                          : Container(
                              width: 50,
                              height: 50,
                              color: Colors.grey.shade800,
                              child: const Icon(Icons.person, color: Colors.white70),
                            ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: textColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "@${user.username}",
                              style: const TextStyle(
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