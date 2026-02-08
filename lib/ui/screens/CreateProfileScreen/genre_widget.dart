import 'package:bluppi/application/providers/create_profile_provider.dart';
import 'package:bluppi/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenreStep extends ConsumerWidget {
  const GenreStep({super.key});

  static const List<String> _availableGenres = [
    "Pop",
    "Hip Hop",
    "Trap",
    "Drill",
    "R&B",
    "Afrobeats",
    "K-Pop",
    "Latin Pop",
    "Reggaeton",
    "Indie Pop",
    "Indie Rock",
    "Electronic",
    "EDM",
    "House",
    "Techno",
    "Lo-Fi",
    "Phonk",
    "Hyperpop",
    "Punjabi",
    "Ambient",
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(createProfileDataProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        const Icon(
          Icons.category_outlined,
          color: BluppiColors.accent,
          size: 60,
        ),
        const SizedBox(height: 20),
        Text(
          "What do you like?",
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(fontSize: 28),
        ),
        const SizedBox(height: 8),
        Text(
          "Pick genres to personalize your feed.",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 40),
        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: _availableGenres.map((genre) {
                final isSelected = data.selectedGenres.contains(genre);
                return GestureDetector(
                  onTap: () {
                    // Use the notifier method to toggle genre
                    ref
                        .read(createProfileDataProvider.notifier)
                        .toggleGenre(genre);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? BluppiColors.primary
                          : BluppiColors.surfaceRaised,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isSelected
                            ? BluppiColors.primary
                            : BluppiColors.divider,
                      ),
                    ),
                    child: Text(
                      genre,
                      style: TextStyle(
                        color: isSelected
                            ? BluppiColors.background
                            : BluppiColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
