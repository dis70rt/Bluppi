import 'dart:developer';
import 'dart:ui';

import 'package:app_links/app_links.dart';
import 'package:bluppi/Provider/RoomProvider/sync_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bluppi/PubSub/subscriber.dart';
import 'package:bluppi/firebase_options.dart';
import 'package:bluppi/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // await Supabase.initialize(
  //   url: dotenv.env["SUPABASE_URL"]!,
  //   anonKey: dotenv.env["SUPABASE_ANON_KEY"]!,
  // );

  // final container = ProviderContainer();
  // container.read(trackDatabaseSubscriberProvider);
  // container.read(trackHistorySubscriberProvider);
  // container.read(trackSyncSubscriberProvider);

  runApp(ProviderScope(
    // container: container,
    // observers: [],
    // overrides: [
    //   trackDatabaseSubscriberProvider,
    //   trackHistorySubscriberProvider,
    //   trackSyncSubscriberProvider,
    // ],
    child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final AppLinks _appLinks = AppLinks();

  @override
  void initState() {
    super.initState();
    _handleIncomingDeepLinks();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(trackDatabaseSubscriberProvider);
      ref.read(trackHistorySubscriberProvider);
      ref.read(trackSyncSubscriberProvider);
    });
  }

  void _handleIncomingDeepLinks() async {
    final initialUri = await _appLinks.getInitialLink();
    if (initialUri != null) {
      _handleDeepLink(initialUri);
    }

    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleDeepLink(uri);
      }
    });
  }

  void _handleDeepLink(Uri uri) {
    final pathSegments = uri.pathSegments;
    if (pathSegments.isNotEmpty) {
      final username = pathSegments[0];
      log("Deep link received: $username");
      router.go('/$username');
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.read(syncProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // useMaterial3: true,
          ),
      routerConfig: router,
    );
  }
}
