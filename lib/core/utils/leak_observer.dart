import 'dart:developer'; // Import this instead of foundation
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class LeakObserver extends ProviderObserver {
  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    log(
      'CREATED: ${context.provider.name ?? context.provider.runtimeType}',
      name: 'RiverpodLeak',
    );
  }

  @override
  void didDisposeProvider(ProviderObserverContext context) {
    log(
      'DISPOSED: ${context.provider.name ?? context.provider.runtimeType}',
      name: 'RiverpodLeak',
    );
  }
}
