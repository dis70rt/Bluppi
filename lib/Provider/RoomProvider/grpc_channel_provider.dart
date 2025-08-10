import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';

// TODO: Uncomment and configure the gRPC channel for production use
final grpcChannelProvider = Provider<ClientChannel>((ref) {
  final channel = ClientChannel(
    'bluppi-grpc.saikat.in',
    // '127.0.0.1',
    port: 443,
    options: ChannelOptions(
      // credentials: ChannelCredentials.insecure(),
      credentials: ChannelCredentials.secure(
        certificates: null,
        authority: 'bluppi-grpc.saikat.in',
        onBadCertificate: (_, __) => true,
      ),
      idleTimeout: Duration(minutes: 5),
    ),
  );

  ref.onDispose(() {
    log('Shutting down gRPC channel');
    channel.shutdown();
  });
  return channel;
});