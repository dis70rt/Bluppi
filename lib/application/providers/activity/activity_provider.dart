import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/application/providers/activity/activity_linkedlist.dart';
import 'package:bluppi/application/providers/presence/presence_provider.dart';
import 'package:bluppi/data/grpc/repositories/activity_service.dart';
import 'package:bluppi/domain/models/activity_model.dart';

final activityProvider =
    AsyncNotifierProvider<ActivityNotifier, List<ActivityModel>>(() {
      return ActivityNotifier();
    });

class ActivityNotifier extends AsyncNotifier<List<ActivityModel>> {
  final ActivityLinkedList _listManager = ActivityLinkedList();

  @override
  Future<List<ActivityModel>> build() async {
    final repository = ref.read(activityServiceProvider);
    final fetchedActivities = await repository.getFriendsFeed(
      limit: 20,
      offset: 0,
    );

    _listManager.reset(fetchedActivities);

    final friendIds = _listManager.getUserIds;
    if (friendIds.isNotEmpty) {
      ref.read(presenceProvider.notifier).startListening(friendIds);
    }

    ref.listen(presenceProvider, (previous, next) {
      bool stateChanged = false;

      next.forEach((userId, event) {
        if (_listManager.updateStatus(userId, event.status)) {
          stateChanged = true;
        }
      });

      if (stateChanged) {
        state = AsyncData(_listManager.toList());
      }
    });

    return _listManager.toList();
  }

  Future<void> refresh() async {
    ref.invalidateSelf();

    await future;
  }

  Future<void> fetchMore({required int offset, int limit = 20}) async {
    if (state.isLoading || state.hasError) return;

    try {
      final repository = ref.read(activityServiceProvider);
      final moreActivities = await repository.getFriendsFeed(
        limit: limit,
        offset: offset,
      );

      if (moreActivities.isEmpty) return;

      final currentList = _listManager.toList();
      _listManager.reset([...currentList, ...moreActivities]);

      state = AsyncData(_listManager.toList());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
