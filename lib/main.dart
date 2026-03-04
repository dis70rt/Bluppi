import 'package:audio_service/audio_service.dart';
import 'package:bluppi/app.dart';
import 'package:bluppi/audio/player_handler.dart';
import 'package:bluppi/core/utils/leak_observer.dart';
import 'package:bluppi/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

late final AudioHandler audioHandler;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  audioHandler = await AudioService.init(
    builder: () => PlayerHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.bluppi.audio',
      androidNotificationChannelName: 'Playback',
      androidNotificationOngoing: true,
    ),
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(ProviderScope(observers: [LeakObserver()], child: MyApp()));
}
