import 'package:bluppi/application/providers/activity/activity_provider.dart';
import 'package:bluppi/ui/screens/HomeScreen/Activity/widgets/activity_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:bluppi/domain/models/activity_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'activity_dummy_data.dart';

class ActivityListWidget extends ConsumerWidget {
  final List<ActivityModel>? activities;

  const ActivityListWidget({super.key, this.activities});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncActivities = ref.watch(activityProvider);

    return SizedBox(
      height: 130,
      child: asyncActivities.when(
        data: (activitiesList) {
          if (activitiesList.isEmpty) {
            return const Center(
              child: Text(
                'No recent activity',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            );
          }
          return _buildList(activitiesList);
        },
        loading: () {
          return Opacity(opacity: 0.4, child: _buildList(dummyActivities));
        },
        error: (error, stack) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.grey, size: 28),
                const SizedBox(height: 8),
                Text(
                  'Failed to load activity $error',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                TextButton(
                  onPressed: () =>
                      ref.read(activityProvider.notifier).refresh(),
                  child: const Text('Retry', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildList(List<ActivityModel> items) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemBuilder: (context, index) {
        return ActivityItemWidget(activity: items[index]);
      },
    );
  }
}
