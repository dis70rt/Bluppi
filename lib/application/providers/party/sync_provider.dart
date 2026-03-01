import 'dart:async';
import 'dart:developer';

import 'package:bluppi/application/providers/party/sync_history_provider.dart';
import 'package:bluppi/application/providers/room/current_room_provider.dart';
import 'package:bluppi/application/providers/user/user_provider.dart';
import 'package:bluppi/core/utils/clock_kalman_filter.dart';
import 'package:bluppi/data/grpc/repositories/sync_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clockDisciplineProvider =
    NotifierProvider<ClockDisciplineNotifier, ClockState>(
      ClockDisciplineNotifier.new,
    );

class ClockState {
  final double alpha;
  final double thetaUs;

  ClockState({required this.alpha, required this.thetaUs});
}

class SyncSample {
  final double offset;
  final double delay;
  final int t1;

  SyncSample({required this.offset, required this.delay, required this.t1});
}

class ClockDisciplineNotifier extends Notifier<ClockState> {
  Timer? _timer;
  ClockKalmanFilter? _kalmanFilter;
  bool _isSyncing = false;

  @override
  ClockState build() {
    _initBurst();

    ref.onDispose(() => _timer?.cancel());
    return ClockState(alpha: 1.0, thetaUs: 0);
  }

  Future<SyncSample?> _probe() async {
    final repo = ref.read(syncServiceProvider);
    final currentRoom = ref.read(currentRoomProvider);
    final currentUser = ref.read(userProvider).value;

    final t1 = DateTime.now().microsecondsSinceEpoch;
    final res = await repo.sync(t1, currentRoom?.id ?? '', currentUser?.id ?? '');
    final t4 = DateTime.now().microsecondsSinceEpoch;

    final t2 = res.serverReceiveUs;
    final t3 = res.serverSendUs;

    final delay = ((t2 - t1) + (t4 - t3)) / 2;
    final offset = ((t2 - t1) - (t4 - t3)) / 2;

    return SyncSample(offset: offset, delay: delay, t1: t1);
  }

  void _initBurst() async {
    log('Starting sync burst (10 probes)...', name: 'Bluppi.Sync');
    final samples = <SyncSample>[];

    for (int i = 0; i < 10; i++) {
      final sample = await _probe();
      if (sample != null) samples.add(sample);
      await Future.delayed(const Duration(milliseconds: 50));
    }

    if (samples.isEmpty) return;

    samples.sort((a, b) => a.delay.compareTo(b.delay));
    final best = samples.first;

    _kalmanFilter = ClockKalmanFilter(
      initialOffset: best.offset,
      initialTime: best.t1,
    );

    _updateKalmanEstimator(best, isInitial: true);
    _startPeriodic();
  }

  void _updateKalmanEstimator(SyncSample sample, {bool isInitial = false}) {
    if (isInitial || _kalmanFilter == null) {
      state = ClockState(alpha: 1.0, thetaUs: sample.offset);
    } else {
      state = _kalmanFilter!.update(sample.offset, sample.t1);
    }

    ref.read(clockHistoryProvider.notifier).addState(state);
    log('Updated clock discipline: alpha=${state.alpha.toStringAsFixed(3)}, thetaUs=${state.thetaUs.toStringAsFixed(2)}µs, delay=${sample.delay.toStringAsFixed(2)}ms', name: 'Bluppi.Sync');
  }

  void _startPeriodic() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _sync();
    });
  }

  Future<void> _sync() async {
    if (_isSyncing) return;
    _isSyncing = true;

    try {
      final sample = await _probe();
      if (sample != null) {
        _updateKalmanEstimator(sample);
      }
    } finally {
      _isSyncing = false;
    }
  }
}
