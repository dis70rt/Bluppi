import 'package:bluppi/Data/Models/track_model.dart';
import 'package:bluppi/Provider/RoomProvider/room_service_provider.dart';
import 'package:bluppi/Provider/RoomProvider/room_sync_provider.dart';
import 'package:bluppi/Provider/RoomProvider/sync_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bluppi/Constants/colors.dart';
import 'package:bluppi/Provider/UserProvider/user_provider.dart';
import 'package:bluppi/UI/Screens/HomeScreen/Widgets/app_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userProvider);
    return userAsync.when(
      data: (user) {
        
        if (user == null) context.pushReplacement('/auth');
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: homeAppBar(context, ref),
          body: Center(
            child: 
              FilledButton(onPressed: () {
                
              }, child: Text("Sync Test"))
            ,
          )
        );
      },
      error: (error, stackTrace) => Center(
        child: Text('Error: ${error.toString()}'),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(color: Spotify.primary),
      ),
    );
  }
}
