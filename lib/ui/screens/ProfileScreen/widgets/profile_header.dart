import 'package:bluppi/application/providers/profile_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileState profile;

  const ProfileHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final user = profile.user!;

    final int age = DateTime.now().year - user.dateOfBirth.year;
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'avatar_${user.username}',
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.surface,
                        width: 4,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                      image: DecorationImage(
                        image: user.profilePic.isNotEmpty
                            ? CachedNetworkImageProvider(user.profilePic)
                            : const AssetImage(
                                    'assets/images/default_profile.jpg',
                                  )
                                  as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      user.gender.toLowerCase() == 'male'
                          ? Icons.male
                          : Icons.female,
                      size: 24,
                      color: user.gender.toLowerCase() == 'male'
                          ? Colors.blueAccent
                          : Colors.pinkAccent,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "@${user.username}",
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.color?.withAlpha(200),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                   _buildDot(context),
                    Text(
                      "$age yrs",
                    ),
                    
                  ],
                ),
                const SizedBox(height: 12),

                Text(
                  user.bio,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: Colors.white.withAlpha(255),
                  ),
                ),
                const SizedBox(height: 16),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: user.favoriteGenres
                      .map<Widget>(
                        (tag) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(25),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            tag,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: 3,
        height: 3,
        decoration: const BoxDecoration(
          color: Colors.white24,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
