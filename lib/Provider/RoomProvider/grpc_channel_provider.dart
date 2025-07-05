import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';

final grpcChannelProvider = Provider<ClientChannel>((ref) {
  final channel = ClientChannel(
    '127.0.0.1',
    port: 50051,
    options: const ChannelOptions(
      credentials: ChannelCredentials.insecure(),
      idleTimeout: Duration(minutes: 5),
    ),
  );

  ref.onDispose(() {
    log('Shutting down gRPC channel');
    channel.shutdown();
  });
  return channel;
});