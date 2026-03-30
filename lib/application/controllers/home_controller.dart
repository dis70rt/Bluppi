
import 'package:bluppi/application/providers/activity/activity_provider.dart';
import 'package:bluppi/application/providers/music/history_provider.dart';
import 'package:bluppi/application/providers/music/weekly_discover_provider.dart';
import 'package:bluppi/application/providers/user/suggested_friends_provider.dart';
import 'package:bluppi/application/providers/user/user_provider.dart';
import 'package:riverpod/riverpod.dart';

final homeInitController = FutureProvider.autoDispose((ref) async {
  final user = await ref.watch(userProvider.future);

  if(user == null) {
    return null;
  }

  await Future.wait([
    ref.watch(activityProvider.future),
    ref.watch(weeklyDiscoverProvider.future),
    ref.watch(historyProvider.future),
    ref.watch(suggestedUsersProvider.future),
  ]);

  return user;
});