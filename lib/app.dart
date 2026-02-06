// app.dart
import 'package:bluppi/application/providers/onboarding_provider.dart';
import 'package:bluppi/application/providers/theme_provider.dart';
import 'package:bluppi/data/auth/auth_life_cycle.dart';
import 'package:bluppi/navigation/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authLifecycleListenerProvider);
    final router = ref.watch(goRouterProvider);
    final theme = ref.watch(themeProvider);
    ref.read(imagesPreloadedProvider.notifier).preloadImages(context);

    return MaterialApp.router(
      routerConfig: router,
      title: 'Bluppi',
      theme: theme,
    );
  }
}
