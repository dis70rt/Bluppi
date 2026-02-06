import 'package:bluppi/application/providers/auth_provider.dart';
import 'package:bluppi/application/providers/create_profile_provider.dart';
import 'package:bluppi/data/grpc/repositories/user_service_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bluppi'), centerTitle: true),
      body: Center(
        child: MaterialButton(
          onPressed: () async {
            await ref.read(authRepositoryProvider).logOut();
            
            ref.invalidate(userExistsProvider);
            ref.invalidate(authStateProvider);
          },
          child: Text("Sign Out"),
        ),
      ),
    );
  }
}
