import 'package:bluppi/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';

final grpcChannelProvider = Provider<ClientChannel>((ref) {
  final channel = ClientChannel(
    AppConfig.grpcServerAddress,
    port: AppConfig.grpcServerPort,
    options: const ChannelOptions(
      credentials: ChannelCredentials.secure(),
    ),
  );

  ref.onDispose(() => channel.shutdown());

  return channel;
});

final gatewayGrpcChannelProvider = Provider<ClientChannel>((ref) {
  final channel = ClientChannel(
    AppConfig.gatewayServerAddress,
    port: AppConfig.gatewayServerPort,
    options: const ChannelOptions(
      credentials: ChannelCredentials.secure(),
      keepAlive: ClientKeepAliveOptions(
        pingInterval: Duration(seconds: 45),
        timeout: Duration(seconds: 15),
        permitWithoutCalls: true
      )
    ),
  );

  ref.onDispose(() => channel.shutdown());

  return channel;
});