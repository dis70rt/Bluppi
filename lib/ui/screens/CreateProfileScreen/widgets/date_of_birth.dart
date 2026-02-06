import 'package:bluppi/application/providers/create_profile_provider.dart';
import 'package:bluppi/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DateOfBirthPicker extends ConsumerWidget {
  final DateTime? dateOfBirth;
  final int? age;

  const DateOfBirthPicker({
    super.key,
    required this.dateOfBirth,
    required this.age,
  });

  Future<void> _showDatePicker(BuildContext context, WidgetRef ref) async {
    final now = DateTime.now();
    final minAge = 13; // Minimum age requirement
    final maxAge = 100;

    final initialDate = dateOfBirth ?? DateTime(now.year - 18, now.month, now.day);
    final firstDate = DateTime(now.year - maxAge);
    final lastDate = DateTime(now.year - minAge, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate.isBefore(lastDate) ? initialDate : lastDate,
      firstDate: firstDate,
      lastDate: lastDate,
      helpText: 'Select your date of birth',
      cancelText: 'Cancel',
      confirmText: 'Confirm',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: BluppiColors.primary,
              onPrimary: BluppiColors.background,
              surface: BluppiColors.surface,
              onSurface: BluppiColors.textPrimary,
            ),
            dialogBackgroundColor: BluppiColors.surface,
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      ref.read(createProfileDataProvider.notifier).updateDateOfBirth(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayText = dateOfBirth != null
        ? DateFormat('dd MMM yyyy').format(dateOfBirth!)
        : 'Select DOB';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Date of Birth",
              style: TextStyle(
                color: BluppiColors.textSecondary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            if (age != null) ...[
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: BluppiColors.primary.withAlpha(51),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "$age yrs",
                  style: const TextStyle(
                    color: BluppiColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _showDatePicker(context, ref),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: BluppiColors.surfaceRaised,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: BluppiColors.divider),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                  color: dateOfBirth != null
                      ? BluppiColors.primary
                      : BluppiColors.textDisabled,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    displayText,
                    style: TextStyle(
                      color: dateOfBirth != null
                          ? BluppiColors.textPrimary
                          : BluppiColors.textDisabled,
                      fontSize: 14,
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: BluppiColors.textDisabled,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}