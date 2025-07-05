// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:developer';

import 'package:bluppi/Provider/RoomProvider/grpc_channel_provider.dart';
import 'package:bluppi/Provider/RoomProvider/room_service_provider.dart';
import 'package:bluppi/generated/protobuf/streaming.pbgrpc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fixnum/fixnum.dart';

final syncService = Provider<SyncServiceClient>((ref) {
  final channel = ref.watch(grpcChannelProvider);
  return SyncServiceClient(channel);
});

class SyncState {
  final int client_send;
  final int server_receive;
  final int server_send;
  final int client_receive;
  final double offset;

  SyncState({
     this.client_send = 0,
     this.server_receive = 0,
     this.server_send = 0,
     this.client_receive = 0,
     this.offset = 0
  });

  SyncState copyWith({
    int? client_send,
    int? server_receive,
    int? server_send,
    int? client_receive,
    double? offset,
  }) {
    return SyncState(
      client_send: client_send ?? this.client_send,
      server_receive: server_receive ?? this.server_receive,
      server_send: server_send ?? this.server_send,
      client_receive: client_receive ?? this.client_receive,
      offset: offset ?? this.offset,
    );
  }
}

class SyncNotifier extends StateNotifier<SyncState> {
  final SyncServiceClient _sync;
  final Ref _ref;
  Timer? _timer;

  SyncNotifier(this._sync, this._ref) : super(SyncState()) {
    _ref.listen<RoomState>(
      roomProvider,
      (prev, next) {
        if (next.isInRoom) {
          _startSyncing();
        } else {
          _stopSyncing();
        }
      },
      fireImmediately: true,
    );
  }

  void calculateOffset() async {
    final WEIGHT = 0.25;

    final clientSendMs = DateTime.now().millisecondsSinceEpoch;
    final request = SyncRequest(
      clientSendMs: Int64(clientSendMs)
    );

    final response = await _sync.timingSync(request);
    final clientReceiveMs = DateTime.now().millisecondsSinceEpoch;

    final offsetSample = ((response.serverReceiveMs.toInt() - clientSendMs) + (clientReceiveMs - response.serverSendMs.toInt())) / 2;
    final rtt = clientReceiveMs - clientSendMs;

    final offset = WEIGHT * offsetSample + (1 - WEIGHT) * state.offset;

    state = state.copyWith(
      client_send: clientSendMs,
      server_receive: response.serverReceiveMs.toInt(),
      server_send: response.serverSendMs.toInt(),
      client_receive: clientReceiveMs,
      offset: offset
    );

    log(offset.toStringAsFixed(2),name: 'Offset');
  }

  void _startSyncing() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 10), (_) => calculateOffset());
    calculateOffset(); 
  }

  void _stopSyncing() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final syncProvider = StateNotifierProvider<SyncNotifier, SyncState>((ref) {
  final client = ref.watch(syncService);
  return SyncNotifier(client, ref);
});