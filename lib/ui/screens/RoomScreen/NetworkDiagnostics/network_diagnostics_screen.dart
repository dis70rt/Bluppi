import 'package:bluppi/application/providers/party/sync_history_provider.dart';
import 'package:bluppi/application/providers/party/sync_provider.dart';
import 'package:bluppi/ui/screens/RoomScreen/NetworkDiagnostics/widgets/chart_container.dart';
import 'package:bluppi/ui/screens/RoomScreen/NetworkDiagnostics/widgets/charts.dart';
import 'package:bluppi/ui/screens/RoomScreen/NetworkDiagnostics/widgets/diagnostic_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NetworkDiagnosticsScreen extends ConsumerWidget {
  const NetworkDiagnosticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(clockDisciplineProvider);
    final history = ref.watch(clockHistoryProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF12121A),
      appBar: AppBar(
        title: const Text(
          'NETWORK DIAGNOSTICS',
          style: TextStyle(
            fontSize: 14,
            letterSpacing: 2,
            color: Colors.cyanAccent,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF181824),
        elevation: 0,
        leading: BackButton(
          color: Colors.cyanAccent,
          onPressed: () => context.pop(),
        ),
        iconTheme: const IconThemeData(color: Colors.cyanAccent),
      ),
      body: history.isEmpty
          ? const Center(
              child: CircularProgressIndicator(color: Colors.cyanAccent),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                DiagnosticPanel(history: history),
                const SizedBox(height: 16),
                ChartContainer(
                  title: 'CLOCK OFFSET (LATENCY)',
                  subtitle:
                      'Target: Stable flatline. Tracks clock distance in ms.',
                  color: Colors.cyanAccent,
                  chart: OffsetChart(history: history),
                ),
                const SizedBox(height: 16),
                ChartContainer(
                  title: 'CLOCK SKEW (DRIFT RATE)',
                  subtitle:
                      'Target: 1.000. Tracks oscillator frequency deviation.',
                  color: Colors.pinkAccent,
                  chart: SkewChart(history: history),
                ),
              ],
            ),
    );
  }
}
