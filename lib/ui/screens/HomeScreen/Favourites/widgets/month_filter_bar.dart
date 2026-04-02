import 'package:bluppi/core/constants/colors.dart';
import 'package:bluppi/domain/models/like_track_entry_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:riverpod/riverpod.dart';

class SelectedMonthNotifier extends Notifier<String> {
  @override
  String build() {
    return 'All';
  }

  void setMonth(String newMonth) {
    state = newMonth;
  }
}

final selectedMonthProvider =
    NotifierProvider.autoDispose<SelectedMonthNotifier, String>(
      SelectedMonthNotifier.new,
    );

(Map<String, List<LikedTrackModel>>, List<String>) groupTracks(
  List<LikedTrackModel> tracks,
) {
  Map<String, List<LikedTrackModel>> grouped = {};

  for (var track in tracks) {
    final monthKey = DateFormat('MMM yyyy').format(track.likedAt);
    if (!grouped.containsKey(monthKey)) {
      grouped[monthKey] = [];
    }
    grouped[monthKey]!.add(track);
  }

  return (grouped, ['All', ...grouped.keys]);
}

class MonthFilterBar extends StatelessWidget {
  final List<String> monthKeys;
  final String selectedMonthKey;
  final Function(String) onMonthSelected;

  const MonthFilterBar({
    super.key,
    required this.monthKeys,
    required this.selectedMonthKey,
    required this.onMonthSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: monthKeys.length,
        itemBuilder: (context, index) {
          final monthKey = monthKeys[index];
          final isSelected = selectedMonthKey == monthKey;

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(monthKey),
              selected: isSelected,
              onSelected: (selected) => onMonthSelected(monthKey),
              backgroundColor: BluppiColors.surface,
              selectedColor: BluppiColors.primary.withAlpha(104),
              labelStyle: TextStyle(
                color: isSelected
                    ? BluppiColors.primary
                    : BluppiColors.textSecondary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected
                      ? BluppiColors.primary
                      : BluppiColors.divider,
                ),
              ),
              showCheckmark: false,
            ),
          );
        },
      ),
    );
  }
}
