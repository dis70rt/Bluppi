import 'package:bluppi/application/providers/party/sync_provider.dart';
import 'package:bluppi/ui/screens/RoomScreen/NetworkDiagnostics/widgets/mini_stat.dart';
import 'package:flutter/material.dart';

class DiagnosticPanel extends StatelessWidget {
  final List<ClockState> history;

  const DiagnosticPanel({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final current = history.last;

    double minO = double.infinity;
    double maxO = double.negativeInfinity;
    for (var state in history) {
      final ms = state.thetaUs / 1000.0;
      if (ms < minO) minO = ms;
      if (ms > maxO) maxO = ms;
    }
    double jitter = (maxO - minO).abs();
    if (jitter.isInfinite) jitter = 0;

    // Determine Acoustic Status
    String statusStr = "LOCKED";
    Color statusCol = Colors.greenAccent;
    if (jitter > 40) {
      statusStr = "ECHO RISK";
      statusCol = Colors.redAccent;
    } else if (jitter > 15) {
      statusStr = "PHASING";
      statusCol = Colors.orangeAccent;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C28),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withAlpha(13)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: MiniStat(
                  label: 'OFFSET',
                  value: '${(current.thetaUs / 1000).toStringAsFixed(2)} ms',
                  color: Colors.cyanAccent,
                  description: 'The precise time difference (latency) between the server and this local device.',
                ),
              ),
              Container(width: 1, height: 40, color: Colors.white.withAlpha(26)),
              Expanded(
                child: MiniStat(
                  label: 'SKEW',
                  value: current.alpha.toStringAsFixed(6),
                  color: Colors.pinkAccent,
                  description: 'The clock drift rate. 1.000 means the oscillator is perfectly synchronized.',
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: Colors.white10, height: 1),
          ),
          Row(
            children: [
              Expanded(
                child: MiniStat(
                  label: 'JITTER (VAR)',
                  value: '${jitter.toStringAsFixed(2)} ms',
                  color: Colors.amberAccent,
                  description: 'Network stability variance. High jitter forces the audio engine to adjust, causing phasing.',
                ),
              ),
              Container(width: 1, height: 40, color: Colors.white.withAlpha(26)),
              Expanded(
                child: MiniStat(
                  label: 'STATUS',
                  value: statusStr,
                  color: statusCol,
                  description: 'Overall playback synchronization health based on perceptual acoustic limits.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}