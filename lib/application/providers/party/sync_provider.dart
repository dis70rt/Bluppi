import 'dart:async';

import 'package:bluppi/data/grpc/repositories/sync_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clockDisciplineProvider =
    NotifierProvider<ClockDisciplineNotifier, ClockState>(
        ClockDisciplineNotifier.new);

class ClockState {
  final double alpha;
  final double thetaUs;

  ClockState({required this.alpha, required this.thetaUs});
}

class SyncSample {
  final double offset;
  final double delay;
  final int t1;

  SyncSample({
    required this.offset,
    required this.delay,
    required this.t1,
  });
}

class ClockDisciplineNotifier extends Notifier<ClockState> {
  SyncSample? _last;
  Timer? _timer;

  @override
  ClockState build() {
     _initBurst();

    ref.onDispose(() {
      _timer?.cancel();
    });

    return ClockState(alpha: 1.0, thetaUs: 0);
  }

  Future<SyncSample?> _probe() async {
    final repo = ref.read(syncServiceProvider);

    final t1 = DateTime.now().microsecondsSinceEpoch;

    final res = await repo.sync(t1);

    final t4 = DateTime.now().microsecondsSinceEpoch;

    final t2 = res.serverReceiveUs;
    final t3 = res.serverSendUs;

    final delay = ((t2 - t1) + (t4 - t3)) / 2;
    final offset = ((t2 - t1) - (t4 - t3)) / 2;

    return SyncSample(
      offset: offset,
      delay: delay,
      t1: t1,
    );
  }

  void _initBurst() async {
    final samples = <SyncSample>[];
    for (int i = 0; i < 10; i++) {
      final sample = await _probe();
      if (sample != null) {
        samples.add(sample);
      }
    }

    if (samples.isEmpty) return;

    samples.sort((a, b) => a.delay.compareTo(b.delay));
    final best = samples.first;

    _updateEstimator(best);

    _startPeriodic();
  }
  
  void _updateEstimator(SyncSample sample) {
    double alpha = state.alpha;

    if (_last != null) {
      final dTheta = sample.offset - _last!.offset;
      final dTime = sample.t1 - _last!.t1;

      if (dTime != 0) {
        alpha = 1.0 + (dTheta / dTime);
      }
    }

    state = ClockState(
      alpha: alpha,
      thetaUs: sample.offset,
    );

    _last = sample;
  }
  
  void _startPeriodic() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _sync();
    });
  }

  Future<void> _sync() async {
    final sample = await _probe();
    if (sample != null) {
      _updateEstimator(sample);
    }
  }
} 