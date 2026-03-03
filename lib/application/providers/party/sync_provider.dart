import 'dart:async';
import 'dart:developer';

import 'package:bluppi/application/providers/party/sync_history_provider.dart';
import 'package:bluppi/application/providers/room/current_room_provider.dart';
import 'package:bluppi/application/providers/user/user_provider.dart';
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

    try {
      final res = await repo.sync(
        t1,
        currentRoom?.id ?? '',
        currentUser?.id ?? '',
      );

      final t4 = DateTime.now().microsecondsSinceEpoch;

      final t2 = res.serverReceiveUs.toInt();
      final t3 = res.serverSendUs.toInt();

      final delay = ((t4 - t1) - (t3 - t2)) / 2.0;
      final offset = t2 - t1 - delay;

      return SyncSample(offset: offset, delay: delay, t1: t1);
    } catch (e) {
      log('Sync probe failed: $e', name: 'Bluppi.Sync');
      return null;
    }
  }

  void _initBurst() async {
    log('Starting sync burst (Fastest RTT)...', name: 'Bluppi.Sync');
    final samples = <SyncSample>[];

    for (int i = 0; i < 5; i++) {
      final sample = await _probe();
      if (sample != null) samples.add(sample);
      await Future.delayed(const Duration(milliseconds: 100));
    }

    if (samples.isEmpty) return;
    _updateBestEstimate(samples);

    _startPeriodic();
  }

  void _startPeriodic() {
    _timer = Timer.periodic(const Duration(seconds: 30), (_) async {
      await _sync();
    });
  }

  Future<void> _sync() async {
    if (_isSyncing) return;
    _isSyncing = true;

    final samples = <SyncSample>[];
    for (int i = 0; i < 3; i++) {
      final s = await _probe();
      if (s != null) samples.add(s);
      await Future.delayed(const Duration(milliseconds: 50));
    }

    if (samples.isNotEmpty) _updateBestEstimate(samples);

    _isSyncing = false;
  }

  void _updateBestEstimate(List<SyncSample> samples) {
    final validSamples = samples.where((s) => s.delay * 2 < 200).toList();

    final candidates = validSamples.isNotEmpty ? validSamples : samples;

    candidates.sort((a, b) => a.delay.compareTo(b.delay));

    final best = candidates.first;

    double newTheta = best.offset;

    if (state.thetaUs != 0) {
      if (best.delay < 20) {
        newTheta = (best.offset * 0.9) + (state.thetaUs * 0.1);
      } else {
        newTheta = (best.offset * 0.5) + (state.thetaUs * 0.5);
      }
    }

    state = ClockState(alpha: 1.0, thetaUs: newTheta);

    final rtt = (best.delay * 2).toStringAsFixed(1);
    log(
      'Clock Synced: Offset=${newTheta.toStringAsFixed(0)}µs (RTT: ${rtt}ms)',
      name: 'Bluppi.Sync',
    );
    ref.read(clockHistoryProvider.notifier).addState(state);
  }
}
