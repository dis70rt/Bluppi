import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Constants/colors.dart';
import 'package:synqit/Provider/user_provider.dart';
import 'package:synqit/UI/Screens/HomeScreen/Widgets/app_bar.dart';

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
        if (user == null) {
          return const Center(child: Text('No user logged in'));
        }
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: homeAppBar(context, ref),
          body: const Column(

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
