import 'package:bluppi/application/providers/party/sync_history_provider.dart';
import 'package:bluppi/application/providers/party/sync_provider.dart';
import 'package:bluppi/ui/screens/RoomScreen/NetworkDiagnostics/network_diagnostics_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Room extends ConsumerWidget {
  const Room({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(clockDisciplineProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room'),
        centerTitle: true,
        leadingWidth: 85,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: TextButton(
            onPressed: () {
              // TODO: Leave Room Implementation
              ref.invalidate(clockDisciplineProvider);
              ref.invalidate(clockHistoryProvider);
              context.pop();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Leave',
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(onPressed: () => context.push('/network-diagnostics'), icon: const Icon(Icons.info_outline, color: Colors.blueGrey,)),
        ],
      ),
      body: const Center(child: Text('Room Screen')),
    );
  }
}
