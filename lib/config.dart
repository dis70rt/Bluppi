class AppConfig {
  static const String grpcServerAddress = String.fromEnvironment(
    'GRPC_SERVER_ADDRESS',
    defaultValue: 'localhost',
  );

  static const int grpcServerPort = int.fromEnvironment(
    'GRPC_SERVER_PORT',
    defaultValue: 50051,
  );
}
