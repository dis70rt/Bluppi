import 'package:bluppi/application/providers/user/create_profile_provider.dart';
import 'package:bluppi/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenderSelector extends ConsumerWidget {
  final String? selectedGender;

  const GenderSelector({
    super.key,
    required this.selectedGender,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Gender",
          style: TextStyle(
            color: BluppiColors.textSecondary,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildGenderOption(
              ref: ref,
              icon: Icons.male,
              label: "M",
              value: "male",
              isSelected: selectedGender == "male",
            ),
            const SizedBox(width: 8),
            _buildGenderOption(
              ref: ref,
              icon: Icons.female,
              label: "F",
              value: "female",
              isSelected: selectedGender == "female",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderOption({
    required WidgetRef ref,
    required IconData icon,
    required String label,
    required String value,
    required bool isSelected,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          ref.read(createProfileDataProvider.notifier).updateGender(value);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: BluppiColors.surfaceRaised,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? BluppiColors.primary : BluppiColors.divider,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected
                    ? BluppiColors.primary
                    : BluppiColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? BluppiColors.primary
                      : BluppiColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}