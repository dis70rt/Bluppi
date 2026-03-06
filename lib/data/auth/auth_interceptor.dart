import 'package:firebase_auth/firebase_auth.dart';
import 'package:grpc/grpc.dart';

class AuthInterceptor implements ClientInterceptor {
  
  Future<void> _injectToken(Map<String, String> metadata, String uri) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final token = await user.getIdToken();
      // log('JWT token retrieved for gRPC call to $uri: $token');
      if (token != null) {
        metadata['authorization'] = 'Bearer $token';
      }
    }
  }

  // 2. Intercept standard Unary requests
  @override
  ResponseFuture<R> interceptUnary<Q, R>(
    ClientMethod<Q, R> method,
    Q request,
    CallOptions options,
    ClientUnaryInvoker<Q, R> invoker,
  ) {
    final newOptions = options.mergedWith(
      CallOptions(providers: [_injectToken]),
    );
    
    return invoker(method, request, newOptions);
  }

  // 3. Intercept Streaming requests
  @override
  ResponseStream<R> interceptStreaming<Q, R>(
    ClientMethod<Q, R> method,
    Stream<Q> requests,
    CallOptions options,
    ClientStreamingInvoker<Q, R> invoker,
  ) {
    final newOptions = options.mergedWith(
      CallOptions(providers: [_injectToken]),
    );
    
    return invoker(method, requests, newOptions);
  }
}