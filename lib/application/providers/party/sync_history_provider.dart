import 'package:bluppi/application/providers/party/sync_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clockHistoryProvider =
    NotifierProvider<ClockHistoryNotifier, List<ClockState>>(
        ClockHistoryNotifier.new);

class ClockHistoryNotifier extends Notifier<List<ClockState>> {
  static const int maxDataPoints = 60;

  @override
  List<ClockState> build() => [];

  void addState(ClockState state) {
    if (this.state.length >= maxDataPoints) {
      this.state = [...this.state.sublist(1), state];
    } else {
      this.state = [...this.state, state];
    }
  }
}