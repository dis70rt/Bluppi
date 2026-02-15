import 'package:bluppi/data/grpc/repositories/stream_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/domain/repositories/stream_repository.dart';

final streamRepositoryProvider = Provider<StreamRepository>((ref) {
  return StreamServiceRepository();
});
