class AppConfig {
  static const String grpcServerAddress = String.fromEnvironment(
    'GRPC_SERVER_ADDRESS',
    defaultValue: 'localhost',
  );

  static const int grpcServerPort = int.fromEnvironment(
    'GRPC_SERVER_PORT',
    defaultValue: 50051,
  );

  static const String gatewayServerAddress = String.fromEnvironment(
    'GATEWAY_SERVER_ADDRESS',
    defaultValue: 'localhost',
  );

  static const int gatewayServerPort = int.fromEnvironment(
    'GATEWAY_SERVER_PORT',
    defaultValue: 50050,
  );

  static const String audioServerUrl = String.fromEnvironment(
    'AUDIO_SERVER_URL',
    defaultValue: "http://localhost:8001",
  );
}
